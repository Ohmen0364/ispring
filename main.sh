#!/bin/bash
while true; do
echo "1 - Setup Project"
echo "2 - Start Project"
echo "3 - Stop  Project"
echo "4 - Status containers"
echo "5 - Back Up DataBase"
echo "6 - Back Up TeacmCity"
echo "7 - Restore from backup MySQL"
echo "8 - Restore from backup TeamCity"
echo "9 - Restart service"
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
        docker exec mysql /usr/bin/mysqldump -u root --password=toor teamcity_db > ./backup-databse-$(date +%m-%d-%Y-%H-%M).sql; echo -e "\e[32mDone.\e[0m"
        ;;
    6)
        docker exec teamcity /opt/teamcity/bin/maintainDB.sh backup --all -M -F teamcity-backup
        ;;
    7)
        echo " "
        echo " --- backup list --- "
        echo " "
        ls | grep \\.sql
        echo " "
        echo " ------------------ "
        echo " "
        echo    "Enter full name sql file. "
        echo    "Example: backup-database-07-30-2021-12-32.sql "
        echo " "
        echo -n "back up file: "
        read sqlfile
        if [[ -z "$sqlfile" ]]; then
            echo "[File name is empty!]"
        elif [[ -f "$sqlfile" ]]; then
        cat $sqlfile | docker exec -i mysql /usr/bin/mysql -u root --password=toor teamcity_db; docker-compose restart teamcity;echo -e "\e[32mDone.\e[0m"
        else
        echo -n "File not found!"
        fi
        ;;
    8)
        echo " "
        echo " --- backup list --- "
        echo " "
        ls tc-data/backup/ | grep \\.zip
        echo " "
        echo " ------------------ "
        echo " "
        echo    "Enter full name .zip file. "
        echo    "Example: teamcity-backup_20210730_083248.zip "
        echo " "
        echo -n "back up file: "
        read zipfile
        if [[ -z "$zipfile" ]]; then
            echo "[File name is empty!]"
        elif [[ -f "tc-data/backup/$zipfile" ]]; then
            docker exec mysql /usr/bin/mysqldump -u root --password=toor teamcity_db > ./temp.sql
            docker exec mysql mysql -u root --password=toor teamcity_db -e "drop database teamcity_db;"
            docker exec mysql mysql -u root --password=toor -e "create database teamcity_db;"
            rm -rf /data/teamcity_server/datadir/config/*; rm -rf /data/teamcity_server/datadir/system/*;
            docker exec teamcity /opt/teamcity/bin/maintainDB.sh restore --all -F /data/teamcity_server/datadir/backup/$zipfile; echo -e "\e[32mDone.\e[0m"
            cat temp.sql | docker exec -i mysql /usr/bin/mysql -u root --password=toor teamcity_db; docker-compose restart teamcity; rm -rf temp.sql; echo -e "\e[32mDone.\e[0m"
        else
        echo -n "File not found!"
        fi
        ;;
    9)
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