#!/bin/sh
echo "What is your command?"
echo "1.Generate files: dart run build_runner build"
echo "2.Generate Localization strings: dart gen-l10n"
while true 
read -r option
do
    if [ $option -eq 1 ]
    then 
        dart run build_runner build
        break
    elif [ $option -eq 2 ]
    then 
        dart run build_runner build
        break
    else
        echo "Invalid option, please re-input:"
        echo "1.Generate files: dart run build_runner build"
        echo "2.Generate Localization strings: dart gen-l10n"
    fi
done
