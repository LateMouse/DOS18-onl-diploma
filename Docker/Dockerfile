FROM nginx:1.25.5
# Напишите инструкцию FROM, которая указывает базовый образ Ubuntu 20.04.
#FROM ubuntu:20.04

#RUN echo "Hello World!" > /usr/share/nginx/html/index.html

COPY WebSite/index.html /usr/share/nginx/html/index.html
COPY WebSite/about.html /usr/share/nginx/html/about.html
COPY WebSite/project.html /usr/share/nginx/html/project.html
COPY WebSite/images/LateMouse.jpg /usr/share/nginx/html/images/LateMouse.jpg
COPY WebSite/images/devops.jpg /usr/share/nginx/html/images/devops.jpg

# Установите необходимые зависимости с помощью инструкции RUN. Установите пакеты nginx и curl, а также создайте каталог /app/static
#RUN apt-get update && apt-get install -y nginx curl && mkdir -p /app/static

#RUN echo "Hello World!" > /var/www/html/index.html 
# Скопируйте файл конфигурации nginx из вашего локального каталога внутрь контейнера с помощью инструкции COPY.
#COPY app/static/nginx.conf /etc/nginx/nginx.conf

# Скопируйте статические файлы из каталога /app/static на вашем локальном компьютере внутрь контейнера с помощью инструкции COPY.
#COPY app/static/index.html /var/www/html/index.html 
#COPY app/static/default /etc/nginx/sites-available/default

# Используйте инструкцию EXPOSE для открытия порта 8080.
# EXPOSE 8080

#CMD ["nginx", "-g", "daemon off;"]