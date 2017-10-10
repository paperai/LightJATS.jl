# LightJATS Specification v0.1

## ~~[abbrev](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-9p00.html)~~
Abbreviation, acronym, or emoticon used in the text of a document, possibly including an expansion of the acronym.

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

## ~~[bold](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-bi50.html)~~
Used to mark text that should appear in bold face.

## [boxed-text](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i950.html)
Textual material that is part of the body but is outside the flow of the narrative text (for example, a sidebar).
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

## ~~[break](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i380.html)~~
An explicit line break in the text.

## ~~[chem-struct](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-z480.html)~~
Chemical expression, reaction, equation, etc. that is set apart within the text.

## ~~[chem-struct-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d680.html)~~
Wrapper element for a chemical expression, reaction, equation, etc. that is set apart from the text; includes any number, label, or caption that accompanies the chemical expression.

## [code](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ty80.html)

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
* alternatives
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
Container element for equations or other mathematical expressions.
* label
* caption
* disp-formula
* disp-formula-group

## ~~[disp-quote](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fuv0.html)~~
Extract or extended quoted passage from another work, usually made typographically distinct from surrounding text.

## ~~[email](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-rk40.html)~~
Electronic mail address of a person or institution.

## ~~[ext-link](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-q740.html)~~
Link to an external file or resource.

## [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)
Block of graphic or textual material that is identified as a figure, usually bearing a caption and a label such as “Figure 3.” or “Figure”.

## [fig-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-83s0.html)
Container element for figures that are to be displayed together.

## ~~[fixed-case](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cas0.html)~~
Used to mark text in which the case of the content should not be changed, even if the content around it is styled to all upper case or all lower.

## [fn](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-87s0.html)
Additional information tied to a particular location in the text. This material is not considered to be part of the body of the text, but is a note used instead of, in addition to, as a source for, or as a commentary on either some body text or on an element in the metadata such as an author.
* label?
* p

## ~~[fn-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-8fs0.html)~~
Container element for footnotes that appear at the end of the document.

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

## ~~[funding-source](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d9s0.html)~~
Agency or organization that funded the research on which a work was based.

## [graphic]

## ~~[hr](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-du70.html)~~
An explicit horizontal rule.

## [inline-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gw70.html)
Mathematical equation, expression, or formula that is to be displayed inline. The mathematics itself can be expressed as ASCII characters, as a graphic, or using TeX, LaTeX, or MathML mathematics expressions.

## ~~[italic](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-wqe0.html)~~
Used to mark text that should appear in an italic or slanted font.

## [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)
Sequence of two or more items, which may or may not be ordered.

## [mml:math](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cgn0.html)
Use documentation for the Mathematical Markup Language (MathML) 3.0 Tag Set (http://www.w3.org/TR/MathML3/) or the Mathematical Markup Language (MathML) 2.0 Tag Set (http://www.w3.org/TR/MathML2/).

## ~~[monospace](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-26n0.html)~~
Used to mark text that should appear in a non-proportional font, such as courier.

## ~~[named-content](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-qk60.html)~~

## ~~[open-access](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fkd0.html)~~
Open access provisions that apply to a work or the funding information that provided the open access provisions.

## ~~[overline](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-72d0.html)~~
Used to mark text that should appear with a horizontal line above each character.

## ~~[overline-start](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-2wd0.html)~~
Milestone indicating the beginning of overline emphasis.

## ~~[overline-end](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-dad0.html)~~
Milestone indicating the end of overline emphasis.

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
Text in which spaces, tabs, and line feeds must be preserved. Content is typically displayed in monofont to preserve character alignment.

## ~~[roman](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-say0.html)~~
Used to mark text that should remain in roman script no matter what style the surrounding text takes on.

## ~~[ruby](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ety0.html)~~
An inline wrapper element that surrounds some of the document narrative text in the same way a bold or italic emphasis would. The <ruby> element contains a Ruby Base (<rb> element) which contains the document text and one or more Ruby Textual Annotations (<rt> elements) that apply to that base text.

## ~~[sans-serif](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gey0.html)~~
Used to mark text that should appear in a sans-serif font.

## ~~[sc](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ary0.html)~~
Used to mark text that should appear in a font that creates smaller capital letters.

## [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
Headed group of material; the basic structural unit of the body of a document.
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

## [statement](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sdp0.html)
Theorem, Lemma, Proof, Postulate, Hypothesis, Proposition, Corollary, or other formal statement, identified as such with a label and usually made typographically distinct from the surrounding text.

## ~~[strike](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ezp0.html)~~
Used to mark text that should appear with a line through it so as to appear struck out.

## ~~[styled-content](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-piq0.html)~~

## supplementary-material

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

## ~~[underline](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-bnk2.html)~~
Used to mark text that should appear with a horizontal line beneath it.

## ~~[underline-start](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-hjk2.html)~~
Milestone indicating the start of underlined text.

## ~~[underline-end](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-syk2.html)~~
Milestone indicating the end of underlined text.

## ~~[uri](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mzk2.html)~~
