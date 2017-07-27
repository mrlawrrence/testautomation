#!/bin/bash

rand=$RANDOM
secret=${rand:0:1}

function game{
  read -p "Guess a random one-digit number! " guess
  while [[ $guess != $secret ]];
   do
         read -p "nope, try again!" guess

   done
   echo "good job! "

}


function generate {
   echo "A random number is $rand"
}


if [[ $1=~ game|Game|GAME ]]; then

else

dfdfdf

