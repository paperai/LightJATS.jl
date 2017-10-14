# LightJATS Specification

* [article](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ja30.html)
    * [article-title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-e630.html)
    * ~~[contrib[@contrib-type="author"]](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-n3w0.html)~~ → rename to `author`
        * [prefix](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-jxr0.html)
        * [given-names](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-fwt0.html)
        * [surname](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sg90.html)
        * [suffix](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-djb0.html)
    * [abstract](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ba20.html)
    * [boxed-text](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-i950.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [code](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ty80.html)
    * [def-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-4hx0.html)
        * ~~[label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)~~ → merge with `title`
        * [title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7fz0.html)
        * [def-item](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ndx0.html)
            * [term](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-pdm0.html)
            * [def](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-xtx0.html)
    * [disp-formula](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tmx0.html)
        * [mml:math](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cgn0.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
    * [disp-formula-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-v8v0.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [fig](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ib40.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [fig-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-83s0.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-64g0.html)
        * ~~[label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)~~ → merge with `title`
        * [title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7fz0.html)
        * [list-item](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-ctg0.html)
    * [p](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7xd0.html)
    * [ref-list](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-g2i0.html)
        * ~~[label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)~~ → merge with `title`
        * [title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7fz0.html)
        * [ref](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-2mh0.html)
            * citation
                * article-title
                * collab
                * name
                * day
                * month
                * year
                * edition
                * publisher-name
                * publisher-loc
                * pub-id
                * volume
                * fpage
                * lpage
                * source
                * issue
                * ~~string-name~~ → NG
                * ~~person-group~~
                * ~~comment~~
                * ~~elocation-id"=>1~~
                * ~~named-content"=>1~~
                * ~~issue-title"=>1~~
                * ~~etal"=>7~~
                * ~~xref"=>27~~
                * ~~size"=>1~~
                * ~~date-in-citation"=>8~~
            * ~~element-citation~~
            * ~~mixed-citation~~
    * [sec](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-gby0.html)
        * ~~[label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)~~ → merge with `title`
        * [title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7fz0.html)
    * [statement](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sdp0.html)
        * ~~[label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)~~ → merge with `title`
        * [title](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-7fz0.html)
    * [sub](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-9zq0.html)
    * [sup](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-5zb0.html)
    * [table](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-by90.html)
        * [thead](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-u7z0.html)
        * [tbody](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-g4m0.html)
        * [tfoot](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-8az0.html)
        * [tr](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-jyz0.html)
            * [th](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-cuz0.html)
            * [td](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-tsm0.html)
    * [table-wrap](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-mb90.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [table-wrap-group](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-c5m0.html)
        * [label](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-sqf0.html)
        * [caption](https://jats.nlm.nih.gov/archiving/tag-library/1.1d1/n-d580.html)
    * [xref](https://jats.nlm.nih.gov/archiving/tag-library/0.4/n-gnb0.html)
