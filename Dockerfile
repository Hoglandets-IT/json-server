FROM node:20-bookworm AS build

WORKDIR /build

COPY public public
COPY src src
COPY scripts scripts

COPY package.json .
COPY package-lock.json .
COPY .babelrc .
COPY LICENSE .


RUN npm ci
RUN ls -al && npm run build

FROM node:20-bookworm AS base

WORKDIR /app

COPY --from=build /build/lib lib

COPY --from=build /build/scripts/start.sh start.sh

COPY --from=build /build/LICENSE .

COPY --from=build /build/package.json .
COPY --from=build /build/package-lock.json .

RUN npm ci --production

RUN chmod +x start.sh

CMD ["./start.sh"]

