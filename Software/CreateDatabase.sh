#!/bin/bash

function createDatabase {
    echo "---------------------------------------"
    read -p "Enter the Database name: " DbName

if [[ "$DbName" == *[" "]* ]]; then
    echo "---------------------------------------"
    echo "The name field cannot contain spaces."
    createDatabase
    return
fi
    case $DbName in
        *[" "]* )
            echo "---------------------------------------"
            echo "The name field cannot contain spaces."
            createDatabase ;;
        [0-9]* )
            echo "---------------------------------------"
            echo "Name should not begin with a number."
            createDatabase ;;
        *[!a-zA-Z0-9_]* )
            echo "---------------------------------------"
            echo "Name shouldn't have special characters."
            createDatabase ;;
        [a-zA-Z_] )
            echo "Database name must be more than one character."
            createDatabase ;;
        *[a-zA-Z_]* )
            if [ -d "$DbName" ]; then
                echo "---------------------------------------"
                echo "OOPS, this DATABASE already EXISTS."
                createDatabase
            else
                mkdir "$DbName"
                echo "---------------------------------------"
                echo "Database Created Successfully."
            fi
            ;;
        * )
            echo "---------------------------------------"
            echo "Write a valid name."
            createDatabase ;;
    esac
}

while true; do    
    cd ../Databases
    typeset -i status
    createDatabase
    cd - &> ~/../../dev/null
    
    select reply in "Go back to Main_Menu" "Exit"; do
        case $reply in 
            "Go back to Main_Menu") 
                echo "----------------------------------------"
                source Database.sh
                ;;
            "Exit")
                echo "Goodbye :)"
                exit
                ;;
            *) 
                echo -e "\e[91mPlease enter a valid input\e[0m"
                ;;
        esac
    done
done