# LightJATS Specification

* [article](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ja30.html)
    * [article-title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-e630.html)
    * ~~[contrib[@contrib-type="author"]](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-n3w0.html)~~ → rename to `author`
        * [prefix](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-jxr0.html)
        * [given-names](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fwt0.html)
        * [surname](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sg90.html)
        * [suffix](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-djb0.html)
    * [boxed-text](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i950.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [code](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ty80.html)
    * [def-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-4hx0.html)
        * title
        * term-head?
        * def-head?
        * [def-item](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ndx0.html)
            * label
            * term
            * [def](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xtx0.html)
    * [disp-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tmx0.html)
        * [mml:math](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cgn0.html)
    * [disp-formula-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-v8v0.html)
    * [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)
    * [fig-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-83s0.html)
    * [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)
    * [p](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7xd0.html)
    * [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
        * label → merge with `title`
        * title
    * [statement](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sdp0.html)
    * sub
    * sup
    * [table-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mb90.html)
        * [table](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-by90.html)
            * thead
            * tfoot
            * tbody
            * tr
                * th
                * td
    * [table-wrap-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-c5m0.html)
        * table-wrap
    * xref

## [boxed-text](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i950.html)
Textual material that is part of the body but is outside the flow of the narrative text (for example, a sidebar).
* label
* caption
* disp-formula
* disp-formula-group
* def-list
* fn
* inline-formula
* list
* p
* statement
* sec
* boxed-text
* code
* fig-group
* fig
* table-wrap


## [code](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ty80.html)
A container element for technical content such as programming language code, pseudo-code, schemas, or a markup fragment.

## [def-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-4hx0.html)
List in which each item consists of two parts: (1) a word, phrase, term, graphic, chemical structure, or equation, that is paired with 2) one or more descriptions, discussions, explanations, or definitions of it.
* title
* term-head?
* def-head?
* [def-item](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ndx0.html)
    * label
    * term
    * [def](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xtx0.html)
* def-list

## [disp-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tmx0.html)
Mathematical equation, expression, or formula that is to be displayed as a block (callout) within the narrative flow.
* inline-formula
* xref
* sub
* sup
* label
* code

## [disp-formula-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-v8v0.html)
Container element for equations or other mathematical expressions.
* label
* caption
* disp-formula
* disp-formula-group

## [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)
Block of graphic or textual material that is identified as a figure, usually bearing a caption and a label such as “Figure 3.” or “Figure”.

## [fig-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-83s0.html)
Container element for figures that are to be displayed together.

## [fn](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-87s0.html)
Additional information tied to a particular location in the text. This material is not considered to be part of the body of the text, but is a note used instead of, in addition to, as a source for, or as a commentary on either some body text or on an element in the metadata such as an author.
* label
* p

## [front](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-j6s0.html)
Container element for the metadata of an article and the journal in which it was published.

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

## [graphic](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xbt0.html)
Description of and pointer to an external file containing a still image.

## [inline-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gw70.html)
Mathematical equation, expression, or formula that is to be displayed inline. The mathematics itself can be expressed as ASCII characters, as a graphic, or using TeX, LaTeX, or MathML mathematics expressions.

## [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)
Sequence of two or more items, which may or may not be ordered.

## [mml:math](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cgn0.html)
Use documentation for the Mathematical Markup Language (MathML) 3.0 Tag Set (http://www.w3.org/TR/MathML3/) or the Mathematical Markup Language (MathML) 2.0 Tag Set (http://www.w3.org/TR/MathML2/).

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

## [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
Headed group of material; the basic structural unit of the body of a document.
* ~~label~~ → merge with `title`
* title
* code
* disp-formula
* disp-formula-group
* def-list
* list
* p
* statement
* sec

## [statement](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sdp0.html)
Theorem, Lemma, Proof, Postulate, Hypothesis, Proposition, Corollary, or other formal statement, identified as such with a label and usually made typographically distinct from the surrounding text.

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
