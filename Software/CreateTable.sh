#!/bin/bash
function validName {
    if [ -z "$1" ] || [[ "$1" =~ ^[0-9] ]] || [[ "$1" = *" "* ]] || [[ "$1" =~ [^a-zA-Z0-9_] ]] || [ ${#1} -lt 2 ]; then
        echo "Invalid table name. Please follow the naming rules (greater than 1 letter)."
        echo "---------------------------------------"
        return 1
    fi
}

function readColumnType {
    local colType=""
    
    while true; do
        echo "Choose a data type: "
        select colType in "string" "integer"; do
            case $colType in
                "integer")
                    echo "You selected 'integer.'"
                    read -p "Enter a default value for the column (must be an integer): " defaultValue
                    if [[ "$defaultValue" =~ ^[0-9]+$ ]]; then
                        return 0
                    else
                        echo "Invalid input. Please enter a valid integer."
                    fi
                    ;;
                "string")
                    echo "You selected 'string.'"
                    return 0 ;;
                *)
                    echo "Invalid Choice" ;;
            esac
        done
    done
}

function createTable {
    typeset tableName cols num=0 nameRecord="" dataTypeRecord=""

    while true; do
        read -p "Enter Table Name: " tableName
        echo "---------------------------------------"
        validName "$tableName" && break
    done

    if [ -d "$tableName" ]; then
        echo "Table Already Exists :)"
        echo "---------------------------------------"
        return 1
    fi

    mkdir "$tableName" || return 1
    cd "$tableName" || return 1

    touch "${tableName}.txt" "${tableName}-meta.txt" || return 1

    while true; do
        read -p "Enter Number Of Columns: " cols
        echo "---------------------------------------"
        if [[ ! $cols =~ ^[0-9]+$ || $cols -eq 0 ]]; then
            echo "Cols number must be a positive integer"
            echo "---------------------------------------"
        else
            break
        fi
    done

    typeset colName colType
    while [ $num -lt $cols ]; do
        if [ $num -eq 0 ]; then
            while true; do
                read -p "Enter The PK Column : " colName
                echo "---------------------------------------"
                if [[ ! "$colName" =~ ^[0-9]+$ ]]; then
                    break
                else
                    echo "Invalid input. The PK column should be string."
                    echo "---------------------------------------"
                fi
            done
        else
            read -p "Enter Column Name: " colName
            echo "---------------------------------------"
        fi

        readColumnType || continue

        if [ $num -eq $((cols - 1)) ]; then
            nameRecord+="${colName}"
            dataTypeRecord+="${colType}"
        else
            nameRecord+="${colName}:"
            dataTypeRecord+="${colType}:"
        fi

        ((num++))
    done

    echo "$dataTypeRecord" >>"${tableName}-meta.txt"
    echo "$nameRecord" >>"${tableName}-meta.txt"

    cd ../ || return 1
    echo "Table created successfully!"
}
createTable
echo "---------------------------------------"
echo "Press Enter to go pack :)"

