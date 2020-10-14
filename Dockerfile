FROM rabbitmq:alpine

ENV RABBIT_USER=taiga \
		RABBIT_PASSWORD=qwerty \
		RABBIT_VHOST=taiga \
    RABBITMQ_ERLANG_COOKIE=taiga \
# RABBITMQ_ERLANG_COOKIE env variable support is deprecated and will be REMOVED in a future version. Use the $HOME/.erlang.cookie file or the --erlang-cookie switch instead.
    RABBITMQ_PID_FILE=$RABBITMQ_DATA_DIR/rabbitmq.pid

COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
