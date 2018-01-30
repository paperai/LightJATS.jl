using .StringMatch

export align

const AlignCount = Dict()

function align(pdftxtfile::String, xmlfile::String)
    pdcontents = readpdftxt(pdftxtfile)
    pdchars = filter(c -> isa(c,PDText), pdcontents)
    iddict = Dict{String,Int}()
    pdids = map(x -> get!(iddict,x.c,length(iddict)+1), pdchars)

    xmltree = readjats(xmlfile)
    xmltree = xmltree[findfirst(c -> c.name == "body", xmltree.children)]
    tokenize!(xmltree)
    xmlchars = findall(isempty, xmltree)
    xmlids = map(c -> get!(iddict,string(c.name),length(iddict)+1), xmlchars)
    pairs = lcsmatch(pdids, xmlids)

    xml2pdf = Dict()
    for (k,v) in pairs
        xml2pdf[v] = k
        push!(pdchars[k].tags, xmlchars[v].name)
    end
    ranges = Dict()
    i = 1
    bottomup(xmltree) do node
        if isempty(node)
            ranges[node] = i:i
            i += 1
        else
            ranges[node] = start(ranges[node[1]]):last(ranges[node[end]])
        end
    end
    for (node,r) in ranges
        i = start(r)
        j = last(r)
        i == j && continue
        haskey(AlignCount,node.name) || (AlignCount[node.name] = [0,0])
        countd = AlignCount[node.name]
        if haskey(xml2pdf,i) && haskey(xml2pdf,j)
            countd[1] += 1
        else
            countd[2] += 1
        end
    end
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
