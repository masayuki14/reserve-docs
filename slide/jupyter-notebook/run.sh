# jupyter notebook をdockerで立ち上げるコマンド
docker run -it --rm -v $(pwd)/notebook:/root/notebook -p 8888:8888 jupyter /bin/bash

## docker container 内で実行するコマンド
# cd
# jupyter notebook --ip=0.0.0.0 --allow-root
