workspace()
using LibExpat
using LightJATS

function test()
    path = joinpath(dirname(@__FILE__), "../.data/journal.pone.0170111")
    #path = "C:/Users/hshindo/Desktop/PMC500/PMC5000010"
    tree = readjats("$path.xml")
    open("$(dirname(path))/b.xml","w") do f
        println(f, toxml(tree))
    end
    return
    #pdf = readpdf("$path.pdf")
    align("$path.pdf", "$path.xml")
    #write("s.out", pdf)
end
t = test()

function test1()
    root = "C:/Users/hshindo/Desktop/PMC500"
    for dir in readdir(root)
        endswith(dir,".xml") || continue
        println(dir)
        path = joinpath(root, dir)
        tree = readjats(path)
        xml = toxml(tree)
        open("C:/Users/hshindo/Desktop/temp/$dir","w") do f
            println(f, xml)
        end
        return
    end
end
test1()
