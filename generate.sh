#!/usr/bin/bash

# Script to generate and print n bingo cards
n=100

for ((i=1;i<=n;i++))
do
    latexmk -lualatex squareCells.tex
    mv squareCells.pdf ${i}.pdf
    file+="${i}.pdf "
done
latexmk -c

pdfjoin $file
rm $file

num=$( expr ${n} - 1 )

for i in `seq 0 2 ${num}`; do
    ORDER+=$( expr 2 \* $i + 1 )'R '
    ORDER+=$( expr 2 \* $i + 3 )'R '
    ORDER+=$( expr 2 \* $i + 2 )'L '
    ORDER+=$( expr 2 \* $i + 4 )'L '
done

echo ${ORDER}

## https://github.com/hellerbarde/stapler
## Usage: stapler [options] mode input.pdf ... [output.pdf]
echo "stapler cat ${n}-joined.pdf ${ORDER} temp.pdf"
      stapler cat ${n}-joined.pdf ${ORDER} temp.pdf

## from pdfjam package
echo "pdfnup --nup 1x2 --papersize '{11in,8.5in}' --frame true temp.pdf"
      pdfnup --nup 1x2 --papersize '{11in,8.5in}' --frame true temp.pdf

echo "rm ${n}-joined.pdf"
      rm ${n}-joined.pdf

echo "rm temp.pdf"
      rm temp.pdf

echo "mv temp-nup.pdf printBingo.pdf"
      mv temp-nup.pdf printBingo.pdf


#echo $file
#pdfjoin $file

#for ((i=1; i<=n; i++))
#do
#    rm ${i}.pdf
#done
