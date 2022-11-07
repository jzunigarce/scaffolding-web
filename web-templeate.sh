#!/bin/bash

create_dir() {
	if [ $# -lt 1 ]
	then
		echo 1>&2 "Arg dirname not passed"
		exit 2
	fi

	if [ $# -eq 1 ]
	then
		mkdir -p "$1"
	else
		mkdir -p "$2"/"$1"
	fi
}

create_file() {
	if [ $# -lt 1 ]
	then
		echo 1>&2 "Arg filename not passed"
		exit 2
	fi

	if [ $# -eq 1 ];
	then
		touch "$1"
	else
		touch "$2"/"$1"
	fi
}

create_template_file() {
	if [ $# -lt 2 ]
	then
		echo 1>&2 "Arg required"
		exit 2
	fi

	if [ $# -eq 2 ]
	then
	cat <<EOF > "$1"
$2
EOF
	else
		cat <<EOF "$1"/"$3" 
"$2"
EOF
	fi
}


if [ $# -eq 0 ]; 
then
	echo 1>&2 "Arg dirname not passed"
	exit 2
fi

dirname="$1"

printf 'Generating project %s \U1F680\n' "$dirname"

if [ -d "$dirname" ]; then
	echo 1>&2 "$dirname directory already exists"
	exit 2
fi


create_dir $dirname

cd $dirname

dirnames=('js' 'css')
for i in "${dirnames[@]}"
do
	create_dir $i
done

printf 'Creating 2 dirs \U1F4C2\n'


create_file 'index.html'
create_file 'app.js' ${dirnames[0]}
create_file 'style.css' ${dirnames[1]}

printf 'Creating 3 files \U1F5D2\n'

HTML_TEMPLATE="$(cat <<EOFFILE
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
</body>
</html>
EOFFILE
)"
create_template_file 'index.html' "$HTML_TEMPLATE"

printf 'Successfully created project %s \U1F389\n' "$dirname"

echo -e "\n\033[1;30m$ \033[1;36mcd $dirname\033[m"
