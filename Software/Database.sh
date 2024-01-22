#!/bin/bash
echo 
echo -e "\e[34m THE MENU \e[0m"  # Blue-colored text
echo "---------------------------------------"
select choice in "Create Database" "List Databases" "Connect Database" "Drop Database" "Exit"; do
    case $choice in
        "Create Database")
            echo "Creating Database"
            chmod u+x  CreateDatabase.sh
            . ./CreateDatabase.sh
            ;;
        "List Databases")
            echo "Listing Databases"
             chmod u+x  ListDatabase.sh
            . ./ListDatabase.sh
            ;;
        "Connect Database")
            echo "Connecting Database"
            chmod u+x  ConnectDb.sh
            . ./ConnectDb.sh
            ;;
        "Drop Database")
            echo "Dropping Database"
             chmod u+x  DropDatabase.sh
            . ./DropDatabase.sh
            ;;
        "Exit")
            echo "Exiting"
            break
            ;;
        *)
            echo "$choice is not valid"
            ;;
    esac
done