format:
  npx prettier --write .

build: format
  hugo build

deploy: format
  hugo --gc
