FROM node:18-alpine

WORKDIR /app

# Встановлення залежностей для build
RUN apk add --no-cache python3 make g++

# Копіюй package.json
COPY package.json package-lock.json* ./

# Встановлення залежностей
RUN npm ci

# Копіюй весь код
COPY . .

# Зібрати React фронтенд (якщо є src/)
RUN if [ -d "src" ]; then npm run build; fi

# Expose порт
EXPOSE 3000

# Змінна для production
ENV NODE_ENV=production

# Запуск API сервера
CMD ["node", "api-server.js"]
