# Load environment variables from .env file
source .env
sudo docker run -dp 27017:27017 -v ${CURRENT_PWD}/mongodb_data:/data/db --name mongodb --restart=always mongo:latest
sudo docker ps -a