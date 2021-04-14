# OPS/Text/part-03-chap.xhtml:<!-- TTITLE2    3. Lorem ipsum dolor sit amet, consectetur -->

/<!--[ 	]+TTITLE/ {
s/<!--[ 	]+//
s/[ 	]+-->//
s/	/    /g
s/TTITLE +/0 /
s/TTITLE//
s/ +/	/
#s/	+[0-9ivxlcdmIVXLCDM]+\. +/ /
#s/^[0-9]+/&. /
#/^1/ s/^/    /
#/^2/ s/^/        /
F
p
}

