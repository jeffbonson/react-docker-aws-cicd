Just an app to test react - docker - aws -cicd.

# Getting Started with Create React App - react-docker-aws-cicd
- npm start
- browser - http://localhost:3000
- npm test - Launches the test runner in the interactive watch mode.
- npm run build - Builds the app for production to the `build` folder
# Git hub repository
- Push to git hub repository - https://github.com/jeffbonson/react-docker-aws-cicd
# Create a 'Dockerfile' in the root directory
- Build the docker image using the docker file -  docker build -t jeffbonson85/react-docker-aws-cicd:latest .
- Check for jeffbonson85/react-docker-aws-cicd in the docker hub's Images page.
- Stop the react server
- Open Docker Desktop
- Run the image using the command - docker run -d -p 3000:3000 jeffbonson85/react-docker-aws-cicd:latest
- Run the command to see running containers - docker ps
- Check for an entry in containers
- open localhost:3000 in web browser
- yay!
# Push to docker hub - hub.docker.com
- Tag the docker image using the command - docker tag jeffbonson85/react-docker-aws-cicd:latest jeffbonson85/react-docker-aws-cicd:latest
- Push to docker hub using the command - docker push jeffbonson85/react-docker-aws-cicd:latest
- Login to hub.docker.com and refresh the Repositories page to see the new repository named - jeffbonson85/react-docker-aws-cicd:latest.
# To use this in MacBook
- Install Docker Desktop / colima in mac OS
- docker login
- Go to hub.docker.com/repositories/react-docker-aws-cicd/tags and copy the command - docker pull jeffbonson85/react-docker-aws-cicd:latest
- run the command - docker run -d -p 3000:3000 jeffbonson85/react-app:latest
- open localhost:3000 in web browser
- yay!
# Install docker and use this app in AWS-EC2 instance
- create an ec2 instance using t3.medium- free tire, ubuntu, security rule with ipv4 - tcp - 3000 port inbound rule
- login to instance using the public IP -  ssh -i aws_login.pem ubuntu@52.54.129.218
- sudo apt update
- sudo apt install -y docker.io
- docker login
- sudo systemctl start docker
- sudo systemctl enable docker
- docker pull jeffbonson85/react-docker-aws-cicd:latest
- docker run -d -p 3000:3000 jeffbonson85/react-docker-aws-cicd:latest
- open web browser and access http://52.54.129.218:3000
- yay!
# Using docker to deploy to Elastic Beanstalk
- Modify the docker file
  - expose port from 3000 to 80
  - introduce builder, nginx, copy from builder
  - change the CMD options
  - see [commit history](https://github.com/jeffbonson/react-docker-aws-cicd/commit/d71fd0c1cbd2dc8dd61c08fa4130b32bdf01a7c1) to compare initial file.
- Create a docker-compose.yml
- run docker-compose up --build
- run http://localhost
- Create EC2 instance profile role
  - Select IAM / Roles / Create Role
  - Name: react-docker-aws-cicd-role 
  - Select Permission Policies: AdministratorAccess-AWSElasticBeanstalk, AmazonS3ReadOnlyAccess 
- Go to AWS Elastic BeanStalk
  - create Application
  - tire - web server environment
  - Application Name: react-aws-docker-cicd (Note that the name has changed a bit!)
  - Environment Name: React-aws-docker-cicd-env (auto filled)
  - Platform: select Docker
  - Application Code: select Sample Application
  - Presets: select Single Instance
  - Service Role: create a new service role
  - Select EC2 instance profile - react-docker-aws-cicd-role
  - Select VPC, activate public ip,
  - Select security groups
  - Select Health: enhanced, Managed updates: deselect
  - Create - wait for some time.
  - After completion, visit the environment - React-aws-docker-cicd-env
  - Right side, you can find a link named - Go to environment link, visit it and you can see a sample website
  - http://react-aws-docker-cicd-env.eba-wk5d3rdq.us-east-1.elasticbeanstalk.com/
- Create IAM user
  - Go to EC2/ IAM / (Left pane) Users / Create User
  - Username: react-docker-aws-cicd-user
  - Check - Provide user access tp the AWS Management Console
  - Radio select - I want to create an IAM user
  - Custom Password - eg Awsuser001$
  - Uncheck - User must create a new password at next signin | Next >
  - Select - Attach policies directly (since this is a demo and no groups are added)
  - Permission Policies - AWSCodeCommitPowerUser, CodeBuildAdminAccess
  - Next > Create User > Copy the number from console sign-in url
  - To Verify - Open a new incognito window and go to aws console and log back in
    - Select IAM user and paste the number and hit Next.
    - Enter IAM username: react-docker-aws-cicd-user
    - Password: eg Awsuser001$
    - Login
    - Check the region of the root user and if IAM user region is different change from header.
  - Go back to root user / IAM / react-docker-aws-cicd-user
    - Create permission policy
      - Go to IAM / DAshboard / Policies / Create policy
      - Name: policy 001
      - Services: AutoScaling, Cloud Control API, CloudFormation, EC2, EC2 AutoScaling, ElasticBeanStalk, S3
      - Create
      - Verify the json data with the of the file .github/workflows/iam-user-policy.json
    - Update User Permission policy
      - Go back to IAM / Users / react-docker-aws-cicd-user / Permission Policies
      - Add Permission
      - Select policy 001 and save
    - Access Keys
      - select others
      - enter description / save
      - copy or download - AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
  - Go to the https://github.com/jeffbonson/react-docker-aws-cicd/settings/secrets/actions
    - Create new Repository secret
    - Paste the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

- Deploy the react app using CICD
  - create a file in .github/workflows/deploy-aws.yml
  - change the application name and environment name, region if needed
  - The AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY will also be pulled from the repository secret actions
  - push the file changes to github
  - Go to https://github.com/jeffbonson/react-docker-aws-cicd/actions
  - you can see a new action with the commit message as title
  - reload the environment - http://react-aws-docker-cicd-env.eba-wk5d3rdq.us-east-1.elasticbeanstalk.com/
  - yay!




