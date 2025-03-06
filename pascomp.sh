#!/bin/sh
rm -rf ~/.besm6/input_queue
./togost < pasauto.pas > pasauto.gost
len=`cat pasauto.gost|wc -c`
zones=$(($len/6144))
words=$((($len-$zones*6144+5)/6))
echo File length is $zones zones and $words words
dispak -s pult2.b6 << EOF
дай новарх,50,100,вася
арх вася,50,100,100
з нов(30)
конец
EOF
besmtool write 2345 --start=0101 --from-file=pasauto.gost

dispak -s pult2.b6 << EOF
арх вася,50,100
пас нов - па зонгп 500300 20
конец
EOF
