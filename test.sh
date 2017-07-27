#!/bin/bash


read -p "Favorite animal?[cat] " a
while [[ -z "$a"     ]];do
        a="cat"
done


while getopts u:p:ab option;
do
 case $option in
           u) user=$OPTARG;;
           p) pass=$OPTARG;;
           a) echo "Got a";;
           b) echo "Got b";;
  esac

done

echo "user: $user  / Pass: $pass"
