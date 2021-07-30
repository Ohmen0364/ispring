### ISpring
  Данное решение включает в себя 3 контейнера с _nginx + teamcity + mysql_
Контейнера настроены на взаимодейстие между собой в рамках технического задания: при развертывании поднимается сервер nginx и mysql, а после поднятия БД поднимается сервер с TeamCity. Для использования данного решения необходимо иметь Linux (amd64), а так же у пользователя должна быть возможность использования sudo для выполнения действий от имени администратора. Для получения решения необходимо так же установить на систему git.

Инструкция:

1. Необходимо выполнить клонирование данного репозитория используя в терминале используя следующую команду:
```git clone https://github.com/Ohmen0364/ispring.git```

2. После клонирования перейти в директорию с файлами:
```cd ./ispring```

3. Запустить инсталляционный скрипт, который загрузит необходимые для работы утилиты, такие как docker, docker-compose:
```./installReq.sh```
  При выполнении скрипта необходимо будет несколько раз указать пароль пользователя для комманд использующих sudo. По окончанию установки система должна будет выполнить перезагрузку.

4. После повторной загрузки возвращаемся в директорию проекта и выполняем скрипт для управления решением.
```./main.sh```
  В терминале нам предоставляется несколько функций:
![image](https://user-images.githubusercontent.com/88158708/127620683-57938476-d04e-49c1-b2ba-6ed94d253b40.png)
  При первом запуске нам обязательно необходимо выполнить сборку проекта, для этого нажимаем 1 и ждем пока будут загружены и настроенны все необходимые образы.
После завершения первого шага должно выдать сообщение такого формата:
![image](https://user-images.githubusercontent.com/88158708/127622379-5f7583a5-a298-49d6-9d1c-200b3cae17e0.png)
5. После успешного получения контейнеров нажимаем `enter` и выбираем второй пункт из меню для запуска решения:
![image](https://user-images.githubusercontent.com/88158708/127622628-a264fd2e-d5b8-472a-a742-94216b1fa9e4.png)
  В результате должны получить сообщение об успехе и войти на главную страницу teamcity для первоначальной его настройки. Открываем браузер и переходим по адресу `teamcity.lan`:
  ![image](https://user-images.githubusercontent.com/88158708/127622942-918406d6-ffe5-4cc5-b18c-127912ecb901.png)
После инициализации сервера teamcity ознакамливаемся с лицензионным соглашением, принемаем условия продукта и создаем админ пользователя.
