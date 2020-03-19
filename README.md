# terashiy_bot

## Build & Deploy

```sh
# Output to .aws-sam/build directory
$ sam build --use-container
$ sam package --template-file .aws-sam/build/template.yaml --output-template-file .aws-sam/build/packaged.yaml --s3-bucket <BUCKET_NAME>
$ sam deploy --template-file .aws-sam/build/packaged.yaml --capabilities CAPABILITY_IAM
```

## Testing

```bash
$ bundle install
$ bundle exec rubocop
```