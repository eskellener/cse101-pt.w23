#!/bin/bash

SRCDIR=https://raw.githubusercontent.com/eskellener/cse101-pt.w23/main/pa2

curl $SRCDIR/ModelGraphTest.c > ModelGraphTest.c

echo ""
echo ""

rm -f *.o FindPath

echo "Press Enter To Continue with GraphTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelGraphTest.c Graph.c List.c
gcc -o ModelGraphTest ModelGraphTest.o Graph.o List.o

timeout 6 valgrind --leak-check=full -v ./ModelGraphTest -v > GraphTest-out.txt 2> MemoryCheck.txt
if [ $? -eq 124 ]; then
    echo -e "${RED} ModelGraphTest TEST TIMED OUT ${NC}"
  fi

cat MemoryCheck.txt
cat GraphTest-out.txt

rm -f *.o ModelGraphTest* FindPath garbage GraphTest-out.txt MemoryCheck.txt

