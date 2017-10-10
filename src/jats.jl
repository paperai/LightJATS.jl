export readjats

using LibExpat

struct UnsupportedException <: Exception
    message::String
end

function readjats(path::String)
    try
        xml = xp_parse(open(readstring,path))
        tree = convert(Tree, xml)
        parse_article!(tree)
        return tree
    catch e
        if isa(e, UnsupportedException)
            println(e.message)
            return
        else
            rethrow(e)
        end
    end
end

function Base.convert(::Type{Tree}, etree::ETree)
    t = Tree(etree.name, Tree[], etree.attr)
    for e in etree.elements
        if isa(e, String)
            ismatch(r"^\s*$",e) && continue
            push!(t, Tree(e))
        else
            push!(t, convert(Tree,e))
        end
    end
    t
end

function parse_article!(tree::Tree)
    tree.name = "article"
    tree.attr = nothing
    children = [Tree("front"),Tree("body"),Tree("back"),Tree("floats-group")]
    for c in tree.children
        name = c.name
        if name == "front"
            parse_front!(c)
            children[1] = c
        elseif name == "body"
            parse_body!(c)
            children[2] = c
        elseif name == "back"
            parse_back!(c)
            children[3] = c
        elseif name == "floats-group"
            parse_floats!(c)
            children[4] = c
        end
    end
    setchildren!(tree, children)
    isempty(tree[1]) && throw(UnsupportedException("front not found."))
    isempty(tree[2]) && throw(UnsupportedException("body not found."))

    # Move floating elements to <floats-group>
    dict = Dict(
        t => t for t in
        ["boxed-text","fig","fig-group","table-wrap","table-wrap-group"]
    )
    floats = find(x -> haskey(dict,x.name), tree)
    append!(tree[4], floats)
end

function parse_front!(tree::Tree)
    children = Tree[]
    topdown_filter(tree) do node
        isempty(node) && return false
        name = node.name
        if name == "article-title"
            t = Tree("article-title", Tree(string(node)))
            push!(children, t)
            false
        elseif name == "contrib" && node["contrib-type"] == "author"
            parse_author!(node)
            push!(children, node)
            false
        elseif name == "abstract"
            t = Tree("abstract", Tree(string(node)))
            push!(children, t)
            false
        else
            true
        end
    end
    setchildren!(tree, children)
end

function parse_author!(tree::Tree)
    tree.name = "author"
    tree.attr = nothing
    i = findfirst(c -> c.name == "name", tree.children)
    i == 0 && throw(UnsupportedException(""))
    node = tree[i]
    children = Tree[]
    for name in ("given-names", "prefix", "surname", "suffix")
        i = findfirst(c -> c.name == name, node.children)
        if i > 0
            t = Tree(string(node[i]))
            push!(children, Tree(name,t))
        end
    end
    setchildren!(tree, children)
end

function parse_body!(tree::Tree)
    delnodes = Tree[]
    topdown_filter(tree) do node
        isempty(node) && return true
        haskey(keepdict,node.name) && return true
        if haskey(deldict, node.name)
            push!(delnodes,node)
            return false
        end
        throw(UnsupportedException("$(node.name) is unsupported."))
    end

end

function parse_back!(tree::Tree)
end

function parse_floats!(tree::Tree)
end
