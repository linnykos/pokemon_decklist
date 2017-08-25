#!/bin/bash

cd "raw_cards_pokemon"
files=`ls`
echo "$files"
#echo `pwd`

for card in $files
do
  convert $card -crop 633x387+962+356 "../cards/$card"
done