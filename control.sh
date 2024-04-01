#! /bin/bash

PREAMBLE="\x1b\x00\x10\xc0\xbd\x87\x08\x85\xff\xff\x00\x00\x00\x00\x09\x00\x00\x01\x00\x1e\x00\x02\x03\x08\x00\x00\x00\x1b\x04"
MIDAMBLE="\x00\x00\x00\x00"

LEFTBIN="\x8d"
LEFTBINCHECKSUM="\xac"

RIGHTBIN="\x90"
RIGHTBINCHECKSUM="\xaf"

OPTICAL="\x8f"
OPTICALCHECKSUM="\xae"

PRINTER="\x8e"
PRINTERCHECKSUM="\xad"

TOGGLEPICKUP="\x92"
TOGGLEPICKUPCHECKSUM="\xb1"

display_menu() {
    echo "Please select an option:"
    echo "1. Move picker --> right bin"
    echo "2. Move picker --> left bin"
    echo "3. Move picker --> printer"
    echo "4. Move picker --> optical drive"
    echo "5. Toggle pickup"
    echo "6. Open optical drive"
    echo "7. Close optical drive"
    echo "0. Exit"
}

execute_command() {
    case $1 in
        1) echo "Moving picker to right bin"
           echo -e $PREAMBLE$RIGHTBIN$MIDAMBLE$RIGHTBINCHECKSUM > /dev/usb/lp0
	        ;;
	     2) echo "Moving picker to left bin"
           echo -e $PREAMBLE$LEFTBIN$MIDAMBLE$LEFTBINCHECKSUM > /dev/usb/lp0
           ;;
        3) echo "Moving picker to printer position"
           echo -e $PREAMBLE$PRINTER$MIDAMBLE$PRINTERCHECKSUM > /dev/usb/lp0
           ;;
        4) echo "Moving picker to optical drive"
           echo -e $PREAMBLE$OPTICAL$MIDAMBLE$OPTICALCHECKSUM > /dev/usb/lp0
           ;;
        5) echo "Toggling pickup"
           echo -e $PREAMBLE$TOGGLEPICKUP$MIDAMBLE$TOGGLEPICKUPCHECKSUM > /dev/usb/lp0
           ;;
        6) echo "Opening optical drive"
           eject
           ;;
        7) echo "Closing optical drive"
           eject -t
           ;;
        0) echo "Exiting."
           exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Main program

#allow parametric control
if [ $# -eq 1 ]; then
    execute_command $1
    exit
fi

# Display the menu
display_menu

# Get user input
read -p "Enter your choice: " choice

# Execute the command based on user's selection
execute_command $choice