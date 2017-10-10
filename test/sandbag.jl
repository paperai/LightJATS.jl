workspace()
using LibExpat
using LightJATS

function test()
    path = joinpath(dirname(@__FILE__), "../.data/journal.pone.0170111")
    #path = "C:/Users/hshindo/Desktop/PMC300/PMC3000813"
    tree = readjats("$path.xml")
    return tree
    pdf = readpdf("$path.pdf")
    align!(pdf, xml)
    #write("s.out", pdf)
end
#test()

function test1()
    root = "D:/PMC300"
    for dir in readdir(root)
        endswith(dir,".xml") || continue
        println(dir)
        path = joinpath(root, dir)
        tree = readjats("$path")
        topdown(tree) do x
            x.name == "fn" && println("fn found.")
        end
    end
end
test1()
