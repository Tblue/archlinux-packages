#!/bin/sh

if [ $# -lt 2 ]; then
	echo "Usage:"
	echo " ${0} program-path user-startup-file [logfile]"
	echo
	echo "Note: user-startup-file and logfile have to be relative to the user's"
	echo "      home directory."

	exit 1
fi

if [ -n "$3" ]; then
	exec 1>"${HOME}/${3}" 2>&1
fi

user_startup_file="${HOME}/${2}"

if [ ! -f "${user_startup_file}" ]; then
	exec "${1}"
else
	exec sh "${user_startup_file}"
fi
