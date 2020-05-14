#!/bin/bash
set -o errexit
set -o pipefail

__main() {
	rm -i *.html

	for i in $(find . -name '*.md' -not -iname 'readme*'); do
		n=$(basename "$i" | sed s/\.md/.html/)
		echo "<a href=\"$n\">$(echo "$n" | sed -e "s/\.html//" -e "s/\_/ /")</a><br>" >> index.html

		local md
		md=$(Markdown.pl "$i")

		local output
		output=$(cat <<-END
			<meta name=viewport content="width=device-width, initial-scale=1">
			$md
		END
		)

		echo "$output" > "$n"
	done
}

__main "$@"
