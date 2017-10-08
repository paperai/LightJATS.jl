# Light JATS Specification

## [article](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ja30.html)
* front
* body
* back
* floats-group

## [front](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-j6s0.html)
* ~~article-meta~~
    * ~~title-group~~
        * article-title
        * children of article-title (count):
        * math (10), styled-content (4124), inline-formula (395), bold(1622), ext-link (24),
        * named-content (5568), sc (1397), sup (33916), abbrev (4), sub (24324), underline (380),
        * xref (8864), monospace (37), related-article (25), italic (259660), uri (3), sans-serif (1),
        * break (45), fn (11), inline-graphic (9)
    * abstract
* ~~contrib-group~~
    * ~~contrib[@contrib-type="author"]~~ → rename to `author`
        * ~~name~~
            * prefix
            * given-names
            * surname
            * suffix


## [body](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-jn50.html)
* [Paragraph-level Elements]
* disp-formula
* disp-formula-group
* [Lists]
* [Math Elements]
* p
* ~~disp-quote~~
* statement
* sec

## [back](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-2450.html)

## [floats-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-44s0.html)
* boxed-text
* fig
* fig-group
* table-wrap
* table-wrap-group

## [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
* ~~label~~ → merge with `title`
* title
* disp-formula
* disp-formula-group
* [Lists]
* [Math Elements]
* p
* ~~disp-quote~~
* statement
* sec

### [p](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7xd0.html)
* [Linking Elements]
* [Emphasis Elements]
* ~~chem-struct~~
* inline-formula
* [Math Elements]
* [Other Inline Elements]
* fn
* ~~target~~
* xref
* sub
* sup
* [Paragraph-level Elements]
* disp-formula
* disp-formula-group
* ~~award-id~~
* ~~funding-source~~
* ~~open-access~~
* [Lists]
* disp-quote
* statement

## [boxed-text](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i950.html)
* label
* caption
* [Paragraph-level Elements]
* disp-formula
* disp-formula-group
* [Lists]
* [Math Elements]
* p
* ~~disp-quote~~
* statement
* sec

## [disp-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tmx0.html)

## [disp-formula-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-v8v0.html)
* label
* caption
* [Linking Elements]
* disp-formula
* disp-formula-group

## ~~[disp-quote](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fuv0.html)~~

## [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)

## [fig-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-83s0.html)

## [table-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mb90.html)

## [table-wrap-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-c5m0.html)

## [fn](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-87s0.html)
* label
* p

## [inline-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gw70.html)
* [Linking Elements]
* ~~hr~~
* ~~[Emphasis Elements]~~
* alternatives?
* [Inline Display Elements]?
* ~~chem-struct~~
* inline-formula
* [Math Elements]
* [Other Inline Elements]
* fn
* ~~target~~
* xref
* sub
* sup

* mml:math 646574
* alternatives 593978
* inline-formula 8436
* inline-graphic 1598358

## [statement](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sdp0.html)
* ~~label~~ → merge with `title`
* title
* p

## [sub](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-9zq0.html)
* [Emphasis Elements]
* [Linking Elements]
* [Math Elements]
* [Other Inline Elements]
* inline-formula
* sub
* sup
* xref
* ~~break~~
* ~~target~~

### [sup](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-5zb0.html)
same as `sub`

## [xref](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ucc2.html)
* styled-content
* inline-formula
* named-content
* strike
* sup
* xref
* break
* inline-graphic
* [Emphasis Elements]

## [Paragraph-level Elements]
* boxed-text
* chem-struct-wrap
* code
* fig
* fig-group
* preformat
* supplementary-material
* table-wrap
* table-wrap-group

## [Linking Elements]
* ~~email~~
* ~~ext-link~~
* ~~uri~~

## [Lists]
* [def-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-4hx0.html)
* [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)

## [Math Elements]
* ~~tex-math~~
* [mml:math](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cgn0.html)

## [Other Inline Elements]
* ~~abbrev~~
* ~~named-content~~
* ~~styled-content~~

## [Emphasis Elements]
* ~~bold~~
* ~~italic~~
* ~~monospace~~
* ~~overline~~
* ~~roman~~
* ~~sans-serif~~
* ~~sc~~
* ~~strike~~
* ~~underline~~
