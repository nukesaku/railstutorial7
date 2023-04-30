# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.1.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新。-qqは出力を抑制するオプション(エラー以外は表示しない)
RUN apt-get update -qq \
# パッケージのインストール（nodejs、mysql-client、npm yanrを指定）
&& apt-get install -y \
    nodejs \
    npm \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn

# 作業ディレクトリの指定
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME
ARG BUNDLER_VERSION='2.3.14'
RUN gem install bundler -v ${BUNDLER_VERSION}
# Install Rails
ARG RAILS_VERSIONS='7.0.4'
RUN gem install rails -v ${RAILS_VERSIONS}
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh", "/bin/bash"]
