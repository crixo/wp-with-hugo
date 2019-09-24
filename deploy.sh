#!/bin/bash

# find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} ";"
#find public -type f -exec curl -v -u $FTP_USER:$FTP_PASSWORD --use-ascii --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} \;

set -e

sudo apt-get install -y lftp

LOCALPATH='./public'
REMOTEPATH='/web/public'

lftp -f "
set ftp:ssl-allow no
open ftp://ftp.webprofessor.it
user $FTP_USER $FTP_PASSWORD
mirror --continue --reverse --delete $LOCALPATH $REMOTEPATH
bye
"
