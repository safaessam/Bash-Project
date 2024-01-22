
echo "---------------------------------------"
echo "All tables I have:"

if [ -z "$(ls)" ]; then
    echo "No Tables To Show, Database Is Empty."
else
    ls | tr ' ' '\n'
fi

echo "---------------------------------------"
read -p "Press Enter to go back :)"