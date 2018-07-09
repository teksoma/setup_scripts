#!/bin/bash

runningScripts()
{
	./setup/afl-setup_afl.sh
	./setup/afl-setup_utils.sh
}

main()
{
	if [ $(id -u) -eq 0 ]; then
		runningScripts
		echo "Completed"
		exit 1
	else
		echo "Run this script as sudo"
	fi
}

main
