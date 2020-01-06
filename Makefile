.SUFFIXES: .pdf .tex .m .matlab

OBJDIR = build
FIGDIR = ${OBJDIR}/fig
AUX = .aux .log .toc .fls .fdb_latexmk .bbl .blg .out .lof .lot .bcf .run.xml

LMKOPTS = -pdf -output-directory=${OBJDIR}
LATEXMK = ${LMKVARS} latexmk ${LMKOPTS}

STNUM = stnum

report: doc/report.pdf

zip: report
	rm -rf ${OBJDIR}/${STNUM}
	mkdir -p ${OBJDIR}/${STNUM}
	cp -r src ${OBJDIR}/${STNUM}
	peg-markdown readme.md | elinks -dump > ${OBJDIR}/${STNUM}/readme.txt
	cp ${OBJDIR}/report.pdf ${OBJDIR}/${STNUM}
	cd ${OBJDIR} && tar -cvzf ${STNUM}.tar.gz ${STNUM}


img: imgs.zip
	unzip -d imgtmp imgs.zip
	tar -xvf imgtmp/DIIP-images-bias.tar
	tar -xvf imgtmp/DIIP-images-dark.tar
	tar -xvf imgtmp/DIIP-images-flat.tar
	tar -xvf imgtmp/DIIP-images-measurements-1.tar
	tar -xvf imgtmp/DIIP-images-measurements-2.tar
	rm -r imgtmp
	mkdir -p img
	mv DIIP-images/* img
	rmdir DIIP-images/
	find img -type f -a ! -name '*.JPG' | xargs rm

.tex.pdf:
	${LATEXMK} $<

.m.matlab:
	matlab -nodisplay -nosplash -nodesktop -r "run('$<');exit;"

clean:
	for ft in ${AUX}; do rm -rf $$(find . -name "*$$ft"); done

distclean:
	rm -rf ${OBJDIR} img
