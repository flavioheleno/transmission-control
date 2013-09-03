#!/bin/bash

APP="/usr/bin/transmission-remote"
PEERS=6000
RATIO=1.0
DIR="/home/flavio/Downloads/"

if [ -z "$1" ]; then
	echo "usage:"
	echo "	$0 add <magnet-link or torrent>"
	echo "	$0 remove [id]"
	echo "	$0 delete <id>"
	echo "	$0 start [id]"
	echo "	$0 stop [id]"
	echo "	$0 info <id>"
	echo "	$0 verify"
	echo "	$0 list"
	echo "	$0 setup"
	echo "	$0 exit"
	exit
fi
if [ "$1" == "add" ]; then
	if [ -z "$2" ]; then
		echo "Missing magnet-link or torrent"
		exit
	fi
	$APP --add "$2" --peers $PEERS --seedratio $RATIO --encryption-required
elif [ "$1" == "remove" ]; then
	if [ -z "$2" ]; then
		$APP --torrent all --remove
	else
		$APP --torrent "$2" --remove
	fi
elif [ "$1" == "delete" ]; then
	if [ -z "$2" ]; then
		echo "Missing torrent id"
		exit
	fi
	$APP --torrent "$2" --remove-and-delete
elif [ "$1" == "start" ]; then
	if [ -z "$2" ]; then
		$APP --torrent all --start
	else
		$APP --torrent "$2" --start
	fi
elif [ "$1" == "stop" ]; then
	if [ -z "$2" ]; then
		$APP --torrent all --stop
	else
		$APP --torrent "$2" --stop
	fi
elif [ "$1" == "info" ]; then
	if [ -z "$2" ]; then
		echo "Missing torrent id"
		exit
	fi
	$APP --torrent "$2" --info
elif [ "$1" == "verify" ]; then
	$APP --torrent all --verify
elif [ "$1" == "list" ]; then
	$APP --list
elif [ "$1" == "setup" ]; then
	$APP --torrent all --no-downlimit
	$APP --torrent all --cache 8192
	$APP --torrent all --encryption-required
	$APP --torrent all --portmap
	$APP --torrent all --dht
	$APP --torrent all --bandwidth-high
	$APP --torrent all --seedratio $RATIO
	$APP --torrent all --utp
	$APP --torrent all --download-dir $DIR
	$APP --torrent all --peers $PEERS
	$APP --torrent all --pex
	$APP --torrent all --lds
	$APP --torrent all --tracker-add "udp://tracker.publicbt.com:80"
	$APP --torrent all --tracker-add "udp://tracker.openbittorrent.com:80"
	$APP --torrent all --tracker-add "udp://tracker.ccc.de:80"
	$APP --torrent all --tracker-add "udp://tracker.istole.it:80"
elif [ "$1" == "exit" ]; then
	$APP --exit
else
	echo "Invalid option"
fi
