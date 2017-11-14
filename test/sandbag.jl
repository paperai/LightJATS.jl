workspace()
using LibExpat
using LightJATS

LightJATS.create_sample("C:/Users/hshindo/Desktop/PMC500")
LightJATS.create_sample("C:/Users/hshindo/Dropbox/temp/plosone_sample/070")

function test()
    path = joinpath(dirname(@__FILE__), "../.data/journal.pone.0170111")
    path = "D:/PMC500/PMC5000546"
    tree = readjats("$path.xml")
    open("$(dirname(path))/b.xml","w") do f
        println(f, toxml(tree))
    end
    return
    #pdf = readpdf("$path.pdf")
    align("$path.pdf", "$path.xml")
    #write("s.out", pdf)
end
#t = test()

function test1()
    root = "D:/PMC500"
    for dir in readdir(root)
        endswith(dir,".xml") || continue
        println(dir)
        path = joinpath(root, dir)
        tree = readjats(path)
        xml = toxml(tree)
        open("D:/sample_xml3/$dir","w") do f
            println(f, xml)
        end
        #return
    end
end
test1()
