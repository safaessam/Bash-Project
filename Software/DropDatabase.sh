#!/bin/bash

cd ../databases

while true; do
    echo "Type your database number to delete (or 0 to exit): "
    echo "---------------------------------------"
    echo "The databases already exist: "
    array=(`ls -F | grep / | tr / " "`)
    select choice in "${array[@]}"; do
        if ! [[ $REPLY =~ ^[0-9]+$ ]]; then
            echo "$REPLY is not a valid number"
            continue
        elif [ $REPLY -eq 0 ]; then
            echo "Goodbye :)"
            exit
        elif [ $REPLY -gt ${#array[@]} ]; then
            echo "$REPLY is not on the menu"
            continue
        else
            rm -r "${array[$REPLY-1]}"
            echo "Deleted ${array[$REPLY-1]} successfully"
            break
        fi
    done

    echo "---------------------------------------"
    echo "1) Delete another database"
    echo "2) Exit"
    echo -n "Enter your choice: "
    read reply
    case $reply in 
        1) 
            continue
            ;;
        2)
            echo "Goodbye :)"
            exit
            ;;
        *) 
            echo "Invalid choice. Exiting."
            exit
            ;;
    esac
done
    cd ../databases
