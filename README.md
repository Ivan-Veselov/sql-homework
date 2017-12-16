# sql-homework

*Академический Университет, осенний семестр 2017 года.*

**Предмет**: Базы данных

**Преподаватель**: Барашев Д. В.

**Команда**: Веселов, Кайсин, Фёдорова, Шавкунов

## Инструкция по работе с репозиторием:

Чтобы вся команда могла видеть изменения и комментировать их, в ветку master необходимо делать [pull-request](https://help.github.com/articles/about-pull-requests/). В pull-request необходимо запросить [review](https://help.github.com/articles/requesting-a-pull-request-review/) всех остальных членов команды. После того, как вся команда одобрила pull-request, его можно сливать в ветку master.

## diagram.xml

В файле diagram.xml находится диаграмма таблиц базы данных. Этот файл можно открыть с помощью онлайн сервиса [draw.io](https://www.draw.io/).

## Cервер

[API](https://docs.google.com/document/d/1_x5iuYHjmK96zsDj2hNFROGvErIVjn_cCnLEqmC4TBk/edit?usp=sharing)

[Архитектура](https://docs.google.com/drawings/d/1EQBvECH23qZILDWx2yz7CtsA_SOPlCoKkQavJUeEWEw/edit?usp=sharing)

## Инструкция по запуску

* `startDatabase.sh` запускает docker с инициализированной базой данных. Можно передать в качестве аргумента номер порта, по которому нужно будет получать доступ к базе.

* Само серверное приложение с клиентом находится в папке `server`.

* Сервер запускается командой `gradle run`.

* В качестве опционального аргумента можно передать порт, по которому нужно общаться с базой данных. Это делается командой `gradle run -PappArgs="['5432']"`.

* По умолчанию используется порт `5432`.
