FROM docker:17.10.0
COPY root /opt/docker/
RUN ["sh", "/opt/docker/scripts/run.sh"]
USER user
ENTRYPOINT ["bash", "/opt/docker/scripts/entrypoint.sh"]
CMD []