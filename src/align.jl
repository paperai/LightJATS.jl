using .StringMatch

export align

function align(pdffile::String, xmlfile::String)
    pdcontents = readpdf(pdffile)
    pdchars = filter(c -> isa(c,PDText), pdcontents)
    iddict = Dict{String,Int}()
    pdids = map(x -> get!(iddict,x.c,length(iddict)+1), pdchars)

    xmltree = readjats(xmlfile)
    xmltree = xmltree[findfirst(c -> c.name == "body", xmltree.children)]
    tokenize!(xmltree)
    xmlchars = findall(isempty, xmltree)
    xmlids = map(c -> get!(iddict,string(c.name),length(iddict)+1), xmlchars)
    pairs = lcsmatch(pdids, xmlids)

    for (k,v) in pairs
        push!(pdchars[k].tags, xmlchars[v].name)
    end
    write("c.txt", pdchars)
end

function tokenize!(tree::Tree)
    nodes = findall(isempty, tree)
    dict = Dict(n.parent => n.parent for n in nodes)
    for node in keys(dict)
        children = Tree[]
        for c in node.children
            if isempty(c)
                for char in Vector{Char}(c.name)
                    char == ' ' && continue
                    push!(children, Tree(string(char)))
                end
            else
                push!(children, Tree("[$(c.name)]"))
            end
        end
        setchildren!(node, children)
    end
end
