FROM registry.gitlab.com/mrchypark/r-minideb/r-release:latest

MAINTAINER ChanYub Park mrchypark@gmail.com

RUN apt update \
  && apt install -y libcurl4-openssl-dev \
  libxml2-dev \
  libssl-dev
  
RUN Rscript -e "install.packages(c('httr','jug'))"

COPY app.R /home/app.R

WORKDIR /home/

CMD ["Rscript", "app.R"]
