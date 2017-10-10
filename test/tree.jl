workspace()
using PDFParser

function add!(dict, value)
    if haskey(dict, value)
        dict[value] += 1
    else
        dict[value] = 1
    end
end

function test()
    root = "C:/Users/hshindo/Dropbox/research/pdfparsing/data/pmc"
    dicts = Dict{String,Dict{String,Int}}()
    for dir in readdir(root)
        println(dir)
        path = joinpath(root, dir)
        trees = map(x -> parse(Tree,x), open(readlines,path))
        for tree in trees
            front = tree[1]
            front.name == "front" || continue
            #body = tree[2]
            #body.value == "body" || continue
            topdown(front) do t
                haskey(target,t.name) || return
                if haskey(dicts, t.name)
                    d = dicts[t.name]
                else
                    d = Dict{String,Int}()
                    dicts[t.name] = d
                end
                for c in t.children
                    if haskey(d, c.name)
                        d[c.name] += 1
                    else
                        d[c.name] = 1
                    end
                end
            end
        end
        for (k,d) in dicts
            println(k)
            println(d)
        end
    end
end
test()
