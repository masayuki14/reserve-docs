# jupyter notebook をdockerで立ち上げるコマンド
docker run -it --rm -p 8888:8888 jupyter jupyter notebook --ip=0.0.0.0 --allow-root
