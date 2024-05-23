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
