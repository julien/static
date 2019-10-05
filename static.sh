#!/bin/bash
rm *.html
for i in *.md; do
	n=$(basename "$i" | sed s/\.md/.html/)
	echo "<a href=\"$n\">$(echo "$n" | sed "s/\.html//" | sed "s/\_/ /")</a><br>" >> index.html
	Markdown.pl "$i" > "$n"
done
