export readjats

using EzXML

struct UnsupportedException <: Exception
    message::String
end

function readjats(path::String)
    try
        xml_article = root(readxml(path))
        @assert nodename(xml_article) == "article"
        if countelements(xml_article) < 3
            warn("#xml elements < 3")
            return
        end

        #images = readimages(replace(path,".xml",".pdf"))
        #graphics = find(xml_article, "//graphic | //inline-graphic")
        #length(images) == length(graphics) || warn("$(length(images)) vs $(length(graphics))")

        article = Tree("article")
        xml_front = findfirst(xml_article, "front")
        push!(article, parse_front(xml_front))

        body = findfirst(xml_article, "body")
        push!(article, parse_body(body))

        back = find(xml_article, "back")
        if !isempty(back)
            #push!(article, parse_back(back[1]))
        end

        push!(article, Tree("floats-group"))
        append!(article[end], findfloats(article))
        floats = find(xml_article, "floats-group")
        if !isempty(floats)
            append!(article[end], parse_body(floats[1]).children)
        end
        isempty(article[end]) && deleteat!(article,length(article)) # no floats

        maths = findall(article, "math")
        for i = 1:length(maths)
            math = maths[i]
            mathml = root(parsexml(toxml(math)))
            normalize_mathml!(mathml)
            replace!(math, convert(Tree,mathml))
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

function Base.convert(::Type{Tree}, enode::EzXML.Node, dict=Dict())
    elements = filter(nodes(enode)) do n
        iselement(n) && return true
        istext(n) && !ismatch(r"^\s*$",nodecontent(n))
    end
    elements = collect(elements)
    tempnodes = map(elements) do e
        istext(e) ? Tree(nodecontent(e)) : convert(Tree,e,dict)
    end
    deletable = begin
        if any(istext, elements)
            false
        elseif isempty(dict) || any(e -> haskey(dict,e), elements)
            true
        elseif any(n -> any(!isempty,n.children), tempnodes)
            true
        else
            false
        end
    end

    children = Tree[]
    for i = 1:length(elements)
        e = elements[i]
        t = tempnodes[i]
        if istext(e) || isempty(dict) || haskey(dict,e)
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
    isempty(children) && push!(children,Tree(""))
    Tree(nodename(enode), children)
end

function parse_front(front::EzXML.Node)
    xpath = """
        journal-meta/journal-title-group/journal-title
        | article-meta/title-group/article-title
        | article-meta/pub-date[1]/year
        | article-meta/abstract
        """
    tree = Tree(nodename(front), map(parse_body,find(front,xpath)))

    contrib = "article-meta/contrib-group/contrib[@contrib-type=\"author\"]"
    xpath = """
        $contrib
        | $contrib/name/prefix
        | $contrib/name/given-names
        | $contrib/name/surname
        | $contrib/name/suffix
        | $contrib/collab
        """
    dict = Dict(n => n for n in find(front,xpath))
    authors = convert(Tree, front, dict).children
    foreach(a -> a.name = "author", authors)
    append!(tree, authors)
    tree
end

function parse_body(body::EzXML.Node)
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
        """
    dict = Dict(n => n for n in find(body,xpath))
    convert(Tree, body, dict)
end

function parse_back(back::EzXML.Node)
    tree = Tree(nodename(back))
    for node in find(back, ".//element-citation | .//mixed-citation")
        setnodename!(node, "citation")
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
    dict = Dict(n => n for n in find(back,xpath))
    convert(Tree, back, dict)
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
        filename = splitext(file)[1]
        xmlpath = joinpath(rootpath, file)
        pdfpath = joinpath(rootpath, "$filename.pdf")
        isfile(pdfpath) || continue

        tree = readjats(xmlpath)
        delete!(tree["body"])

        # remove non-figure floats
        if tree[end].name == "floats-group"
            floatset = Set(["fig","fig-group","table-wrap"])
            floats = Tree[]
            topdown_while(tree[end]) do t
                if t.name in floatset
                    push!(floats, t)
                    false
                else
                    true
                end
            end
            isempty(floats) ? delete!(tree[end]) : setchildren!(tree[end],floats)

            count = 1
            for node in floats
                node.name == "fig" || continue
                imgname = "$(file[1:end-4])_$count.png"
                node.name = "fig img=\"$imgname\""
                count += 1
            end
        end

        dir = "C:/Users/hshindo/Documents/sample_xml4-4/$filename"
        isdir(dir) || mkdir(dir)
        open("$dir/$file","w") do f
            println(f, toxml(tree))
        end
        isfile(pdfpath) && cp(pdfpath,"$dir/$filename.pdf")
        pdftxtpath = joinpath(rootpath, "$filename.pdf.txt")
        isfile(pdftxtpath) && cp(pdftxtpath,"$dir/$filename.pdf.txt")
        saveimages(pdfpath, options=["-o",dir,"-dpi","200"])
    end
end

function normalize_mathml!(mathml::EzXML.Node)
    # replace <mn>, <mo>, <mtext>, <ms> with <mi>
    for node in find(mathml, "//mn | //mo | //mtext | //ms")
        if nodename(node) == "ms"
            setnodecontent!(node, "\"$(nodecontent(node))\"")
        end
        setnodename!(node, "mi")
    end
    # <mi>sin</mi> -> <mi>s</mi><mi>i</mi><mi>n</mi>
    for node in find(mathml, "//mi")
        chars = Vector{Char}(nodecontent(node))
        length(chars) == 1 && continue
        setnodecontent!(node, string(chars[1]))
        target = node
        for i = 2:length(chars)
            mi = ElementNode("mi")
            link!(mi, TextNode(string(chars[i])))
            linknext!(target, mi)
            target = mi
        end
    end
    for node in find(mathml, "//text()")

    end
end
