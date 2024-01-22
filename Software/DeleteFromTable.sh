#!/usr/bin/bash

function validName {
    
    if [ -z "$1" ]
    then
        echo "The name field cannot be left empty"
        echo "---------------------------------------"
        return 1
    elif [[ "$1" =~ ^[0-9] ]]
    then
        echo "Name should not begin with a number"
        echo "---------------------------------------"
        return 1
    elif [[ "$1" = *" "* ]]
    then
        echo "Name Shouldn't Have Spaces"
        echo "---------------------------------------"
        return 1
    elif [[ "$1" =~ [^a-zA-Z0-9_] ]]
    then
        echo "Name Shouldn't Have Special Characters"
        echo "---------------------------------------"
        return 1
    fi
    
}

typeset pk tableName
    
    if [ -z "$(ls)" ]
    then
        echo "No Tables To Remove, Database Is Empty."
        echo "---------------------------------------"
        return
    fi
    
    while true
    do
        read -p "Enter Table Name: " tableName
        echo "---------------------------------------"
        validName $tableName
        if [ $? -eq 0 ]
        then
            break
        fi
    done
    
    if [ ! -d "$tableName" ]
    then
        echo "Table Doesn't Exist"
        echo "---------------------------------------"
        return
    fi
    
    if [ -s "$tableName/$$tableName.txt" ]
    then
        echo "The $tableName is empty."
        echo "---------------------------------------"
        return
    fi
    
    
    read -p "Enter the pk of the table to delete: " pk
    echo "---------------------------------------"
    
    while true
    do
        if [ ! -z "$(grep ^${pk} ${tableName}/${tableName}.txt)" ]
        then
            sed -i "/^${pk}/d" "${tableName}/${tableName}.txt"
            echo "The record of Pk = ${pk} has been deleted successfully."
            echo "---------------------------------------"
            break
        else
            echo "The PK doesn't Exist"
            echo "---------------------------------------"
            return
        fi
    done            
echo "Press Enter to go pack :)"
