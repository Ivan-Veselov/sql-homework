sudo docker build -t olympic_db .
sudo docker run -p 5432:5432 -it olympic_db

