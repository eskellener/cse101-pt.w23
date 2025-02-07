#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/tekinengin/cse101-pt.w23/main/pa1

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelListTest.c > ModelListTest.c

echo ""
echo ""

echo "Press Enter To Continue with ListTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelListTest.c List.c
gcc -std=c17 -o ModelListTest ModelListTest.o List.o

timeout 5 valgrind --leak-check=full -v ./ModelListTest -v > ListTest-out.txt 2> ListTest-mem.txt
if [ $? -eq 124 ]; then
    echo -e "${RED} ModelListTest TEST TIMED OUT ${NC}"
fi

cat ListTest-out.txt

echo "List Valgrind Test: (press enter)"
read garbage
cat ListTest-mem.txt

rm -f *.o ModelListTest* Lex ListTest-out.txt ListTest-mem.txt

