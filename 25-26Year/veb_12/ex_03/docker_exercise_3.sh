#!/bin/bash
# docker_exercise_3.sh

echo "=== Упражнение 3: Работа с томами ==="

# Создание тома
echo "Создание тома mysql-data..."
docker volume create mysql-data

# Запуск MySQL контейнера
echo "Запуск MySQL контейнера..."
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=secret \
  -v mysql-data:/var/lib/mysql \
  mysql:5.7

# Ожидание запуска MySQL
echo "Ожидание запуска MySQL (30 секунд)..."
sleep 30

# Создание базы данных
echo "Создание базы данных testdb..."
docker exec -i mysql-container mysql -uroot -psecret << EOF
CREATE DATABASE testdb;
SHOW DATABASES;
EOF

echo ""
echo "Остановка и удаление контейнера..."
docker rm -f mysql-container

echo ""
echo "Запуск нового контейнера с тем же томом..."
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=secret \
  -v mysql-data:/var/lib/mysql \
  mysql:5.7

# Ожидание запуска
sleep 30

echo ""
echo "Проверка наличия базы данных testdb..."
docker exec -i mysql-container mysql -uroot -psecret << EOF
SHOW DATABASES;
EOF

echo ""
echo "База данных testdb сохранилась! Том работает."
