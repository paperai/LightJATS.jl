using LightJATS
using PDFExtract
using TOML

function create_sample(rootpath::String)
    for file in readdir(rootpath)
        endswith(file,".xml") || continue
        println(file)
        filename = splitext(file)[1]
        xmlpath = joinpath(rootpath, file)
        pdfpath = joinpath(rootpath, "$filename.pdf")
        isfile(pdfpath) || continue

        tree = readjats(xmlpath)
        delete!(tree["body"])

        # remove non-figure floats
        if tree[end].name == "floats-group"
            floatset = Set(["fig","fig-group","table-wrap"])
            floats = Tree[]
            topdown_while(tree[end]) do t
                if t.name in floatset
                    push!(floats, t)
                    false
                else
                    true
                end
            end
            isempty(floats) ? delete!(tree[end]) : setchildren!(tree[end],floats)

            count = 1
            for node in floats
                node.name == "fig" || continue
                imgname = "$(file[1:end-4])_$count.png"
                node.name = "fig img=\"$imgname\""
                count += 1
            end
        end

        dir = "C:/Users/hshindo/Documents/sample_xml4-5/$filename"
        isdir(dir) || mkdir(dir)
        open("$dir/$file","w") do f
            println(f, toxml(tree))
        end
        isfile(pdfpath) && cp(pdfpath,"$dir/$filename.pdf")
        pdftxtpath = joinpath(rootpath, "$filename.pdf.txt")
        if isfile(pdftxtpath)
            cp(pdftxtpath, "$dir/$filename.pdf.txt")
            pdfcontents = readpdftxt(pdftxtpath)
            pdftexts = filter(x -> isa(x,PDFText), pdfcontents)
            rect1 = map(t -> t.font, pdftexts[1:10]) |> PDFExtract.Rectangle
            rect2 = map(t -> t.font, pdftexts[21:30]) |> PDFExtract.Rectangle
            text1 = join(map(t -> t.c, pdftexts[1:10]), "")
            text2 = join(map(t -> t.c, pdftexts[21:30]), "")
            span1 = SpanAnno(1, [rect1], "span1", text1)
            span2 = SpanAnno(1, [rect2], "span2", text2)
            rel = RelationAnno("one-way", [span1,span2], "reation1")
            open("$dir/$filename.anno","w") do f
                d = todict([span1,span2,rel])
                TOML.print(f, d)
            end
            # cp("D:/P12-1046.anno", "$dir/$filename.anno")
        end
        saveimages(pdfpath, options=["-o",dir,"-dpi","200"])
    end
end
#create_sample("C:/Users/hshindo/Desktop/PMC500")
create_sample("D:/PMC500")
