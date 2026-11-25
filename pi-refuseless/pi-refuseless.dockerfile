# syntax=docker/dockerfile:1.7
FROM scratch

# pi-refuseless v0.1.1, pinned to its release commit and content digest.
ADD --checksum=sha256:4ae08b058dec3ee426c042f1f4c5b6cbee4f76ef39d1293402c5ee8b34ed9e79 \
    --chown=1000:1000 --chmod=0644 \
    https://raw.githubusercontent.com/kylinholmes/pi-refuseless/681742e31fc4d4ee086634fe8d2b80539316d226/index.ts \
    /home/agent/.pi/agent/extensions/pi-refuseless.ts

ADD --checksum=sha256:8bb880c50172f0ef155c4624e61b0f548671b31de949cc5f5712af4dd8940bad \
    --chmod=0644 \
    https://raw.githubusercontent.com/kylinholmes/pi-refuseless/681742e31fc4d4ee086634fe8d2b80539316d226/LICENSE \
    /usr/share/licenses/pi-refuseless/LICENSE
