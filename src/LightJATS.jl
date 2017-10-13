module LightJATS

const tagdict = Dict(
    t => t for t in [
    "article",
    "article-title",
    "author",
    "prefix",
    "given-names",
    "surname",
    "suffix",
    "boxed-text",
    "caption",
    "code",
    "def-list",
    "def-item",
    "term",
    "def",
    "disp-formula",
    "mml:math",
    "disp-formula-group",
    "fig",
    "fig-group",
    "list",
    "list-item",
    "label",
    "p",
    "sec",
    "statement",
    "sub",
    "sup",
    "table-wrap",
    "table",
    "thead",
    "tbody",
    "tfoot",
    "tr",
    "th",
    "td",
    "table-wrap-group",
    "title",
    "xref",
    ]
)

include("tree.jl")
include("jats.jl")

end
