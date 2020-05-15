#!/bin/bash
set -o errexit
set -o pipefail

__main() {
	[[ -f "./index.html" ]] && rm -i "./index.html"

	local list=""

	while IFS= read -r -d '' file
	do
		local output
		output=$(basename "$file" | sed -e s/\.md/.html/ -e s/[[:blank:]]/-/g)

		local date
		date=$(date -r "$file" -I)

		list+=$(cat <<-END
			<li><a href="$output">$(echo "$output" | sed -e "s/\.html//" -e "s/-/ /") <time datetime="$date" style="float: right;font-size: smaller">$date</time></a></li>
		END
		)

	local html
	html=$(cat <<-END
<meta name=viewport content=width=device-width,initial-scale=1>
$(Markdown.pl "$file")
END
)
		echo "$html" > "$output"

	done < <(find . -name '*.md' -not -iname 'readme*' -print0)

	local index
	index=$(cat <<-END
			<!DOCTYPE html>
			<html>
			<head>
				<meta name=viewport content="width=device-width, initial-scale=1">
				<style>
					ul {margin:0;padding:0}
					li {margin: 8px 0;list-style:none;}
					time {float:right;font-size:small;}
				</style>
			</head>
			<body>
				<ul>
					$list
				</ul>
			</body>
			</html>
		END
	)
	echo "$index" >> index.html
	echo "Generated"
}

__main "$@"
