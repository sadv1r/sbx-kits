FROM scratch

COPY --chown=1000:1000 files/opencode.json /etc/opencode/opencode.json
COPY --chown=1000:1000 files/pi-models.json /home/agent/.pi/agent/models.json
COPY --chown=1000:1000 files/omp/ /home/agent/.omp/agent/
