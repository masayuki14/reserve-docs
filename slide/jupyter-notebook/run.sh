# Dockerfile をビルド
docker build -t jupyter .

# jupyter notebook をdockerで立ち上げるコマンド
docker run -it --rm -v $(pwd)/notebook:/root/notebook -p 80:8888 jupyter

## docker container 内で実行するコマンド
# at /root/notebook
# jupyter notebook --ip=0.0.0.0 --allow-root

# 気象庁データダウンロード
# http://www.data.jma.go.jp/gmd/risk/obsdl/index.php
