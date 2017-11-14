export readjats

using LibExpat

struct UnsupportedException <: Exception
    message::String
end

function readjats(path::String)
    try
        xml = xp_parse(open(readstring,path))
        @assert xml.name == "article"
        if length(xml.elements) < 3
            warn("#xml elements < 3")
            return
        end

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
        jsonize!(article)
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
    elements = filter(e -> isa(e,ETree) || !ismatch(r"^\s*$",e), etree.elements) |> collect
    temp = map(elements) do e
        isa(e,String) ? Tree(e) : convert(Tree,e,dict)
    end
    deletable = begin
        if any(e -> isa(e,String), elements)
            false
        elseif any(e -> haskey(dict,e), elements)
            true
        elseif any(x -> any(!isempty,x.children), temp)
            true
        else
            false
        end
    end

    children = Tree[]
    for i = 1:length(elements)
        e = elements[i]
        t = temp[i]
        if isa(e,String) || haskey(dict,e)
            if isempty(children)
                push!(children, t)
            elseif isempty(t) && isempty(children[end])
                children[end].name *= t.name
            else
                push!(children, t)
            end
        elseif any(!isempty, t.children) || !deletable
            for c in t.children
                if isempty(children)
                    push!(children, c)
                elseif isempty(c) && isempty(children[end])
                    children[end].name *= c.name
                else
                    push!(children, c)
                end
            end
        end
    end
    Tree(etree.name, children)
end

function parse_front(front::ETree)
    xpath = """
        journal-meta/journal-title-group/journal-title
        | article-meta/title-group/article-title
        | article-meta/pub-date[1]/year
        | article-meta/abstract
        """
    tree = Tree(front.name, map(parse_body,front[xpath]))

    contrib = "article-meta/contrib-group/contrib[@contrib-type=\"author\"]"
    xpath = """
        $contrib
        | $contrib/name/prefix
        | $contrib/name/given-names
        | $contrib/name/surname
        | $contrib/name/suffix
        """
    dict = Dict(n => n for n in front[xpath])
    authors = convert(Tree, front, dict).children
    foreach(a -> a.name = "author", authors)
    append!(tree, authors)
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
        """
    dict = Dict(n => n for n in body[xpath])
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
    floatset = Set(["boxed-text","code","fig","fig-group","table-wrap","table-wrap-group","disp-formula"])
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
    for i = length(tree)-1:-1:1
        if tree[i].name == "label" && tree[i+1].name == "title"
            prepend!(tree[i+1], tree[i].children)
            deleteat!(tree, i)
        end
    end
    foreach(postprocess!, tree.children)
end

function jsonize!(tree::Tree)
    n = count(isempty, tree.children)
    if n > 0
        strs = String[]
        for c in tree.children
            if isempty(c)
                push!(strs, c.name)
            else
                push!(strs, "[$(c.name)]")
            end
        end
        setchildren!(tree, Tree(join(strs," ")))
    else
        foreach(jsonize!, tree.children)
    end
end

function create_sample(rootpath::String)
    for file in readdir(rootpath)
        endswith(file,".xml") || continue
        println(file)
        xmlpath = joinpath(rootpath, file)
        tree = readjats(xmlpath)

        # remove non-figure floats
        floatset = Set(["fig","fig-group"])
        floats = Tree[]
        topdown_while(tree) do t
            if t.name in floatset
                push!(floats, t)
                false
            else
                true
            end
        end
        deleteat!(tree, 2)
        setchildren!(tree[end], floats)
        count = 1
        for node in floats
            node.name == "fig" || continue
            imgname = "$(file[1:end-4])_$count.png"
            node.name = "fig img=\"$imgname\""
            count += 1
        end

        filename = splitext(file)[1]
        dir = "C:/Users/hshindo/Documents/sample_xml4/$filename"
        isdir(dir) || mkdir(dir)
        open("$dir/$file","w") do f
            println(f, toxml(tree))
        end

        pdfpath = joinpath(rootpath, "$filename.pdf")
        extract_images(pdfpath, o=dir, dpi=200)
    end
end
