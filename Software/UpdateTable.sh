#!/bin/bash

function validName {
    if [ -z "$1" ] || [[ "$1" =~ ^[0-9] ]] || [[ "$1" = *" "* ]] || [[ "$1" =~ [^a-zA-Z0-9_] ]]; then
        echo "Invalid table name. Please follow the naming rules."
        echo "---------------------------------------"
        return 1
    fi
}

function getColumnNumber {
    awk -F: '{ for (i=1; i<=NF; i++) { if ($i == "'"${1}"'") { print i; exit } } }' "${2}/${2}-meta.txt"
}

function updateTable {
    local tableName=$1
    local pk=$2
    local colName=$3
    local newValue

    if [ -z "$(ls)" ]; then
        echo "No Tables To Update, Database Is Empty."
        echo "---------------------------------------"
        return
    fi

    while true; do
        read -p "Enter New Value for ${colName}: " newValue
        echo "---------------------------------------"
        handle=$(sed -i "/^${pk}/s/:${colName}:${oldValue}/:${colName}:${newValue}/" "${tableName}/${tableName}.txt")
        if [ -z "$handle" ]; then
            echo "Update successful!"
            break
        else
            echo "Update failed. Please try again."
        fi
    done
}

typeset tableName pk colName oldValue colNum

while true; do
    read -p "Enter Table Name: " tableName
    echo "---------------------------------------"
    validName "$tableName" && break
done

if [ ! -d "$tableName" ]; then
    echo "${tableName} Doesn't Exist"
    echo "---------------------------------------"
    exit 1
fi

if [ -z "$(cat "$tableName/$tableName.txt")" ]; then
    echo "The $tableName is empty."
    echo "---------------------------------------"
    exit 1
fi

read -p "Enter Pk: " pk
echo "---------------------------------------"

if [ -z "$(grep "^${pk}" "${tableName}/${tableName}.txt")" ]; then
    echo "The PK doesn't Exist"
    echo "---------------------------------------"
    exit 1
fi

read -p "Enter column name: " colName
echo "---------------------------------------"

if [ -z "$(grep "${colName}" "${tableName}/${tableName}-meta.txt")" ]; then
    echo "The ${colName} column doesn't Exist"
    echo "---------------------------------------"
    exit 1
fi

colNum=$(getColumnNumber "$colName" "$tableName")
oldValue=$(grep "^${pk}" "${tableName}/${tableName}.txt" | cut -d ':' -f "${colNum}")

updateTable "$tableName" "$pk" "$colName" "$oldValue"
echo "Press Enter to go pack :)"