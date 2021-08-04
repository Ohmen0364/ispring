#!/bin/bash
while true; do
echo "1 - Restore from backup MySQL"
echo "2 - Restore from backup TeamCity"
echo "Enter q for exit"
echo -n "Enter number: "
read input

case $input in 
    1)
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
        cat $sqlfile | docker exec -i mysql sh -c '/usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE'; docker-compose restart teamcity;echo -e "\e[32mDone.\e[0m"
        else
        echo -n "File not found!"
        fi
        ;;
    2)
        echo " "
        echo " --- backup list --- "
        echo " "
        ls ./data/tc/tc-data/backup/ | grep \\.zip
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
        elif [[ -f "./data/tc/tc-data/backup/$zipfile" ]]; then
            docker exec mysql sh -c '/usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE' > ./temp.sql
            docker exec mysql sh -c 'mysql -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE -e "drop database $MYSQL_DATABASE;"'
            docker exec mysql sh -c 'mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "create database $MYSQL_DATABASE;"'
            rm -rf /data/teamcity_server/datadir/config/*; rm -rf /data/teamcity_server/datadir/system/*;
            docker exec teamcity /opt/teamcity/bin/maintainDB.sh restore --all -F /data/teamcity_server/datadir/backup/$zipfile; echo -e "\e[32mDone.\e[0m"
            cat temp.sql | docker exec -i mysql sh -c '/usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE'; docker-compose restart teamcity; rm -rf temp.sql; echo -e "\e[32mDone.\e[0m"
        else
        echo -n "File not found!"
        fi
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