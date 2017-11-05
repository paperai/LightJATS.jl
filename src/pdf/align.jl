export align

function align(pdffile::String, xmlfile::String)
    pdcontents = readpdf(pdffile)
    pdchars = filter(c -> typeof(c) == PDChar, pdcontents)
    iddict = Dict{String,Int}()
    pdids = map(x -> get!(iddict,x.c,length(iddict)+1), pdchars)

    xmltree = readjats(xmlfile)
    ps = find(t -> t.name == "p", xmltree)
    for p in ps
        xmlchars = Vector{Char}(string(p))
        xmlids = map(c -> get!(iddict,string(c),length(iddict)+1), xmlchars)
        StringMatch.match(pdids, xmlids)
    end
end
