Привет парни взял за основу l4d_broadcast_0_9_7 для доработки.

В итоге получилось добавить звуки так же вывести кил лист чуть ниже центра используя PrintHintText.



Кто-то скажет что я возможно не так делаю загрузку, да я знаю что можно использовать сторонии плагины.

По итогу решил использовать загрузку сразу с этого плагина.



Для установки на свой сервер вам потребуется веб хостинг желательно платный от 100р

Если он у вас уже есть то переходим к настройке, подгрузки и сразу поясню как правильно запустить страницу без ошибок 404.



Вариант установки на свой веб хостинг.

Заходим на веб хостинг, переходим в файловый менеджер. 

Ищем папку www  переходим в нее, дальше видим в этой же папке папку домена, у меня выглядит так wh14269.web2.maze-host  у вас может выглядить по другому. Переходим в папку домена, в папке домена создаем папку soundcontent  дальше заливаем в папку сами звуки(архив) ссылка на архив - http://wh14269.web2.maze-host.ru/download/ Если эта ссылка перестанет быть доступной, залью на гит хаб.



После как загрузили архив со звуками, распаковываем архив в папку soundcontent   

Теперь исправляем ошибку 404, в папку soundcontent  создаем файл .htaccess после как создали открываем файл и пишем такую опцию Options +Indexes , сохраняем. 



Готово теперь можете копировать ссылку и вставлять в конфиг.

У меня это выглядит так.

sm_cvar sv_downloadurl "http://wh14269.web2.maze-host.ru/soundcontent/"
sm_cvar sv_allowupload "1"
sm_cvar sv_allowdownload "1"
Вариант для тех кто не хочет замарачиваться с установкой на свой веб хост.

Здесь уже вы можете использовать мой веб хостинг он проплачен на 3 месяца.

Просто в конфиг закиньте это.

sm_cvar sv_downloadurl "http://wh14269.web2.maze-host.ru/soundcontent/"
sm_cvar sv_allowupload "1"
sm_cvar sv_allowdownload "1"
