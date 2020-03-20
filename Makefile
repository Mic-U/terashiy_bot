BUCKET = bucket
STACK = terashiy-bot

build:
	cp -f Gemfile ./terashiy_bot/Gemfile
	sam build --use-container
	rm ./terashiy_bot/Gemfile
package:
	sam package --template-file .aws-sam/build/template.yaml --output-template-file .aws-sam/build/packaged.yaml --s3-bucket ${BUCKET}
deploy:
	sam deploy --template-file .aws-sam/build/packaged.yaml --stack-name ${STACK} --capabilities CAPABILITY_IAM