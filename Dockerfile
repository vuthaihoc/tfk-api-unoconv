# Setting the base to docker-node-unoconv
FROM telemark/docker-node-unoconv:8.11.2@sha256:a0ccd23cec011eb679b5b8f32f068193133f008fed1f2acfb7f279d8793eb1fd

#### Begin setup ####

# Update fonts
COPY ./fonts/* /usr/local/share/fonts/
RUN fc-cache -fv

# Bundle app source
COPY . /src

# Change working directory
WORKDIR "/src"

# Install dependencies
RUN npm install --production

# Env variables
ENV SERVER_PORT 3000
ENV PAYLOAD_MAX_SIZE 104857600
ENV TIMEOUT_SERVER 300000
ENV TIMEOUT_SOCKET 330000

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 & node standalone.js