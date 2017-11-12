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
        push!(article[end], Tree("pdf-link",Tree("http://www.aclweb.org/anthology/P12-1046")))
        push!(article[end], Tree("xml-link",Tree("http://example.xml")))

        body = xml["body"][1]
        push!(article, parse_body(body))

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
    xpath = """
        journal-meta/journal-title-group/journal-title
        | article-meta/title-group/article-title
        | article-meta/pub-date[1]/year
        | article-meta/abstract
        """
    trees = map(parse_body, front[xpath])
    tree = Tree(front.name, trees)

    contrib = "article-meta/contrib-group/contrib[@contrib-type=\"author\"]"
    xpath = """
        name/prefix
        | name/given-names
        | name/surname
        | name/suffix
        """
    for node in front["article-meta/contrib-group/contrib[@contrib-type=\"author\"]"]
        author = Tree("author")
        push!(tree, author)
        for item in ["prefix","given-names","surname","suffix"]
            str = node["string(name/$item)"]
            t = Tree(item, Tree(str))
            isempty(str) || push!(author,t)
        end
    end

    #dict = Dict(n => n for n in front[xpath])
    #authors = convert(Tree, front, dict).children
    #foreach(x -> x.name = "author", authors)
    #append!(tree, authors)
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
