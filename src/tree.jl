export Tree
export topdown, topdown_while, toxml, tosexpr

mutable struct Tree
    name
    children::Vector{Tree}
    parent
end

function Tree(name, children::Vector{Tree})
    t = Tree(name, children, nothing)
    for c in children
        c.parent = t
    end
    t
end
Tree(name, children::Tree...) = Tree(name, [children...])
Tree(name) = Tree(name, Tree[])

isroot(tree::Tree) = isa(tree.parent, Void)

Base.getindex(tree::Tree, key::Int) = tree.children[key]

function Base.setindex!(tree::Tree, value::Tree, key::Int)
    tree.children[key] = value
    value.parent = tree
end
Base.isempty(tree::Tree) = isempty(tree.children)
Base.length(tree::Tree) = length(tree.children)
Base.size(tree::Tree, i::Int) = size(tree.children, i)
Base.endof(tree::Tree) = endof(tree.children)
function Base.push!(tree::Tree, children::Tree...)
    push!(tree.children, children...)
    for c in children
        delete!(c)
        c.parent = tree
    end
end
Base.append!(tree::Tree, children) = push!(tree, children...)

function Base.prepend!(tree::Tree, children)
    prepend!(tree.children, children)
    for c in children
        delete!(c)
        c.parent = tree
    end
end

function Base.insert!(tree::Tree, i::Int, child::Tree)
    insert!(tree.children, i, child)
    child.parent = tree
end
function Base.deleteat!(tree::Tree, i::Int)
    tree[i].parent = nothing
    deleteat!(tree.children, i)
end
function Base.delete!(tree::Tree)
    tree.parent == nothing && return
    i = findfirst(x -> x == tree, tree.parent.children)
    deleteat!(tree.parent, i)
    tree.parent = nothing
end
function removeat!(tree::Tree, i::Int)
    children = Tree[]
    tree[i].parent = nothing
    for k = 1:length(tree)
        if k == i
            append!(children, tree[k].children)
        else
            push!(children, tree[k])
        end
    end
    setchildren!(tree, children)
end
function Base.empty!(tree::Tree)
    foreach(c -> c.parent = nothing, tree.children)
    empty!(tree.children)
end
function Base.find(f::Function, tree::Tree)
    nodes = Tree[]
    function traverse(node::Tree)
        f(node) && push!(nodes,node)
        for c in node.children
            traverse(c)
        end
    end
    traverse(tree)
    nodes
end

function setchildren!(tree::Tree, children::Vector{Tree})
    foreach(c -> c.parent = nothing, tree.children)
    foreach(c -> c.parent = tree, children)
    tree.children = children
end
setchildren!(tree::Tree, children::Tree...) = setchildren!(tree, [children...])

function topdown(f, tree::Tree)
    f(tree)
    for c in tree.children
        topdown(f, c)
    end
end

function topdown_while(f::Function, tree::Tree)
    cond = f(tree)
    @assert isa(cond,Bool)
    cond || return
    for c in tree.children
        topdown_while(f, c)
    end
end

function bottomup(f::Function, tree::Tree)
    for c in tree.children
        bottomup(f, c)
    end
    f(tree)
end

function tosexpr(tree::Tree)
    strs = String["(", tree.name]
    for c in tree.children
        push!(strs, tosexpr(c))
    end
    push!(strs, ")")
    join(strs)
end

function toxml(tree::Tree)
    function escape(str::String)
        str = replace(str, "&", "&amp;")
        str = replace(str, ">", "&gt;")
        str = replace(str, "<", "&lt;")
        str = replace(str, "'", "&apos;")
        str = replace(str, "\"", "&quot;")
        str
    end

    strs = String[]
    isa(tree.parent,Void) && push!(strs,"<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
    name = escape(tree.name)
    if isempty(tree)
        push!(strs, name)
    else
        push!(strs, "<$name>")
        for c in tree.children
            push!(strs, toxml(c))
        end
        push!(strs, "</$name>")
    end
    join(strs, "\n")
end

function Base.string(tree::Tree)
    strs = String[]
    topdown(tree) do node
        isempty(node) && push!(strs,node.name)
    end
    join(strs)
end

function Base.parse(::Type{Tree}, sexpr::String)
    sexpr = Vector{Char}(sexpr)
    function f(i::Int)
        chars = Char[]
        children = Tree[]
        while i <= length(sexpr)
            c = sexpr[i]
            if c == '('
                child, i = f(i+1)
                push!(children, child)
            elseif c == ')'
                tree = Tree(join(chars), children)
                return tree, i+1
            else
                c != ' ' && c != '\n' && push!(chars,sexpr[i])
                i += 1
            end
        end
        throw("Invalid S-expression.")
    end
    i = findfirst(c -> c == '(', sexpr)
    i == 0 && throw("Invalid S-expression.")
    tree, _ = f(i+1)
    tree
end

#=
struct TopdownIterator
    tree::Tree
end
topdown = TopdownIterator

Base.start(iter::TopdownIterator) = Tree[iter.tree]
Base.done(iter::TopdownIterator, state::Vector{Tree}) = isempty(state)
function Base.next(iter::TopdownIterator, state::Vector{Tree})
    tree = pop!(state)
    for i = length(tree):-1:1
        push!(state, tree[i])
    end
    (tree, state)
end
=#
