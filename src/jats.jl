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
        push!(article, parse_front(front))
        push!(article[1], Tree("booktitle",Tree("ACL")))
        push!(article[1], Tree("year",Tree("2017")))
        push!(article[1], Tree("url",Tree("http://www.aclweb.org/anthology/P12-1046")))

        body = xml["body"][1]
        append!(article, parse_body(body).children)
        push!(article, Tree("floats-group"))
        append!(article[end], findfloats(article))
        floats = xml["floats-group"]
        if !isempty(floats)
            append!(article[end], parse_body(floats[1]).children)
        end

        postprocess!(article)
        #jsonize!(article)
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
            haskey(dict,etree) || continue
            if isempty(t) || !isempty(t[end])
                push!(t, Tree(e))
            else
                t[end].name *= e
            end
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
        | //boxed-text/caption/title
        | //code
        | //def-list
        | //def-list/label
        | //def-list/title
        | //def-list/def-item
        | //def-list/def-item/term
        | //def-list/def-item/def
        | //disp-formula
        | //disp-formula//mml:math
        | //disp-formula//mml:math//*
        | //disp-formula/label
        | //disp-formula-group/label
        | //disp-formula-group/caption
        | //disp-formula-group/caption/title
        | //fig
        | //fig/label
        | //fig/caption
        | //fig/caption/title
        | //fig-group
        | //fig-group/label
        | //fig-group/caption
        | //fig-group/caption/title
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
        | //table/thead
        | //table/tbody
        | //table/tfoot
        | //table//tr
        | //table//th
        | //table//td
        | //table-wrap
        | //table-wrap/label
        | //table-wrap/caption
        | //table-wrap/caption/title
        | //table-wrap-group
        | //table-wrap-group/label
        | //table-wrap-group/caption
        | //table-wrap-group/caption/title
        | //sub
        | //sup
        | //xref
        """
    dict = Dict(n => n for n in body[xpath])
    dict[body] = body
    tree = convert(Tree, body, dict)
    tree
end

function parse_back(back::ETree)
    tree = Tree(back.name)
    for node in back["//element-citation | //mixed-citation"]
        node.name = "citation"
    end
    xpath = """
        ref-list
        | ref-list/label
        | ref-list/title
        | ref-list/ref
        | ref-list/ref/citation
        | ref-list/ref/citation/article-title
        | ref-list/ref/citation/name
        | ref-list/ref/citation/collab
        | ref-list/ref/citation/day
        | ref-list/ref/citation/month
        | ref-list/ref/citation/year
        | ref-list/ref/citation/fpage
        | ref-list/ref/citation/lpage
        | ref-list/ref/citation/issue
        | ref-list/ref/citation/pub-id
        | ref-list/ref/citation/publisher-loc
        | ref-list/ref/citation/publisher-name
        | ref-list/ref/citation/source
        | ref-list/ref/citation/edition
        | ref-list/ref/citation/volume
        """
    dict = Dict(n => n for n in back[xpath])
    dict[etree] = etree
    convert(Tree, etree, dict)
end

function findfloats(tree::Tree)
    floatset = Set(["boxed-text","code","fig","fig-group","table-wrap","table-wrap-group"])
    floats = Tree[]
    topdown_while(tree) do t
        if t.name in floatset
            push!(floats, t)
            false
        else
            true
        end
    end
    floats
end

function postprocess!(tree::Tree)
    # merge <label> with <title>
    for i = 2:length(tree)
        if tree[i-1].name == "label" && tree[i].name == "title"
            prepend!(tree[i], tree[i-1].children)
            deleteat!(tree, i-1)
        end
    end
    foreach(postprocess!, tree.children)
end

function jsonize!(tree::Tree)
    n = count(isempty, tree.children)
    if n > 0
        strs = String[]
        for c in tree.children
            push!(strs, string(c))
        end
        setchildren!(tree, Tree(join(strs)))
    else
        foreach(jsonize!, tree.children)
    end
end
