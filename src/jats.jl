export readjats

using LibExpat

struct UnsupportedException <: Exception
    message::String
end

function readjats(path::String)
    try
        xml = xp_parse(open(readstring,path))
        @assert xml.name == "article"
        article = Tree("article")
        front = xml["front"][1]
        append!(article, parse_front(front).children)
        body = xml["body"][1]
        append!(article, parse_body(body).children)
        return article
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
            haskey(dict,etree) && push!(t,Tree(e))
        else
            c = convert(Tree, e, dict)
            haskey(dict,e) ? push!(t,c) : append!(t,c.children)
        end
    end
    t
end

function parse_front(front::ETree)
    tree = Tree(front.name)

    title = front["article-meta/title-group/article-title"]
    title = isempty(title) ? Tree("title") : parse_body(title[1])
    push!(tree, title)

    p = "article-meta/contrib-group/contrib[@contrib-type=\"author\"]"
    xpath = """
        $p
        | $p/name/prefix
        | $p/name/given-names
        | $p/name/surname
        | $p/name/suffix
        """
    dict = Dict(n => n for n in front[xpath])
    t = convert(Tree, front, dict)
    foreach(c -> c.name = "author", t.children)
    append!(tree, t.children)

    abst = front["article-meta/abstract"]
    abst = isempty(abst) ? Tree("abstract") : parse_body(abst[1])
    push!(tree, abst)
    tree
end

function parse_body(body::ETree)
    xpath = """
        //boxed-text
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
        | //sub
        | //sup
        | //table
        | //table-wrap
        | //table-wrap/label
        | //table-wrap/caption
        | //table-wrap-group
        | //table-wrap-group/label
        | //table-wrap-group/caption
        | //xref
        """
    nodes = body[xpath]
    for node in nodes
        node.name == "label"
    end
    dict = Dict(n => n for n in body[xpath])
    dict[body] = body
    tree = convert(Tree, body, dict)
    tree
end

function parse_back(etree::ETree)

end

function merge(tree::Tree)
    for i = 1:length(tree)-1
        if tree[i].name == "label" && tree[i+1].name == "title"

        end
    end
end
