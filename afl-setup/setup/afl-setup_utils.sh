#!/bin/bash

check_depend()
{
	python3 -c "import setuptools" &>/dev/null
	if [ $? -ne 0 ]; then
		sudo apt-get install python3-setuptools -y &>/dev/null
	fi

	if [ "$(which git)" = "" ]; then
		echo "[-] 'git' is not installed'"
		sleep 1
		echo "Installing git"
		sleep 1
		sudo apt-get install git -y &>/dev/null
		if [ $? -eq 0 ]; then
			echo "[+] git successfully installed"
			sleep 1
		else
			echo "[-] unable to install git ... exiting"
			exit 1
		fi
	fi	
}

install_utils()
{
	git clone https://github.com/rc0r/afl-utils &>/dev/null 
	cd afl-utils/afl_utils
	sed -i '20s/.*/from multiprocessing import Queue/' afl_collect.py
	cd ..
	sudo python3 setup.py install &>/dev/null
	echo "Install complete"
}

main()
{
	check_depend
	install_utils
}

main
