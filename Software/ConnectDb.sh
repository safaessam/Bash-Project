 
#!/bin/bash
echo "---------------------------------------"

echo "Type your database number to connect with: "

echo "---------------------------------------"
echo "The database already exists"

cd ../Databases
array=(`ls -F | grep / | tr / " "`)
select choice in "${array[@]}"; do
    if ! [[ $REPLY =~ ^[0-9]+$ ]]; then
        echo "$REPLY is not a valid number"
        continue
    elif [ $REPLY -gt ${#array[@]} ]; then
        echo "$REPLY is not on the menu"
        continue
    else
        cd "../Databases/${array[$REPLY-1]}"
        echo "You are connected to ${array[$REPLY-1]} successfully :) "
        break
    fi
done
echo

echo "Type your choice number: "
echo "---------------------------------------"
select choice2 in "Create Table" "List Tables" "Drop Tables" "Insert Into Table" "Select Table" "Delete From Table" "Update Table" "Quit"; do
    case $choice2 in
        "Create Table")
            echo "Create Table"
            source ../../Software/CreateTable.sh
            ;;
        "List Tables")
            echo "List Tables"
            source ../../Software/ListTable.sh
            ;;
        "Drop Tables")
            echo "Drop Tables"
            source ../../Software/DropTable.sh
            ;;
        "Insert Into Table")
            echo "Insert table"
            source ../../Software/InsertIntoTable.sh
            ;;
        "Select Table")
            echo "Select table"
            source ../../Software/SelectTable.sh
            ;;
        "Delete From Table")
            echo "Delete from table"
            source ../../Software/DeleteFromTable.sh
            ;;
        "Update Table")
            echo "Update table"
            source ../../Software/UpdateTable.sh
            ;;
        "Quit")
            break
            ;;
        *)
            echo "$REPLY is not a valid choice"
            ;;
    esac
done

cd - &> ~/../../dev/null