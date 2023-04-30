# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.1.2

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq \
# パッケージのインストール（nodejs、mysql-client、npm yanrを指定）
&& apt-get install -y nodejs npm \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn

# 作業ディレクトリの指定
WORKDIR /app
COPY . /app
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh", "/bin/bash"]
