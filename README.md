# massebrenner
Overordnet er planen å benytte en primera disc publisher ii for å kopiere filmer til et nettverksmount via makemkv.

## Steg
- Finne plukke kommando
pick-drop.pcap #305, urb bulk out, identiske pakker med untak for irp-id
- Finne levere kommando
pick-drop.pcap # 357 urb bulk out, identiske pakker med unntak for irp-id
- Finne høyre kommando
- Finne venstre kommando
- Finne senter kommando
- Makemkv kommando
makemkvcon -r mkv disc:0 all --minlength=3600 ~/Videos

# Nyttige linker
https://hackernoon.com/usb-reverse-engineering-down-the-rabbit-hole-c4809a5b55c4
https://learn.adafruit.com/hacking-the-kinect
https://github.com/openrazer/openrazer/wiki/Reverse-Engineering-USB-Protocol
https://docs.kernel.org/next/driver-api/usb/writing_usb_driver.html
