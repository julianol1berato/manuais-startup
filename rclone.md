# Copia rápida com logs e progresso 

`rclone copy /root  backups3:9level-aws/root/ --progress --verbose --transfers=8 --checkers=16 --checksum --log-file=rclone-log.txt`
