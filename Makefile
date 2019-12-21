.SUFFIXES: .pdf .tex .m .matlab

OBJDIR = build
FIGDIR = ${OBJDIR}/fig
AUX = .aux .log .toc .fls .fdb_latexmk .bbl .blg .out .lof .lot .bcf .run.xml

LMKOPTS = -pdf -output-directory=${OBJDIR}
LATEXMK = ${LMKVARS} latexmk ${LMKOPTS}

report: doc/report.pdf

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
