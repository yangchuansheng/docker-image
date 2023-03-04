# build front-end
FROM node:lts-alpine AS builder

RUN apk update && apk add git

RUN git clone https://github.com/Chanzhaoyu/chatgpt-web /app

WORKDIR /app

RUN sed -i '/如果你觉得此项目对你有帮助/a\ \ \ \ \ \ \ \ \ \ <br>🛒 <a class="text-blue-600" href="https://shop.terobox.com/?from=1069" target="_blank">ChatGPT Plus 订阅账号购买</a>' /src/components/common/Setting/About.vue

RUN npm install pnpm -g && pnpm install && pnpm run build

# service
FROM node:lts-alpine

COPY --from=builder /app/service /app
COPY --from=builder /app/dist /app/public

WORKDIR /app
RUN npm install pnpm -g && pnpm install

EXPOSE 3002

CMD ["pnpm", "run", "start"]
