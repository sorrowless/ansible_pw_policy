#!/bin/bash
EXCLUDED_USER=$1

CHANGED=0

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

res=$(chage -l $EXCLUDED_USER)
echo "$res" | egrep -q "Password expires.*never"
if [ $? -ne 0 ]; then
  echo -n "password of $EXCLUDED_USER expires but it shouldn't. Let's fix it."
  chage -d 2020-01-01 $EXCLUDED_USER
  chage -m 0 -M 99999 -W 7 $EXCLUDED_USER
  echo "Fixed."
  CHANGED=2
fi
exit $CHANGED
