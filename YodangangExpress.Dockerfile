FROM juunini/misskey:builder-0.2 AS builder

COPY . /misskey
WORKDIR /misskey
USER root

ENV NODE_ENV=production

RUN git submodule update --init
RUN corepack enable
RUN pnpm install
RUN pnpm build

FROM juunini/misskey:builder-0.2

RUN apt install -y tini

WORKDIR /misskey

RUN mkdir -p /misskey/packages/backend
RUN mkdir -p /misskey/.config

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
COPY --from=builder /misskey/fluent-emojis /misskey/fluent-emojis

ENV NODE_ENV=production
HEALTHCHECK --interval=5s --retries=20 CMD ["/bin/bash", "/misskey/healthcheck.sh"]

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 3000
CMD ["pnpm", "run", "start"]
