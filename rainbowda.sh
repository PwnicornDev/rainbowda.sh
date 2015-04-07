#!/bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.


url=${1:-"http://10.20.30.90:8083/set_color/"}

oldrows=$(tput lines)
oldcolumns=$(tput cols)
count=0

PI=$(echo "scale=10; 4*a(1)" | bc -l)

# ANSI-encoded $PONY, generated using ASCII-Pony by Mattia Basaglia
# https://github.com/mbasaglia/ASCII-Pony
read -r -d '' PONY <<'EndOfPony'
\x1b[0mTASTE THE RAINBOW!                       \x1b[36;22m_\x1b[36;22m_         \x1b[31;22m_\x1b[31;22m_\x1b[31;22m-\x1b[31;22m-\x1b[31;22m-\x1b[31;22m-\x1b[31;22m_\x1b[31;22m_
                                        \x1b[36;22m/  \x1b[36;22m\\\x1b[33;1m_\x1b[33;1m_\x1b[33;1m.\x1b[33;1m.\x1b[33;22m-\x1b[33;22m-\x1b[33;22m'\x1b[33;22m' \x1b[31;22m`\x1b[31;22m-\x1b[31;22m_\x1b[31;22m_\x1b[31;22m-\x1b[31;22m_\x1b[31;22m_\x1b[31;22m'\x1b[31;22m'\x1b[31;22m-\x1b[31;22m_
                                       \x1b[36;22m( \x1b[36;22m/  \x1b[36;22m\\    \x1b[33;22m`\x1b[33;22m`\x1b[33;22m-\x1b[33;22m-\x1b[33;22m,\x1b[33;22m,  \x1b[33;22m`\x1b[33;22m-\x1b[33;22m.\x1b[31;22m'\x1b[31;22m'\x1b[31;22m'\x1b[31;22m'\x1b[31;22m`
                                       \x1b[36;22m| \x1b[36;22m|   \x1b[33;1m`\x1b[33;1m-\x1b[33;1m.\x1b[33;1m.\x1b[33;1m_\x1b[33;1m_  \x1b[33;1m.\x1b[33;22m,\x1b[33;22m\\    \x1b[33;22m`\x1b[33;22m.
                         \x1b[36;22m_\x1b[36;22m_\x1b[36;22m_           \x1b[36;22m( \x1b[36;22m'\x1b[36;22m.  \x1b[37;22m\\ \x1b[37;22m_\x1b[37;22m_\x1b[37;22m_\x1b[37;22m_\x1b[37;22m_\x1b[33;1m\\ \x1b[33;1m)\x1b[33;22m`\x1b[33;22m-\x1b[33;22m_    \x1b[33;22m`\x1b[33;22m.
                  \x1b[36;22m_\x1b[36;22m_\x1b[36;22m_   \x1b[36;22m(   \x1b[36;22m`\x1b[36;22m.         \x1b[32;22m'\x1b[36;22m\\   \x1b[37;22m_\x1b[37;22m_\x1b[37;22m/   \x1b[35;22m_\x1b[35;22m_\x1b[37;22m\\\x1b[33;1m' \x1b[37;22m/ \x1b[37;22m`\x1b[37;22m:\x1b[33;22m-\x1b[33;22m.\x1b[33;22m.\x1b[33;22m_ \x1b[33;22m\\
                 \x1b[36;22m(   \x1b[36;22m`\x1b[36;22m-\x1b[36;22m. \x1b[36;22m`\x1b[36;22m.   \x1b[36;22m`\x1b[36;22m.       \x1b[32;22m.\x1b[32;22m|\x1b[36;22m\\\x1b[36;22m_  \x1b[37;22m(   \x1b[35;22m/ \x1b[30;1m.\x1b[30;1m-\x1b[37;22m| \x1b[37;22m|\x1b[35;22m'\x1b[35;22m.\x1b[37;22m|    \x1b[33;22m`\x1b[33;22m`\x1b[33;22m'
                  \x1b[36;22m`\x1b[36;22m-\x1b[36;22m.   \x1b[36;22m`\x1b[36;22m-\x1b[36;22m.\x1b[36;22m`\x1b[36;22m.   \x1b[36;22m`\x1b[36;22m.     \x1b[32;22m|\x1b[32;22m' \x1b[32;22m( \x1b[37;22m,\x1b[37;22m'\x1b[37;22m\\ \x1b[35;22m( \x1b[30;1m(\x1b[30;1mW\x1b[30;1mW\x1b[37;22m| \x1b[37;22m\\\x1b[30;1mW\x1b[35;22m)\x1b[37;22mj
          \x1b[35;22m.\x1b[35;22m.\x1b[35;22m-\x1b[35;22m-\x1b[35;22m-\x1b[35;22m'\x1b[35;22m'\x1b[35;22m'\x1b[35;22m'\x1b[34;22m:\x1b[34;22m-\x1b[36;22m`\x1b[36;22m.    \x1b[36;22m`\x1b[36;22m.\x1b[36;22m\\   \x1b[36;22m_\x1b[36;22m\\   \x1b[34;22m.\x1b[34;22m|\x1b[32;22m|  \x1b[32;22m'\x1b[32;22m,  \x1b[37;22m\\\x1b[37;22m_\x1b[35;22m\\\x1b[37;22m_\x1b[30;1m`\x1b[37;22m/   \x1b[36;22m`\x1b[36;22m`\x1b[36;22m-\x1b[36;22m.
        \x1b[35;22m,\x1b[35;22m'      \x1b[34;22m.\x1b[34;22m'\x1b[34;22m` \x1b[32;22m.\x1b[32;22m'\x1b[36;22m_\x1b[36;22m`\x1b[36;22m-\x1b[36;22m,   \x1b[36;22m`  \x1b[36;22m(  \x1b[36;22m|  \x1b[34;22m|\x1b[34;22m'\x1b[32;22m'\x1b[32;22m.   \x1b[32;22m`\x1b[32;22m.        \x1b[36;22m\\\x1b[36;22m_\x1b[36;22m_\x1b[36;22m/
       \x1b[35;22m/   \x1b[35;22m_  \x1b[34;22m.\x1b[34;22m'  \x1b[32;22m:\x1b[32;22m' \x1b[36;22m( \x1b[36;22m`\x1b[36;22m`\x1b[36;22m`    \x1b[36;22m_\x1b[36;22m_ \x1b[36;22m\\  \x1b[36;22m\\ \x1b[34;22m|   \x1b[32;22m\\ \x1b[32;22m.\x1b[32;22m_\x1b[32;22m:\x1b[32;22m7\x1b[32;22m,\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m.\x1b[36;22m-\x1b[36;22m'
      \x1b[35;22m| \x1b[35;22m.\x1b[35;22m-\x1b[35;22m'\x1b[35;22m/  \x1b[34;22m: \x1b[32;22m.\x1b[32;22m'  \x1b[33;1m.\x1b[33;1m-\x1b[36;22m`\x1b[36;22m-\x1b[36;22m.\x1b[36;22m_   \x1b[36;22m(  \x1b[36;22m`\x1b[36;22m.\x1b[36;22m\\  \x1b[36;22m'\x1b[34;22m'\x1b[34;22m:   \x1b[32;22m`\x1b[32;22m-\x1b[32;22m\\    \x1b[36;22m/
      \x1b[35;22m'\x1b[35;22m`  \x1b[35;22m/  \x1b[34;22m:\x1b[34;22m' \x1b[32;22m: \x1b[33;1m.\x1b[33;1m: \x1b[31;22m.\x1b[31;22m-\x1b[31;22m'\x1b[31;22m'\x1b[31;22m>\x1b[36;22m`\x1b[36;22m-\x1b[36;22m. \x1b[36;22m`\x1b[36;22m-\x1b[36;22m. \x1b[36;22m`   \x1b[35;22m| \x1b[34;22m'\x1b[34;22m.    \x1b[34;22m|  \x1b[36;22m(
         \x1b[35;22m-  \x1b[34;22m.\x1b[34;22m' \x1b[32;22m:\x1b[32;22m' \x1b[33;1m: \x1b[31;22m/   \x1b[36;22m/ \x1b[37;1m_\x1b[37;1m( \x1b[36;22m`\x1b[36;22m_\x1b[36;22m: \x1b[36;22m`\x1b[36;22m_\x1b[36;22m:\x1b[36;22m. \x1b[35;22m`\x1b[35;22m.  \x1b[34;22m`\x1b[34;22m;\x1b[34;22m.  \x1b[34;22m\\  \x1b[36;22m\\
         \x1b[35;22m|  \x1b[34;22m| \x1b[32;22m.\x1b[32;22m' \x1b[33;1m: \x1b[31;22m/\x1b[31;22m|  \x1b[36;22m| \x1b[37;1m(\x1b[37;1m_\x1b[37;1m_\x1b[37;1m_\x1b[36;22m(   \x1b[36;22m(      \x1b[35;22m\\   \x1b[35;22m)\x1b[34;22m\\  \x1b[34;22m;  \x1b[36;22m|
        \x1b[35;22m.\x1b[35;22m' \x1b[34;22m.\x1b[34;22m' \x1b[32;22m| \x1b[33;1m| \x1b[31;22m| \x1b[31;22m`\x1b[31;22m. \x1b[36;22m|   \x1b[34;22m\\\x1b[33;1m\\\x1b[31;22m\\\x1b[36;22m`\x1b[36;22m-\x1b[36;22m-\x1b[36;22m-\x1b[36;22m:\x1b[36;22m.\x1b[36;22m_\x1b[36;22m_\x1b[36;22m-\x1b[36;22m'\x1b[36;22m'\x1b[35;22m) \x1b[35;22m/  \x1b[34;22m)\x1b[34;22m/   \x1b[36;22m|
        \x1b[35;22m|  \x1b[34;22m|  \x1b[32;22m| \x1b[33;1m| \x1b[31;22m|  \x1b[31;22m| \x1b[36;22m|   \x1b[34;22m/\x1b[33;1m/\x1b[31;22m/           \x1b[35;22m|\x1b[35;22m/   \x1b[34;22m'    \x1b[36;22m|
       \x1b[35;22m.\x1b[35;22m' \x1b[34;22m.\x1b[34;22m'  \x1b[32;22m'\x1b[32;22m.\x1b[33;1m'\x1b[33;1m.\x1b[31;22m`\x1b[31;22m; \x1b[31;22m|\x1b[36;22m/ \x1b[36;22m\\  \x1b[31;22m/     \x1b[36;22m/             \x1b[36;22m\\\x1b[36;22m_\x1b[36;22m_\x1b[36;22m/
       \x1b[35;22m|  \x1b[34;22m|    \x1b[32;22m| \x1b[33;1m| \x1b[33;1m|\x1b[31;22m.\x1b[31;22m|   \x1b[36;22m|      \x1b[36;22m/\x1b[36;22m-\x1b[36;22m,\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m\\       \x1b[36;22m\\
      \x1b[35;22m/  \x1b[35;22m/ \x1b[34;22m)   \x1b[32;22m| \x1b[33;1m| \x1b[33;1m'\x1b[33;1m|\x1b[31;22m' \x1b[36;22m_\x1b[36;22m/      \x1b[36;22m/     \x1b[36;22m|    \x1b[36;22m|\x1b[36;22m\\       \x1b[36;22m\\
    \x1b[35;22m.\x1b[35;22m:\x1b[35;22m.\x1b[35;22m-\x1b[35;22m' \x1b[34;22m.\x1b[34;22m'  \x1b[32;22m.\x1b[32;22m' \x1b[33;1m|   \x1b[33;1m)\x1b[36;22m/       \x1b[36;22m/     \x1b[36;22m|     \x1b[36;22m| \x1b[36;22m`\x1b[36;22m-\x1b[36;22m-\x1b[36;22m,    \x1b[36;22m\\
         \x1b[34;22m/    \x1b[32;22m|  \x1b[33;1m|  \x1b[33;1m/ \x1b[36;22m|      \x1b[36;22m|      \x1b[36;22m|     \x1b[36;22m|   \x1b[36;22m/      \x1b[36;22ml
    \x1b[34;22m.\x1b[34;22m_\x1b[34;22m_\x1b[34;22m.\x1b[34;22m'    \x1b[32;22m/\x1b[32;22m`  \x1b[32;22m:\x1b[33;1m|\x1b[33;1m/\x1b[36;22m_\x1b[36;22m/\x1b[36;22m|      \x1b[36;22m|      \x1b[36;22m|      \x1b[36;22m| \x1b[36;22m(       \x1b[36;22m|
    \x1b[34;22m`\x1b[34;22m-\x1b[34;22m.\x1b[34;22m_\x1b[34;22m_\x1b[34;22m_\x1b[34;22m.\x1b[34;22m-\x1b[34;22m`\x1b[32;22m;  \x1b[32;22m/ \x1b[33;1m'   \x1b[36;22m|      \x1b[36;22m|      \x1b[36;22m|      \x1b[36;22m|  \x1b[36;22m\\      \x1b[36;22m|
           \x1b[32;22m.\x1b[32;22m:\x1b[32;22m_\x1b[32;22m-\x1b[32;22m'      \x1b[36;22m|       \x1b[36;22m\\     \x1b[36;22m|       \x1b[36;22m\\  \x1b[36;22m`\x1b[36;22m.\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m/
                       \x1b[36;22m\\\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m)     \x1b[36;22m\\\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m_\x1b[36;22m)\x1b[0m
EndOfPony


quit() { # Clear screen and allow typing
    tput rmcup
    stty sane
    exit
}


draw() { # All output is done here
    tput clear
    echo -ne "$PONY"
    echo -ne "            (press q to quit) "
}


chkSize() { # Handle resizing of the screen
    rows=$(tput lines)
    columns=$(tput cols)
    if [[ $oldcolumns != $columns || $oldrows != $rows ]]; then
        draw
        oldcolumns=$columns
        oldrows=$rows
    fi
    if [[ $count -eq 2 ]]; then
        draw
        count=0
    fi
}


constrain() { # Constrain a $var like so:  constrain $min $var $max
    min="$1"; var="$2"; max="$3"
    if [[ $(echo "$min>$var" | bc -l) -eq 1 ]]; then var="$min"; fi
    if [[ $(echo "$var>$max" | bc -l) -eq 1 ]]; then var="$max"; fi
    echo "$var"
}


mane() { # The mane loop
    stty -icanon time 0 min 0
    tput smcup
    draw
    count=0
    keypress=''

    i=0
    freq="0.05"

    while [ "$keypress" != "q" ]; do
        rows=$(tput lines)
        columns=$(tput cols)
        sleep 0.5
        read keypress
        (( count = count + 1))
        chkSize
        trap quit SIGINT

        r=$(echo "dec = s($freq*$i)*255+255/2; scale=0; dec/1" |bc -l)
        r=$(constrain 0 "$r" 255)
        g=$(echo "dec = s($freq*$i+2*$PI/3)*255+255/2; scale=0; dec/1" |bc -l)
        g=$(constrain 0 "$g" 255)
        b=$(echo "dec = s($freq*$i+4*$PI/3)*255+255/2; scale=0; dec/1" |bc -l)
        b=$(constrain 0 "$b" 255)
        rgb="$(printf "%02x" "$r")$(printf "%02x" "$g")$(printf "%02x" "$b")"
        curl -s "$url$rgb" > /dev/null

        (( i = i + 1))
    done

    quit
}


mane
