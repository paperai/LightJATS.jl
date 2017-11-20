# LightJATS
A lightweight [Journal Article Tag Suite (JATS)](https://en.wikipedia.org/wiki/Journal_Article_Tag_Suite) for scientific literature.  
The official documentation of the original JATS is [here](https://jats.nlm.nih.gov/index.html).

## Installation
```julia
julia> Pkg.clone("https://github.com/paperai/LightJATS.jl.git")
```

## Functions
* `readjats(path::String)::LightJATS.Tree`: Read JATS file and convert it to LightJATS tree.
* `toxml(tree::LightJATS.Tree)`: Convert tree to xml.

### Example
```julia
using LightJATS

tree = readjats("C:/xxx.xml")
xml = toxml(tree)
open("C:/out.xml","w") do f
    println(f, xml)
end
```
