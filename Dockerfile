FROM node:lts as builder

WORKDIR /web-ui/
COPY . .
RUN git clone https://github.com/marceloaguero/emojize-proto.git proto
RUN npm install
RUN npx webpack app.js

FROM python:2.7
WORKDIR /web-ui/
COPY --from=builder /web-ui/ .
ENTRYPOINT [ "python" ]
CMD [ "-m", "SimpleHTTPServer", "9001" ]
EXPOSE 9001
