FROM rabbitmq:alpine

ENV RABBIT_USER=taiga \
		RABBIT_PASSWORD=qwerty \
		RABBIT_VHOST=taiga \
    RABBITMQ_ERLANG_COOKIE=taiga \
    RABBITMQ_PID_FILE=$RABBITMQ_DATA_DIR/rabbitmq.pid

COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
