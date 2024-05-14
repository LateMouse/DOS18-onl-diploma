FROM nginx:1.25.5
# Определям базовый образ, на основе которого будет создан новый образ. В данном случае, базовым образом является nginx:1.25.5

COPY WebSite/index.html /usr/share/nginx/html/index.html
COPY WebSite/about.html /usr/share/nginx/html/about.html
COPY WebSite/project.html /usr/share/nginx/html/project.html
COPY WebSite/images/LateMouse.jpg /usr/share/nginx/html/images/LateMouse.jpg
COPY WebSite/images/devops.jpg /usr/share/nginx/html/images/devops.png
COPY WebSite/images/devops.jpg /usr/share/nginx/html/images/dec1.png
COPY WebSite/images/devops.jpg /usr/share/nginx/html/images/dec2.png
COPY WebSite/images/devops.jpg /usr/share/nginx/html/images/top.jpg
# Копируем файлы и директории из локальной файловой системы в образ. Каждая из  инструкций "COPY" копирует определенные файлы и директории в указанные пути внутри образа.
