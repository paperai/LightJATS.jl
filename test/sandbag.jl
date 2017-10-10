workspace()
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
test()
