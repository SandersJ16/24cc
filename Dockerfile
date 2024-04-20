# 24 Hour Conditioning Competition (NestJS)
ARG NODE_VERSION=20.11.0

###############
# Base        #
###############
FROM node:${NODE_VERSION} as base
ARG WORKING_DIRECTORY=/user/app
WORKDIR ${WORKING_DIRECTORY}
RUN chown node:node ${WORKING_DIRECTORY}
EXPOSE 3000

# Install Utilities
RUN apt-get update && apt-get install -y \
    vim
# Install latest npm
RUN npm update -g
# Install global nest commands
RUN npm i -g @nestjs/cli


###############
# Development #
###############
FROM base as dev
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
USER node
COPY --chown=node:node . .
CMD npm run start:dev


##############
# Production #
##############
FROM base as prod
ENV NODE_ENV production
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev
USER node
COPY --chown=node:node . .
CMD npm run start
