const keepdict = Dict(
    t => t for t in [
    "body",
    "boxed-text",
    "caption",
    "def-list",
    "disp-formula",
    "disp-formula-group",
    "fig",
    "fig-group",
    "inline-formula",
    "object-id",
    "label",
    "list",
    "p",
    "sec",
    "statement",
    "sub",
    "sup",
    "table",
    "table-wrap",
    "table-wrap-group",
    "tbody",
    "td",
    "tfoot",
    "th",
    "thead",
    "title",
    "tr",
    "xref",
    ]
)

const deldict = Dict(
    t => t for t in [
    "abbrev",
    "alternatives",
    "award-id",
    "bold",
    "break",
    "chem-struct",
    "chem-struct-wrap",
    "col",
    "colgroup",
    "disp-quote",
    "email",
    "ext-link",
    "funding-source",
    "hr",
    "italic",
    "monospace",
    "named-content",
    "overline",
    "open-access",
    "roman",
    "sans-serif",
    "sc",
    "strike",
    "styled-content",
    "target",
    "underline",
    "uri",
    "mml:math",
    ]
)