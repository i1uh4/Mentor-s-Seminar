#!/bin/bash
# docker_exercise_2_setup.sh

echo "=== Упражнение 2: Создание Docker-образа ==="

# Создание директории проекта
mkdir -p docker-hello-app
cd docker-hello-app

# Создание app.py
cat > app.py << 'EOF'
#!/usr/bin/env python3
print("Hello, Docker!")
print("Этот скрипт запущен внутри контейнера!")
EOF

# Создание Dockerfile
cat > Dockerfile << 'EOF'
FROM python:3.8-slim

WORKDIR /app

COPY app.py .

CMD ["python", "app.py"]
EOF

echo "Файлы созданы:"
ls -la

echo ""
echo "Сборка образа..."
docker build -t hello-docker .

echo ""
echo "Запуск контейнера..."
docker run hello-docker

echo ""
echo "Список образов:"
docker images | grep hello-docker
