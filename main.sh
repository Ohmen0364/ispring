#!/bin/bash
while true; do
echo "1 - Setup Project"
echo "2 - Start Project"
echo "3 - Stop  Project"
echo "4 - Status containers"
echo "5 - Back Up DataBase"
echo "6 - Back Up TeacmCity"
echo "Enter q for exit"
echo -n "Enter number: "
read input

case $input in 
    1)
        docker-compose up --no-start
        ;;
    2)
        docker-compose start
        ;;
    3)
        docker-compose stop
        ;;
    4)
        docker-compose ps
        ;;
    5) 
        docker exec mysql /usr/bin/mysqldump -u root --password=toor teamcity_db > ./backup-databse-$(date +%m-%d-%Y-%H-%M).sql
        ;;
    6)
        docker exec teamcity /opt/teamcity/bin/maintainDB.sh backup --all -M -F teamcity-backup
        ;;
    q)
        echo "Exit script..."
        break
        ;;
    *)
        echo "Not found command!"
        ;;
esac
read
clear
done