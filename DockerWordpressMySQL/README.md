# docker or Shazam...

i want to run wordpress and mysql,<br>

OK sir,<br><br>

docker-compose up -d <br>

go to 127.0.0.1<br>
<br>

I can not believe my eyes,<br>
like magic,<br>
Land ahoy!,<br><br>

It's done


---------------------------------------------------------------------------------

# MySQL & PhpMyAdmin<p>
docker run --name mysql-server -p 3306:3306 -v /opt/data:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=test123 -d mysql <br>

docker run --name pmyadmin -p 8000:80 --link mysql-server:db -d phpmyadmin/phpmyadmin

---------------------------------------------------------------------------------
# docker code exam
docker exec -it d18 /bin/bash
