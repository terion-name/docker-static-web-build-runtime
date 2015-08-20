# Image for building and serving static sites generated with modern tools

Packages installed: nginx, nodejs, bundler (ruby), bower.
Global gulp doesn't work correctly by some reason, so it should be installed locally and run from node_modules. You can also use grunt or any other build tool in the same manner.
Nginx root is set to `/var/www/html/build/`, so src files should be places in `/var/www/html/` and build script should build in `./build/` directory.

Example Dockerfile:

```
FROM terion/static-web-build-runtime

## prepare
ADD ./ /var/www/html/
WORKDIR /var/www/html/
RUN chown -R u_web .

# both variants, 'RUN su u_web && cmd' and  'USER u_web \ RUN cmd' seem to work with sudo permissions
# this is annoying but no way to change
# using USER u_web invokes sudo -u and triggers server to show lecture that breaks all process

## build
RUN su u_web && bundle install
RUN su u_web && npm install
RUN su u_web && ./node_modules/bower/bin/bower install --allow-root
RUN su u_web && node ./node_modules/gulp/bin/gulp.js --production
```