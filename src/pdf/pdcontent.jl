export readpdf

abstract type PDContent end

mutable struct PDChar <: PDContent
    page::Int
    c::String
    x::Float64
    y::Float64
    w::Float64
    h::Float64
end

mutable struct PDDraw <: PDContent
    page::Int
    op::String
    coordinates::Vector{Float64}
end

function readpdf(path::String)
    jarfile = realpath(joinpath(dirname(@__FILE__),"pdfextract-0.1.3.jar"))
    pdfstr = readstring(`java -classpath $jarfile PDFExtractor $path -text -bounding -draw`)

    pdcontents = PDContent[]
    lines = split(pdfstr, "\n")
    push!(lines, "")
    for line in lines
        isempty(line) && continue
        items = Vector{String}(split(line,'\t'))
        page = parse(Int, items[1])
        content = items[2]
        if content == "TEXT"
            c = items[3]
            coordinates = map(i -> parse(Float64,items[i]), 4:7)
            char = PDChar(page, c, coordinates...)
            push!(pdcontents, char)
        elseif content == "DRAW"
            op = items[3]
            coordinates = map(i -> parse(Float64,items[i]), 4:length(items))
            draw = PDDraw(page, op, coordinates)
            push!(pdcontents, draw)
        end
    end
    pdcontents
end
