
#!/bin/bash
# docker_exercise_4_setup.sh

echo "=== Упражнение 4: Работа с сетями ==="

# Создание директории проекта
mkdir -p docker-redis-app
cd docker-redis-app

# Создание сети
echo "Создание сети my-network..."
docker network create my-network

# Запуск Redis
echo "Запуск Redis..."
docker run -d --name redis-server --network my-network redis

# Создание скрипта set_message.py
cat > set_message.py << 'EOF'
import redis
import time

# Ожидание запуска Redis
time.sleep(2)

r = redis.Redis(host='redis-server', port=6379)
r.set('message', 'Hello from Python')
print("Message set in Redis")
EOF

# Создание скрипта get_message.py
cat > get_message.py << 'EOF'
import redis

r = redis.Redis(host='redis-server', port=6379)
message = r.get('message')
if message:
    print("Message from Redis:", message.decode())
else:
    print("No message found")
EOF

# Создание Dockerfile для Python с redis
cat > Dockerfile << 'EOF'
FROM python:3.8-slim

RUN pip install redis

WORKDIR /app

CMD ["python"]
EOF

echo "Сборка образа Python с redis..."
docker build -t python-redis .

# Ожидание запуска Redis
sleep 5

echo ""
echo "Установка значения в Redis..."
docker run --rm --name python-setter --network my-network \
  -v $(pwd)/set_message.py:/app/set_message.py \
  python-redis python /app/set_message.py

echo ""
echo "Чтение значения из Redis..."
docker run --rm --name python-getter --network my-network \
  -v $(pwd)/get_message.py:/app/get_message.py \
  python-redis python /app/get_message.py

echo ""
echo "Упражнение завершено!"
