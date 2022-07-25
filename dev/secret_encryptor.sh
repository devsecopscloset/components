#!/bin/bash

tar -czf secrets $1 $2 $3 $4 &&

echo $4 | gpg --symmetric --passphrase-fd 0 --batch --yes --cipher-algo AES256 secrets &&

rm secrets