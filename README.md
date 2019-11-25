# TEICite

This repository contains a collection of scripts to create an annotated bibliography in [TEI](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/CO.html#COBI) format using [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc/).

`pandoc-citeproc` supports an inofficial extension to the [CSL](http://docs.citationstyles.org/en/stable/specification.html) specification that allows to add markup to automatically generated bibliographies. This can be used to add TEI elements like `<author>` or `<title>` to the output. The resulting bibliography will thus be semantically annotated.

This repository contains three sample files:

* `chicago-author-date-tei.csl` is a modified version of the official CSL style with added annotations. It serves as an example.
* `div2bibl.xsl` is a trivial XSLT script that converts the `div`/`p` structure that pandoc produces into TEI `listBibl`/`bibl`.
* `csl_teify.xsl` is an XSLT script that tries to automatically add some annotation information to a CSL style. The result will not be perfect and most probably requires some tuning. But it will make the creation of annotated styles easier. Current limitations:
    - In most cases (except for series titles), the `level` attribute of `title` is omitted. Deciding whether a title is of level a, m, or j requires some non-trivial parsing (and potentially extension) of the CSL logic.
    - The script annotates bibliography and citation information alike. Having rich annotations in the citations might be undesirable.

Such a style can be used to generate a bibliography from any reference format that `pandoc-citeproc` can read. Since TEI (e.g., `biblStruct`) is not among these, a first step might require to generate a MODS, BibTeX, or CSL JSON file.
