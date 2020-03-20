# terashiy_bot

![Ruby](https://github.com/Mic-U/terashiy_bot/workflows/Ruby/badge.svg?branch=master)

## How to use

### 1. Issue LINE Messaging API Token

Issue your token.
Please see the following.

[LINE Messaging API](https://developers.line.biz/ja/services/messaging-api/)

### 2. Create .env file

Set your access token in terashiy_bot/.env file as the following.

```env
LINE_ACCESS_TOKEN=<YOUR ACCESS TOKEN>
```

### 3. Build

Install dependencies.
It may go wrong when you install with `bundle install` on your local machine, because AWS Lambda running on Amazon Linux 2.
So, I recommend you to use `sam build --use-container` command. This command installs dependencies in docker container.

```sh
$ make build
```

### 4. Deploy

```sh
$ make package BUCKET=<BUCKET_NAME>
$ make deploy STACK=<STACK_NAME>
```

## Testing

```bash
$ bundle install
$ bundle exec rubocop
$ bundle exec rspec
```