using .StringMatch

export align

function align(pdffile::String, xmlfile::String)
    pdcontents = readpdf(pdffile)
    pdchars = filter(c -> isa(c,PDText), pdcontents)
    iddict = Dict{String,Int}()
    pdids = map(x -> get!(iddict,x.c,length(iddict)+1), pdchars)

    xmltree = readjats(xmlfile)
    xmlchars = Vector{Char}(string(p))
    xmlids = map(c -> get!(iddict,string(c),length(iddict)+1), xmlchars)
    pairs = lcsmatch(pdids, xmlids)

    for (k,v) in pairs
        pdchars[k].tag = xmlchars[v]
    end
end
