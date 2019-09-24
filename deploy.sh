#!/bin/bash

# find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} ";"
find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} \;

