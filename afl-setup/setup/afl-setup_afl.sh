#!/bin/bash

depend=0

get_updates()
{
	echo "Checking for updates ... "
	sleep 1
    apt-get update &>/dev/null
	
}

get_dependencies()
{
	echo "Testing to see if system has valid dependencies ..."
	sleep 1
	if [ "$(which make)" = "" ]; then
		echo "[-] Missing 'Make'"
		sleep 1
		echo "Installing make ..."
		sleep 1
		apt install make -y &>/dev/null
		if [ $? -eq 0 ]; then
			echo "[+] Installation of 'make' succeeded"
			sleep 1
			depend=$((depend+1))
		else
			echo "[-] Installation of 'make' failed ... exiting"
			exit 1;
		fi
	else
		depend=$((depend+1))
	fi
	
	if [ "$(which gcc)" = "" ]; then
		echo "[-] Missing 'gcc'"
		sleep 1
		echo "Installing gcc ..."
		sleep 1
		apt install gcc -y &>/dev/null
		if [ $? -eq 0 ]; then
			echo "[+] Installation of 'gcc' succeeded"
			sleep 1
			depend=$((depend+1))
		else
			echo "[-] Installation of 'gcc' failed ... exiting"
			exit 1;
		fi
	else
		depend=$((depend+1))
	fi

	if [ "$(which gdb)" = "" ]; then
		echo "[-] Missing 'gdb'"
		sleep 1
		echo "Installing gdb ..."
		sleep 1
		apt install gdb -y &>/dev/null
		if [ $? -eq 0 ]; then
			echo "[+] Installation of 'gdb' succeeded"
			sleep 1
			depend=$((depend+1))
		else
			echo "[-] Installation of 'gdb' failed ... exiting"
			exit 1;
		fi
	else
		depend=$((depend+1))
	fi

	if [ $depend -eq 3 ]; then
		echo "[+] Valid configuration, continuing ..."
		sleep 1
	else
		echo "[-] Invalid configuration, exiting ..."
		exit 1
	fi
}

installAfl()
{
	if [ "$(which afl-fuzz)" = "" ]; then
		echo "Installing AFL ..."
		sleep 1
		apt install afl -y &>/dev/null
		if [ $? -eq 0 ]; then
			sudo su root -c "echo core >/proc/sys/kernel/core_pattern" 
			echo "[+] Install completed"
			sleep 1
		else
			echo "[-] Install failed"
			exit 1
		fi
	else
		echo "AFL already installed"
	fi
}

main()
{
	get_updates
	get_dependencies
	installAfl
}

main
