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
# Output to .aws-sam/build directory
$ sam build --use-container
```

### 4. Deploy

```sh
$ sam package --template-file .aws-sam/build/template.yaml --output-template-file .aws-sam/build/packaged.yaml --s3-bucket <BUCKET_NAME>
$ sam deploy --template-file .aws-sam/build/packaged.yaml --stack-name <STACK_NAME> --capabilities CAPABILITY_IAM
```

## Testing

```bash
$ bundle install
$ bundle exec rubocop
```