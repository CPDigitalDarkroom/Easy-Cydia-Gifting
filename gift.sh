#!/bin/bash

# An array of bundle identifier to loop.
declare -a identifierArray=(
"com.cpdigitaldarkroom.hidemex"
"com.cpdigitaldarkroom.kairos2"
)

# Array of Cydia ID's to gift
declare -a accountArray=(
"xxxxxxxx"
"xxxxxxxx"
"xxxxxxxx"
)

# This will loop through all the bundle identifiers
# looping through the array of cydia ids gifting
for i in "${identifierArray[@]}"
do
for x in "${accountArray[@]}"
do

# I like some output but you can remove this line
echo "Gifting  $i To  $x"

	# I forgot who all helped me create this script (I know I asked a couple times on Slack). I do know Kirb helped with this part though, thanks.
	# Use curl to fill the form and gift, replace cydia_account with cookie of valid connect session
	curlOutput="$(curl -so - https://cydia.saurik.com/connect/products/$i/complimentary_ -b "cydia_account=~~Your Cydia Cookie~~" -d "account=$x" -e https://cydia.saurik.com/connect/products/$i/complimentary)";

	# A little extra to know if it was newly gifted, already done, or an error thats most likely expired cookie
	grepDone=$(echo ${curlOutput} | grep -c "Done.")
	alreadyDone=$(echo ${curlOutput} | grep -c "That was already done.")

	if [ $grepDone == 1 ];
		then
			echo "Gift Successful";
		else
			if [ $alreadyDone == 1 ];
				then
					echo "Error: Already Gifted To This Account";
				else
					echo "Error: Cookie expired";
			fi;
	fi;
	echo;
done
done
