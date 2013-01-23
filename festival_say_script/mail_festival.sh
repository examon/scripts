#!/bin/sh

#cat 1339849609_0.16997.beast\,U\=212\,FMD5\=7e33429f656f1e6e9d79b29c3f82c57e\:2\, | egrep "From:" | cut -f2- -d ' '

mailbox_path=~/Mail/INBOX/new/

say_from()
{
	for file in $mailbox_path*; do
		from=$(cat $file | egrep "From:" | cut -f2- -d ' ')
		echo $from
		echo "from $from" | festival --tts
	done
}

main()
{
	while true;
	do
		inbox=$(ls $mailbox_path | wc -l)
		if [ $inbox -eq 1 ]; then
			echo "Attention! You have $inbox new e-mail." | festival --tts
			say_from
		elif [ $inbox -gt 1 ]; then
			echo "Attention! You have $inbox new e-mails." | festival --tts
			say_from
		fi
		sleep 10s
	done
}

main
