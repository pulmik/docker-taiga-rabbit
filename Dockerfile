FROM rabbitmq:alpine

ENV RABBIT_USER=taiga \
		RABBIT_PASSWORD=qwerty \
		RABBIT_VHOST=taiga

COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
