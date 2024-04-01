#! /bin/bash

STORAGEPATH="/home/omsfah/Videos/tmp"
MAXDISCS=25

echo "Automode initiated\n the program will move to right bin, fetch disk, place it in the cd-rom and do a copy with makemkv, once copy is completed the disk will be placed in the left bin"

function check_disc_inserted {
    # Check if any optical discs are present
    if [ "$(lsblk -o name,type | grep rom)" ]; then
        return 0  # Disc is inserted
    else
        return 1  # No disc inserted
    fi
}

for ((i=1; i<=$MAXDISCS; i++)); do
    ./control.sh 7 #close optical
    sleep 5
    ./control.sh 1 #move to right
    sleep 10
    ./control.sh 5 #pick disc
    sleep 20
    ./control.sh 4 #move to optical
    sleep 10
    ./control.sh 6 #open optical
    sleep 10
    ./control.sh 5 #drop disc
    sleep 20
    ./control.sh 7 #close optical
    sleep 20
    if check_disc_inserted; then
        echo "Starting MakemMKV"
        #TITLES=(makemkvcon -r --minlength=300 info disc:0) && #Removed due to malfunction
        TITLES=1
        echo "Titles on disc: $TITLES"
        if [ $TITLES -le 15 ]; then
            mkdir $STORAGEPATH/disc_$i &&
            makemkvcon -r mkv disc:0 all --minlength=300 $STORAGEPATH/disc_$i &&
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
        else
            echo "Suspected disc obfuscation, dropping disc using kioskmode"
            sleep 30
            ./control.sh 6 #open optical
            ./control.sh 4 #move to optical
            sleep 30
            ./control.sh 5 #pick disc
            sleep 10
            ./control.sh 7 #close optical
            sleep 10
            ./control.sh 5 #drop disk
            break
        fi

    else
        echo "No disc inserted. Exiting."
        break
    fi

done

echo "Good bye!"
