#!/bin/bash

home=`pwd`
cd $home
cd "raw_cards_pokemon"
files=`ls`

for card in $files
do
  if ! [ -f "../../images/cards/$card" ]
  then
    convert $card -crop 633x387+962+356 "../../images/cards/$card"
  fi
done

##############
cd $home
cd "raw_cards_trainer"
files=`ls`

for card in $files
do
  if ! [ -f "../../images/cards/$card" ]
  then
    convert $card -crop 633x387+966+408 "../../images/cards/$card"
  fi
done

##############
cd $home
cd "raw_cards_energy"
files=`ls`

for card in $files
do
  if ! [ -f "../../images/cards/$card" ]
  then
    convert $card -crop 633x387+962+584 "../../images/cards/$card"
  fi
done


##############
cd $home
cd "raw_cards_special_energy"
files=`ls`

for card in $files
do
  if ! [ -f "../../images/cards/$card" ]
  then
    convert $card -crop 685x419+941+443 "../../images/cards/$card"
    convert "../../images/cards/$card" -resize 633x387 "../../images/cards/$card"
  fi
done

##############
cd $home
cd "raw_cards_break"
files=`ls`

for card in $files
do
  if ! [ -f "../../images/cards/$card" ]
  then
    convert $card -background white -virtual-pixel background +distort ScaleRotateTranslate +90 +repage "../../images/cards/$card"
    convert "../../images/cards/$card" -crop 633x387+533+1070 "../../images/cards/$card"
  fi
done

###############
cd $home
cd "raw_set_symbol"
files=`ls`

for set in $files
do
  if ! [ -f "../../images/sets/$set" ]
  then
    convert $set -resize 77x77 "../../images/sets/$set"
  fi
done
