#!/bin/bash

home=`pwd`
cd $home
cd "raw_cards_pokemon"
files=`ls`

for card in $files
do
  convert $card -crop 633x387+962+356 "../cards/$card"
done

##############
cd $home
cd "raw_cards_trainer"
files=`ls`

for card in $files
do
  convert $card -crop 633x387+966+408 "../cards/$card"
done