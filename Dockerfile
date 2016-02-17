FROM alpine:latest
ENV APTLIST="bash curl git php-cli php-json php-curl php-phar php-openssl php-xml php-dom"
ENV COMPOSER_HOME="/app"

#Add your email and password on runtime
ENV EMAIL = ""
ENV PASSWORD = ""

ADD start.sh /start.sh

# Make directory
RUN mkdir -p /downloads && \
# Install and update
	cd / && \
	apk update && \
	apk upgrade	&& \
	apk add --update $APTLIST && \
	curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /bin/composer && \
	rm -r /app && \
# Install laravel downloader
	git clone https://github.com/iamfreee/laracasts-downloader.git /app && \
	cd /app && \
	composer install && \
	mv /app/config.example.ini /app/config.ini && \
	chmod +x /start.sh && \
	rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME /downloads

ENTRYPOINT ["/start.sh"]
