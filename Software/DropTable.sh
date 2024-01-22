#!/usr/bin/bash

typeset tableName

echo "---------------------------------------"
echo "Tables already exist:"
echo "---------------------------------------"
ls -F | grep '/' | tr '/' ' '

if [ -z "$(ls)" ]; then
    echo "No Tables To Drop, Database Is Empty."
    echo "---------------------------------------"
else
    while true; do
        read -p "Enter Table Name: " tableName
        echo "---------------------------------------"
        case $tableName in
            '' )
                echo "The name field cannot be left empty"
                echo "---------------------------------------"
                continue ;;
            [0-9]* )
                echo "Name should not begin with a number"
                echo "---------------------------------------"
                continue ;;
            *" "* )
                echo "Name shouldn't have spaces"
                echo "---------------------------------------"
                continue ;;
            *[!a-zA-Z0-9_]* )
                echo "Name shouldn't have special characters"
                echo "---------------------------------------"
                continue ;;
            *[a-zA-Z_]* )
                if [ -F"$tableName" ]; then
                    rm -r "$tableName"
                    echo "Table ${tableName} deleted successfully"
                    echo "---------------------------------------"
                else
                    echo "Table ${tableName} doesn't exist"
                    echo "---------------------------------------"
                fi
                break ;;
            * )
                echo "Write a valid name"
                continue ;;
        esac
    done
fi
echo "---------------------------------------"
echo "Press Enter to go pack :)"
