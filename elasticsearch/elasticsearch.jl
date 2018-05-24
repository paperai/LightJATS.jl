export esjsons, catxml

using EzXML
using JSON

export arxiv_esjsons

function arxiv_esjson(xmlpath::String)
    xmlstr = open(readstring, xmlpath)
    xmlstr = replace(xmlstr, r"<arXiv .+?>", "<arXiv>")
    xml = parsexml(xmlstr)

    jsons = []
    arxivs = find(xml, "//OAI-PMH/ListRecords/record/metadata/arXiv")
    for arxiv in arxivs
        id = "arxiv" * content(arxiv, "./id")
        dict = Dict()
        dict["pdf"] = "https://arxiv.org/pdf/$id.pdf"
        dict["xml"] = "https://arxiv.org/pdf/$id.pdf"
        dict["pdftxt"] = "https://arxiv.org/pdf/$id.pdf"

        dict["journalTitle"] = "arXiv"
        created = content(arxiv, "./created")
        updated = content(arxiv, "./updated")
        date = isempty(updated) ? created : updated
        dict["year"] = parse(Int, date[1:4])
        dict["articleTitle"] = content(arxiv, "./title")
        dict["authors"] = []
        for author in find(arxiv, "./authors/*")
            keyname = content(author, "./keyname")
            forenames = content(author, "./forenames")
            push!(dict["authors"], "$forenames $keyname")
        end
        dict["abstract"] = replace(content(arxiv,"./abstract"), "\n", " ")
        dict["body"] = ""
        push!(jsons, JSON.json(Dict(id=>dict)))
    end
    jsons
end

function arxiv_esjsons(dirpath::String)
    jsons = []
    for file in readdir(dirpath)
        endswith(file,".xml") || continue
        println(file)
        filename = splitext(file)[1]
        xmlpath = joinpath(dirpath, file)
        append!(jsons, arxiv_esjson(xmlpath))
    end
    open("arxiv.json","w") do f
        for json in jsons
            println(f, json)
        end
    end
end

function esjsons(dirpath::String)
    jsons = []
    for file in readdir(dirpath)
        endswith(file,".xml") || continue
        println(file)
        filename = splitext(file)[1]
        xmlpath = joinpath(dirpath, file)
        json = esjson(xmlpath)
        json == nothing || push!(jsons,json)
    end

    open("sample.json","w") do f
        for json in jsons
            println(f, json)
        end
    end
end

function esjson(xmlpath::String)
    article = root(readxml(xmlpath))
    @assert nodename(article) == "article"
    if countelements(article) < 3
        warn("#xml elements < 3")
        return nothing
    end
    for xpath in [".//inline-formula",".//disp-formula",".//disp-formula-group"]
        nodes = find(article, xpath)
        foreach(unlink!, nodes)
    end

    jsondict = Dict()
    jsondict["pdf"] = "https://cl.naist.jp/~shindo/PMC5000010.pdf"
    jsondict["xml"] = "https://cl.naist.jp/~shindo/PMC5000010.xml"
    jsondict["pdftxt"] = "https://cl.naist.jp/~shindo/PMC5000010.pdf.txt"

    for (key,val) in [
        ("journalTitle", "front/journal-meta/journal-title-group/journal-title"),
        ("year", "front/article-meta/pub-date[1]/year"),
        ("articleTitle", "front/article-meta/title-group/article-title"),
        ("abstract", "front/article-meta/abstract")
        ]
        jsondict[key] = content(article, val)
    end
    jsondict["year"] = parse(Int, jsondict["year"])

    body = find(article, "./body//p")
    isempty(body) && return nothing
    ps = map(nodecontent, body)
    jsondict["body"] = join(ps, " ")

    jsondict["authors"] = []
    for author in find(article,"front/article-meta/contrib-group/contrib[@contrib-type=\"author\"]")
        names = String[]
        for xpath in [".//prefix",".//given-names",".//surname",".//suffix",".//collab"]
            nodes = find(author, xpath)
            isempty(nodes) && continue
            push!(names, nodecontent(nodes[1]))
        end
        push!(jsondict["authors"], join(names," "))
    end

    items = []
    for fig in find(article,".//fig")
        d = Dict()
        d["img"] = "https://raw.githubusercontent.com/paperai/deepscholar/master/logo/deepscholar_logo.png"
        d["label"] = content(fig, "./label")
        d["caption"] = content(fig, "./caption")
        push!(items, d)
    end
    isempty(items) || (jsondict["figs"] = items)

    items = []
    for tablewrap in find(article,".//table-wrap")
        d = Dict()
        d["img"] = "https://raw.githubusercontent.com/paperai/deepscholar/master/logo/deepscholar_logo.png"
        d["label"] = content(tablewrap, "./label")
        d["caption"] = content(tablewrap, "./caption")
        push!(items, d)
    end
    isempty(items) || (jsondict["tables"] = items)

    id = splitext(basename(xmlpath))[1]
    JSON.json(Dict(id => jsondict))
end

function content(node, xpath::String)
    nodes = find(node, xpath)
    isempty(nodes) ? "" : strip(nodecontent(nodes[1]))
end

function catxml(dirpath::String, outfilename::String)
    doc = XMLDocument()
    root = setroot!(doc, ElementNode("OAI-PMH"))
    listrecords = link!(root, ElementNode("ListRecords"))
    for file in readdir(dirpath)
        endswith(file,".xml") || continue
        println(file)
        filename = splitext(file)[1]
        xmlpath = joinpath(dirpath, file)
        xmlstr = open(readstring, xmlpath)
        xmlstr = replace(xmlstr, r"<article .+?>", "<article>")
        println(xmlstr)
        xml = parsexml(xmlstr)
        for r in find(xml, "./OAI-PMH/ListRecords/record")
            unlink!(r)
            link!(listrecords, r)
        end
    end
    write(outfilename, doc)
end
