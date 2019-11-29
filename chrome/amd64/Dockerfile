FROM jess/chrome

USER root

RUN usermod -u 1000 chrome && groupmod -g 1000 chrome
RUN chown chrome:chrome /home/chrome

USER chrome
