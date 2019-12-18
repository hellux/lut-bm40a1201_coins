.SUFFIXES: .pdf .tex

OBJDIR = build
FIGDIR = ${OBJDIR}/fig
AUX = .aux .log .toc .fls .fdb_latexmk .bbl .blg .out .lof .lot .bcf .run.xml

LMKOPTS = -pdf -output-directory=${OBJDIR}
LATEXMK = ${LMKVARS} latexmk ${LMKOPTS}

report: doc/report.pdf

.tex.pdf:
	${LATEXMK} $<

clean:
	for ft in ${AUX}; do rm -rf $$(find . -name "*$$ft"); done

distclean:
	rm -rf ${OBJDIR}
