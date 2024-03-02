FROM juunini/misskey:builder-0.5 AS builder

COPY . /misskey
WORKDIR /misskey
USER root

ENV NODE_ENV=production
ENV VITE_CLOUD_STORAGE_ORIGIN=https://storage.googleapis.com/yodangang-express/

RUN git submodule update --init &&\
  corepack enable &&\
  pnpm install &&\
  pnpm build

FROM juunini/misskey:builder-0.5

WORKDIR /misskey

RUN mkdir -p /misskey/packages/backend &&\
  mkdir -p /misskey/packages/frontend &&\
  mkdir -p /misskey/packages/misskey-js &&\
  mkdir -p /misskey/packages/misskey-reversi &&\
  mkdir -p /misskey/.config

COPY --from=builder /misskey/built /misskey/built
COPY --from=builder /misskey/package.json /misskey/package.json
COPY --from=builder /misskey/pnpm-workspace.yaml /misskey/pnpm-workspace.yaml
COPY --from=builder /misskey/healthcheck.sh /misskey/healthcheck.sh
COPY --from=builder /misskey/node_modules /misskey/node_modules
COPY --from=builder /misskey/packages/backend/package.json /misskey/packages/backend/package.json
COPY --from=builder /misskey/packages/backend/check_connect.js /misskey/packages/backend/check_connect.js
COPY --from=builder /misskey/packages/backend/ormconfig.js /misskey/packages/backend/ormconfig.js
COPY --from=builder /misskey/packages/backend/node_modules /misskey/packages/backend/node_modules
COPY --from=builder /misskey/packages/backend/built /misskey/packages/backend/built
COPY --from=builder /misskey/packages/backend/assets /misskey/packages/backend/assets
COPY --from=builder /misskey/packages/backend/migration /misskey/packages/backend/migration
COPY --from=builder /misskey/packages/frontend/assets /misskey/packages/frontend/assets
COPY --from=builder /misskey/packages/misskey-js/package.json /misskey/packages/misskey-js/package.json
COPY --from=builder /misskey/packages/misskey-js/built /misskey/packages/misskey-js/built
COPY --from=builder /misskey/packages/misskey-js/node_modules /misskey/packages/misskey-js/node_modules
COPY --from=builder /misskey/packages/misskey-reversi/package.json /misskey/packages/misskey-reversi/package.json
COPY --from=builder /misskey/packages/misskey-reversi/built /misskey/packages/misskey-reversi/built
COPY --from=builder /misskey/packages/misskey-reversi/node_modules /misskey/packages/misskey-reversi/node_modules
COPY --from=builder /misskey/packages/misskey-bubble-game/package.json /misskey/packages/misskey-bubble-game/package.json
COPY --from=builder /misskey/packages/misskey-bubble-game/built /misskey/packages/misskey-bubble-game/built
COPY --from=builder /misskey/packages/misskey-bubble-game/node_modules /misskey/packages/misskey-bubble-game/node_modules
COPY --from=builder /misskey/fluent-emojis /misskey/fluent-emojis

ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so
ENV NODE_ENV=production
HEALTHCHECK --interval=5s --retries=20 CMD ["/bin/bash", "/misskey/healthcheck.sh"]

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 3000
CMD ["pnpm", "run", "migrateandstart"]
