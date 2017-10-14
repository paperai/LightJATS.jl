export readjats

using LibExpat

struct UnsupportedException <: Exception
    message::String
end

function readjats(path::String)
    try
        xml = xp_parse(open(readstring,path))
        for n in xml["//contrib[@contrib-type=\"author\"]"]
            n.name = "author"
        end
        xpath = """
            front//article-title
            | front//article-title
            | front//author
            | front//author/name/prefix
            | front//author/name/given-names
            | front//author/name/surname
            | front//author/name/suffix
            | //boxed-text
            | //boxed-text/label
            | //boxed-text/caption
            | //code
            | //def-list
            | //def-list/label
            | //def-list/title
            | //def-list/def-item
            | //def-list/def-item/term
            | //def-list/def-item/def
            | //disp-formula
            | //disp-formula//mml:math
            | //disp-formula/label
            | //disp-formula-group/label
            | //disp-formula-group/caption
            | //fig
            | //fig/label
            | //fig/caption
            | //fig-group
            | //fig-group/label
            | //fig-group/caption
            | //list
            | //list/label
            | //list/title
            | //list/list-item
            | //p
            | //sec
            | //sec/label
            | //sec/title
            | //statement
            | //statement/label
            | //statement/title
            | //table
            | //table-wrap
            | //table-wrap/label
            | //table-wrap/caption
            | //table-wrap-group
            | //table-wrap-group/label
            | //table-wrap-group/caption
            """

        dict = Dict()
        for node in xml[xpath]
            dict[node] = node
        end
        tree = convert(Tree, xml, dict)
        setchildren!(tree, filter(!isempty,tree.children))
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

function Base.convert(::Type{Tree}, etree::ETree, dict::Dict)
    t = Tree(etree.name, Tree[])
    for e in etree.elements
        if isa(e, String)
            ismatch(r"^\s*$",e) && continue
            push!(t, Tree(e))
        else
            c = convert(Tree, e, dict)
            if haskey(dict, e)
                push!(t, c)
            else
                append!(t, c.children)
            end
        end
    end
    t
end

function clean!(tree::Tree)
    tree.name == "contrib" && tree["contrib-type"] == "author" && (tree.name = "author")
    tree.attr = nothing
    children = Tree[]
    for c in tree.children
        clean!(c)
        if c.name == "label" || c.name == "caption" || c.name == "title"
            haskey(tagdict,tree.name) && push!(children,c)
        elseif isempty(c) || haskey(tagdict,c.name)
            push!(children, c)
        else
            append!(children, c.children)
        end
    end

    if isroot(tree)
        filter!(!isempty, children)
    end
    setchildren!(tree, children)
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
