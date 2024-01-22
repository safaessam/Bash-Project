#!/bin/bash 


    function validName { 
    if [ -z "$1" ] 
    then 
        echo "The name field cannot be left empty" 
        return 1 
    elif [[ "$1" =~ ^[0-9] ]] 
    then 
        echo "Name should not begin with a number" 
        return 1 
    elif [[ "$1" = " " ]] 
    then 
        echo "Name Shouldn't Have Spaces" 
        return 1 
    elif [[ "$1" =~ [^a-zA-Z0-9_-.] ]] 
    then 
        echo "Name Shouldn't Have Special Characters" 
        return 1 
    fi 
} 
function validType { 
    if [ -z "$1" ] 
    then 
        echo " value can't be empty." 
        return 1 
    fi 
    if [[ "$1" =~ ^[0-9]+$ ]] 
    then 
        if [ "$2" == "integer" ] 
        then 
            return 0 
        else 
            echo "The value should be an Integer." 
            return 1 
        fi 
    fi 
    if [[ "$1" =~ ^[a-zA-Z0-9_]+$ ]]; 
    then 
        if [ "$2" == "string" ] 
        then 
            return 0 
        else 
            echo "The value should be a String." 
            return 1 
        fi 
    fi 
}
    if [ -z "$(ls)" ] 
    then 
        echo "No Tables To Insert, Database Is Empty." 
        return 
    fi 
    typeset tableName 
    while true 
    do 
        read -p "Enter Table Name: " tableName 
        validName $tableName 
        if [ $? -eq 0 ] 
        then 
            break 
        fi 
    done 
    if [ ! -d "$tableName" ] 
    then 
        echo "Table Doesn't Exist" 
        return 
    fi 
    typeset colNum 
    colNum=$( head -1 ${tableName}/${tableName}-meta.txt | awk -F':' '{print NF}') 
    typeset num=0 
    typeset insertVal="" 
    while [ $num -lt $colNum ] 
    do 
        typeset colName=$(tail -1 ${tableName}/${tableName}-meta.txt | cut -d ':' -f $((num+1))) 
        typeset colDatatype=$(head -1 ${tableName}/${tableName}-meta.txt | cut -d ':' -f $((num+1))) 
        while true 
        do 
            read -p "Enter value of ${colName} in ${colDatatype}: " colValue 
            validType $colValue $colDatatype 
            if [ $num -eq 0 ] 
            then 
                if [ ! -z "$(grep ^${colValue} ${tableName}/${tableName}.txt)" ] 
                then 
                    echo "This Pk Exist, choose another one" 
                    continue 
                fi 
            fi 
            if [ $? -eq 0 ] 
            then 
                break 
            fi 
        done 
        if [ $num -eq $((colNum-1)) ] 
        then 
            insertVal="${insertVal}${colValue}" 
        else 
            insertVal="${insertVal}${colValue}:" 
        fi 
        let num=$num+1 
    done 
    echo ${insertVal} >> "${tableName}/${tableName}.txt" 
#$1 -> Value 
#$2 -> datatype