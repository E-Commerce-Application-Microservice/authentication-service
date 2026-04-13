FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production && \
    rm -rf /usr/local/lib/node_modules \
           /usr/local/bin/npm \
           /usr/local/bin/npx \
           /opt/yarn-* \
           /usr/local/bin/yarn \
           /usr/local/bin/yarnpkg \
           /usr/local/bin/corepack
COPY . .
EXPOSE 3002
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:3002/health || exit 1
CMD ["node", "src/index.js"]
