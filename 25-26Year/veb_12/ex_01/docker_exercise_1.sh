
#!/bin/bash
# docker_exercise_1.sh

echo "=== Упражнение 1: Установка Docker и hello-world ==="

# Проверка установки Docker
if ! command -v docker &> /dev/null; then
    echo "Docker не установлен. Установка..."
    
    # Для Ubuntu/Debian
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        
        # Добавление пользователя в группу docker
        sudo usermod -aG docker $USER
        echo "Выйдите и войдите снова для применения прав группы docker"
    fi
fi

echo "Запуск hello-world..."
docker run hello-world

echo ""
echo "Запуск интерактивного контейнера Ubuntu..."
echo "Выполните команды: ls, pwd, exit"
docker run -it ubuntu bash

echo ""
echo "Список всех контейнеров:"
docker ps -a

echo ""
echo "Остановка всех контейнеров..."
docker stop $(docker ps -aq) 2>/dev/null || echo "Нет запущенных контейнеров"
