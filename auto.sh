#! /bin/bash

echo "Automode initiated\n the program will move to right bin, fetch disk, place it in the cd-rom and do a copy with makemkv, once copy is completed the disk will be placed in the left bin"

./control.sh 7 #close optical
sleep 5
./control.sh 1 #move to right
sleep 10
./control.sh 5 #pick disc
sleep 10
./control.sh 4 #move to optical
sleep 10
./control.sh 6 #open optical
sleep 10
./control.sh 5 #drop disc
sleep 20
./control.sh 7 #close optical
sleep 20
echo "Starting MakemMKV"
#makemkvcon -r mkv disc:0 all --minlength=300 /home/olaf/Videos/tmp &&
echo "MakeMKV is completed"
./control.sh 6 #open optical
./control.sh 4 #move to optical
sleep 30
./control.sh 5 #pick disc
sleep 10
./control.sh 7 #close optical
./control.sh 2 #move to left
sleep 10
./control.sh 5 #drop disc
sleep 20
