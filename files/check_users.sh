#!/bin/bash
DAYS_BETWEEN=$1
DAYS_WARNING=$2
EXCLUDED_USER=$3

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Get list of users which can login and have UID>=1000
for user in $(egrep -v '(nologin|false)$' /etc/passwd | egrep -v "^${EXCLUDED_USER}" | awk -F':' '$3>=1000 {print $1}'); do
  # Check for password expiration
  res=$(chage -l $user)
  echo "$res" | egrep -q "Password expires.*never"
  if [ $? -eq 0 ]; then
    echo -n "password of $user never expires, that's wrong... "
    chage -d 0 $user
    echo "Fixed."
  fi
  echo "$res" | egrep -q "Maximum number of days between password change.*${DAYS_BETWEEN}"
  if [ $? -ne 0 ]; then
    echo -n "password max days for $user is wrong... "
    chage -M $DAYS_BETWEEN $user 2>/dev/null
    echo "Fixed."
  fi
  echo "$res" | egrep -q "Number of days of warning before password expires.*${DAYS_WARNING}"
  if [ $? -ne 0 ]; then
    echo -n "password warning days for $user is wrong... "
    chage -W $DAYS_WARNING $user 2>/dev/null
    echo "Fixed."
  fi
done
