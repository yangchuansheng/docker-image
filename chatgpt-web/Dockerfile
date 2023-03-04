# build front-end
FROM node:lts-alpine AS builder

RUN apk update && apk add git

RUN git clone https://github.com/Chanzhaoyu/chatgpt-web /app

WORKDIR /app

RUN sed -i '/setting.socks/a\ \ \ \ \ \ <p>🛒 <a class="text-blue-600" href="https://shop.terobox.com/?from=1069" target="_blank">ChatGPT Plus 订阅账号购买</a></p>' ./src/components/common/Setting/About.vue; \
    sed -i "s/如果你觉得此项目对你有帮助，请在 Github 帮我点个 Star 或者给予一点赞助，谢谢！/由于维护网站运营，本网站可能存在收费或广告等行为，与程序作者无关。 /g" ./src/components/common/Setting/About.vue; \
    sed -i '/setting.socks/a\ \ \ \ \ \ <p>群组： <a class="text-blue-600 dark:text-blue-500" href="https://t.me/littleb_tech" target="_blank"> https://t.me/fuck_you_chatgpt </a></p>' ./src/components/common/Setting/About.vue; \
    sed -i 's#https://github.com/Chanzhaoyu/chatgpt-bot#https://t.me/fuck_you_chatgpt#g' ./src/store/modules/user/helper.ts; \
    sed -i 's/Star on/欢迎加入/g' ./src/store/modules/user/helper.ts; \
    sed -i 's/GitHub/群组/g' ./src/store/modules/user/helper.ts; \
    sed -i 's/GitHub/群组/g' ./src/components/custom/GithubSite.vue

RUN npm install pnpm -g && pnpm install && pnpm run build

# service
FROM node:lts-alpine

COPY --from=builder /app/service /app
COPY --from=builder /app/dist /app/public

WORKDIR /app
RUN npm install pnpm -g && pnpm install

EXPOSE 3002

CMD ["pnpm", "run", "start"]
