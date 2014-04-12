DBNAME=members

DB=$(DBNAME).db
CSV=$(DBNAME)_primary_only.csv
JSON=$(DBNAME).json
TEX=$(DBNAME).tex
PDF=$(DBNAME).pdf

ALL=$(DB) $(CSV) $(JSON) $(TEX) $(PDF)

db: $(DB)
$(DB): structure.sql members.sql
	cat $^ | sqlite3 $@

csv: $(CSV)
$(CSV): $(DB)
	sqlite3 $(DB) <scripts/create_primary_csv.sql >$@

json: $(JSON)
$(JSON): $(DB)
	python scripts/create_json.py $(DB) >$@

tex: $(TEX)
$(TEX): $(JSON)
	python tools/pyratemp_tool.py -f $(JSON) scripts/create_tex.tmpl >$@

pdf: $(PDF)
$(PDF): $(TEX)
	pdflatex $(TEX)
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
		-dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed.pdf $(PDF)
	mv compressed.pdf $(PDF)

clean:
	rm -f $(ALL)
	rm -f *.toc *.aux *.log *.out
