FROM artemklevtsov/r-alpine:latest

MAINTAINER ChanYub Park mrchypark@gmail.com

COPY app.R /home/app.R

WORKDIR /home/

ENTRYPOINT ["Rscript"]
CMD ["app.R"]
