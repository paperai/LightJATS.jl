export align

function align(pdffile::String, xmlfile::String)
    pdcontents = readpdf(pdffile)
    pdchars = filter(c -> typeof(c) == PDChar, pdcontents)
    iddict = Dict{String,Int}()
    pdids = map(x -> get!(iddict,x.c,length(iddict)+1), pdchars)

    xmltree = readjats(xmlfile)
    xmlchars = Vector{Char}(string(p))
    xmlids = map(c -> get!(iddict,string(c),length(iddict)+1), xmlchars)
    m = StringMatch.match(pdids, xmlids)

    for (k,v) in m
        pdchars[k].tag = xmlchars[v]
    end
end
