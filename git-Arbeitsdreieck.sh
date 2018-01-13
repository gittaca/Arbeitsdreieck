#!/usr/bin/env bash

# Das Git-Arbeitsdreieck: forken von upstream, clonen von origin (=fork), lokal schnell was ändern, pushe origin, erstelle pull/merge request
# 
# Benutzung nach Download: 
# 1. … hinter ME= mit eigenem Nutzernamen beim Git-Hoster ersetzen
# 2. git config alias.ad = !bash /path/to/git-Arbeitsdreieck.sh
# 3. git ad https://githoster.tld/upstream/repo.git
#
# Achtung: Dieses Skript nimmt an, dass https://github.com/desktop/ & https://atom.io/ lokal installiert sind.

set -eux -o pipefail
# gelernt von codeinthehole.com/tips/bash-error-reporting

UPSTREAM=$1
ME=…

# konstruiere URL meines fork, mit user@ & clone davon
UP_USR=`echo $UPSTREAM | cut -f 4 -d /`
ORIGIN=`echo $UPSTREAM | sed "s;//;//$ME@;"`
ORIGIN=`echo $ORIGIN | sed -e "s;$UP_USR;$ME;"`

git clone \
	--depth=1 \
	--no-single-branch \
	$ORIGIN 

REPO=`echo $UPSTREAM | cut -f 5 -d / | sed "s/\.git$//"`

atom $REPO
cd $REPO
git remote add upstream $UPSTREAM
github
