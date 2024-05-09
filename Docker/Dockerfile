FROM nginx:latest

RUN echo "Hello World!" > /usr/share/nginx/html/index.html

# Скопируйте файл конфигурации nginx из вашего локального каталога внутрь контейнера с помощью инструкции COPY.
#COPY app/static/nginx.conf /etc/nginx/nginx.conf

# Скопируйте статические файлы из каталога /app/static на вашем локальном компьютере внутрь контейнера с помощью инструкции COPY.
#COPY app/static/index.html /var/www/html/index.html 
#COPY app/static/default /etc/nginx/sites-available/default

# Используйте инструкцию EXPOSE для открытия порта 8080.
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]