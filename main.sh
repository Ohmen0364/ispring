#!/bin/bash
while true; do
echo "1 - Setup Project"
echo "2 - Start Project"
echo "3 - Stop  Project"
echo "4 - Status containers"
echo "5 - Back Up DataBase"
echo "6 - Back Up TeacmCity"
echo "7 - Restart service"
echo "Enter q for exit"
echo -n "Enter number: "
read input

case $input in 
    1)
        UID=${UID} GID=${GID} docker-compose up --no-start
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
        docker exec mysql sh -c '/usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE' > ./backup-databse-$(date +%m-%d-%Y-%H-%M).sql; echo -e "\e[32mDone.\e[0m"
        ;;
    6)
        docker exec teamcity /opt/teamcity/bin/maintainDB.sh backup --all -M -F teamcity-backup
        ;;
    7)
        docker-compose restart
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