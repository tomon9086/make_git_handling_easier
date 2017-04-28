gethelp() {
	echo "usage: gitp [<commit message>][-f <ssh address>][-h]"
	echo "	-f: first commit"
	echo "	-h: help"
	exit 1
}

name="******"
email="*********@example.com"

while getopts f:h OPT
do
	case $OPT in
		f)	status="first_commit"
			address=$OPTARG
			echo $address
			if [ -z $address ]; then
				exit 1
			fi
			;;
		h)	status="help"
			gethelp
			;;
		\?) status="unexpected_option"
			gethelp
            ;;
	esac
done

if [ $# -eq 0 ]; then
	gethelp
	exit 1
elif [ -z $status ]; then
	commit_message=$*
	# echo "pulling..."
	git pull
	git add -A
	# echo "committing..."
	git commit -m "${commit_message}"
	# echo "pushing..."
	git push
	exit 0
fi

if [ -n $address ]; then
	git config --global user.name $name
	git config --global user.email $email
	git init
	git add -A
	git commit -m "first commit"
	git remote add origin $address
	git push -u origin master
fi
