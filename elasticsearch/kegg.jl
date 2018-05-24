using JSON

function create(filename::String)
    json = JSON.parsefile(filename)
    id = json["entry"]
    dict = Dict{Any,Any}(
        "id" => "E:$id",
        "title" => json["name"][1],
        "description" => "Compound $id"
    )
    if haskey(json,"structure") && haskey(json["structure"], "image")
        image = json["structure"]["image"]
        dict["image"] = "http://www.genome.jp$image"
    end
    if haskey(json, "molweight")
        dict["molweight"] = [
            Dict("value"=>json["molweight"], "reference"=>"arxiv1103.1918")
        ]
    end
    if haskey(json, "reaction")
        dict["reaction"] = map(json["reaction"]) do r
            Dict("value"=>"E:$r", "reference"=>"arxiv1103.1918", "pdfanno"=>"")
        end
    end
    JSON.json(dict)
end

function kegg_esjsons(dirpath::String)
    jsons = []
    for file in readdir(dirpath)
        endswith(file,".json") || continue
        println(file)
        filename = joinpath(dirpath, file)
        push!(jsons, create(filename))
    end
    open("compound.json","w") do f
        for json in jsons
            println(f, json)
        end
    end
end
kegg_esjsons("D:/kegg/sample_compound")
