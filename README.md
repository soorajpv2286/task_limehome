This script is to search a sub string in the mentioned AWS S3 Bucket. Basically this script will download the passed S3 bucket and then search for the sub string mentioned.

Instructions
1. Make sure you have access to the mentioned  AWS account and S3 bucket get access on that account.
2. Either you can attach an IAM role which has the above mentioned access to the Ec2 Instance or if its your local machine, you can create an AWS IAM user, attach S3 policies, download the Access & Secret keys, then Keys can be exported to terminal using "export" command or configure using "aws configure" command.
3. Make sure the script has execute permissions and if it does not have, set it using chmod +x <script_name>
4. Run the Shell script using bash <script_name> <bucket_name> <pattern_string>

Same script can be rewritten in Python3 using boto3, I have tried it, but boto3 doesn't have an option to download the entire bucket. We can list the contents of a bucket and using loops we can download it one by one, but that's too much processing for a small task like this. That is the reason I went for AWS SDK with Shell.
