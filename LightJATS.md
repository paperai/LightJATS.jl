# LightJATS Specification v0.1

## [article](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ja30.html)
A journal article.
* front
* body
* back
* floats-group

## ~~[award-id](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-n850.html)~~
Unique identifier assigned to an award, contract, or grant.

## [body](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-jn50.html)
Main textual portion of the document that conveys the narrative content.
* sec

## ~~bold~~

## ~~[break](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i380.html)~~

## ~~[chem-struct](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-z480.html)~~

## ~~[chem-struct-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d680.html)~~

## [def-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-4hx0.html)
* title
* term-head?
* def-head?
* [def-item](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ndx0.html)
    * label
    * term
    * [def](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xtx0.html)
* def-list

## [disp-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tmx0.html)
* alternatives?
* inline-formula
* fn
* mml:math
* xref
* sub
* sup
* label
* code?
* preformat?

## [disp-formula-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-v8v0.html)
* label
* caption
* disp-formula
* disp-formula-group

## ~~[disp-quote](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fuv0.html)~~

## ~~fixed-case~~

## [fn](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-87s0.html)
* label?
* p

## ~~[fn-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-8fs0.html)~~

## [front](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-j6s0.html)
* ~~article-meta~~
    * ~~title-group~~
        * article-title
    * abstract
* ~~contrib-group~~
    * ~~contrib[@contrib-type="author"]~~ → rename to `author`
        * ~~name~~
            * prefix
            * given-names
            * surname
            * suffix

## ~~[funding-source](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d9s0.html)~~

## ~~hr~~

## inline-formula

## ~~italic~~

## [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)

## mml:math

## ~~monospace~~

## ~~[open-access](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fkd0.html)~~

## ~~overline~~

## ~~overline-start~~

## ~~overline-end~~

## [p](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7xd0.html)
Textual unit or block; a textual paragraph.
* inline-formula
* ~~named-content~~
* ~~styled-content~~
* fn
* target
* xref
* sub
* sup
* code
* supplementary-material
* disp-formula
* disp-formula-group
* Citation Elements?
    * citation-alternatives> Citation Alternatives
    * element-citation> Element Citation
    * mixed-citation> Mixed Citation
    * nlm-citation> NLM Citation
* def-list
* list
* statement

## ~~[preformat](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-2er0.html)~~

## [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
* ~~label~~ → merge with `title`
* title
* code
* ~~preformat~~ → replace with `p`
* supplementary-material
* alternatives
* disp-formula
* disp-formula-group
* def-list
* list
* mml:math
* p
* statement
* sec
* fn

## statement

## ~~roman~~
## ~~sans-serif~~
## ~~sc~~
## ~~strike~~
## ~~underline~~
## ~~underline-start~~
## ~~underline-end~~
## ~~ruby~~

## [Linking Elements]
### ~~[email](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-rk40.html)~~
### ~~[ext-link](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-q740.html)~~
### ~~[uri](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mzk2.html)~~

## [Other Inline Elements]
### ~~[abbrev](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-9p00.html)~~
### ~~[named-content](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-qk60.html)~~
### ~~[styled-content](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-piq0.html)~~

## [Paragraph-level Elements]
### boxed-text
* object-id
* label
* caption
* Paragraph-level Elements
* disp-formula
* disp-formula-group
* Lists
* Math Elements
* p
* statement
* sec

### [code](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ty80.html)?

### [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)

### fig-group

### graphic

### preformat?

### supplementary-material?

### [table](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-by90.html)
* ~~col~~
* ~~colgroup~~
* thead
* tfoot
* tbody
* tr
    * th
    * td

### [table-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mb90.html)

### [table-wrap-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-c5m0.html)

## ~~[target](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xam0.html)~~
