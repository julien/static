#!/bin/bash
set -o errexit
set -o pipefail

__main() {
	#rm -i *.html
	for i in $(find . -name '*.md' -not -iname 'readme*'); do
		n=$(basename "$i" | sed s/\.md/.html/)
		echo "<a href=\"$n\">$(echo "$n" | sed -e "s/\.html//" -e "s/\_/ /")</a><br>" >> index.html
		#Markdown.pl "$i" > "$n"
		#echo "$i"
		local md
		local output
		md=$(Markdown.pl "$i")
		output=$(cat <<-END
		<!doctype html>
		<html>
			<body>
				$md
			</body>
		</html>
		END
		)
		echo "$output" >> "$n"
	done
}

__main "$@"
