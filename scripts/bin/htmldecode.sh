#!/bin/sh

while read line; do
  # https://stackoverflow.com/questions/5929492/bash-script-to-convert-from-html-entities-to-characters
  echo $line | sed '
      s/&nbsp;/ /g;
      s/&amp;/\&/g;
      s/&lt;/\</g;
      s/&gt;/\>/g;
      s/&quot;/\"/g;
      s/#&#39;/\'"'"'/g;
      s/&ldquo;/\"/g;
      s/&rdquo;/\"/g;
  '
done
