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

##############
cd $home
cd "raw_cards_energy"
files=`ls`

for card in $files
do
  convert $card -crop 633x387+962+584 "../cards/$card"
done


##############
cd $home
cd "raw_cards_special_energy"
files=`ls`

for card in $files
do
  convert $card -crop 685x419+941+443 "../cards/$card"
  convert "../cards/$card" -resize 633x387 "../cards/$card"
done

##############
cd $home
cd "raw_cards_break"
files=`ls`

for card in $files
do
  convert $card -background white -virtual-pixel background +distort ScaleRotateTranslate +90 +repage "../cards/$card"
  convert "../cards/$card" -crop 633x387+533+1070 "../cards/$card"
done
