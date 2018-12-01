#!/bin/sh

firstfile() {
  cat <<EOF
FILE "${file}" BINARY
  TRACK 01 MODE2/2352
    INDEX 01 00:00:00
EOF
}

restfiles() {
  cat <<EOF
FILE "${file}" BINARY
  TRACK $(printf %02d ${tracker}) MODE2/2352
    INDEX 01 00:00:00
    INDEX 02 00:02:00
EOF
}

cuefile=$1
shift
tracker=1
for file in "$@"; do
  if [ $tracker -eq 1 ]; then 
    firstfile $file $tracker > "$cuefile"
  else
    restfiles $file $tracker >> "$cuefile"
  fi
  tracker=$(($tracker + 1))
done
