#!/bin/bash

# find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} ";"
#find public -type f -exec curl -v -u $FTP_USER:$FTP_PASSWORD --use-ascii --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} \;

set -e

sudo apt-get install -y lftp

LOCALPATH='./public'
REMOTEPATH='/web/public/'

# set ssl:verify-certificate no
# set ftp:ssl-allow no

# lftp -f "
# open ftp://ftp.webprofessor.it
# user $FTP_USER $FTP_PASSWORD
# set ftp:ssl-allow no
# mirror --continue --reverse --delete --verbose $LOCALPATH $REMOTEPATH
# bye
# "
lftp -e "set ftp:ssl-allow no; mirror -v -R ./public/ web/" -u $FTP_USER,$FTP_PASSWORD ftp://ftp.webprofessor.it

