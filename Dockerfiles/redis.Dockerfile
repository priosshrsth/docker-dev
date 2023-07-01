FROM alpine as base
RUN apk add --update nodejs npm

ARG APP_PATH=/app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
RUN npm i -g redis-commander

FROM base as server
ENV PORT 8081
EXPOSE 8081
# Running the app
CMD ["redis-commander", "-p", "8081", "--redis-host", "redis"]
