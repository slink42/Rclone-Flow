#! /bin/bash -eu

if [ "$CONF_BASE64" != "" ]; then
  mkdir -p /app/.config/
  echo "$CONF_BASE64" | base64 -d > /app/.config/rclone.conf
  chmod +x /app/.config/rclone.conf
  echo "[INFO] Rclone config file decoded!"
fi

if [ "$SERVE_REMOTE" = "" ]; then
  echo "[INFO] Starting Rclone webgui"
  rclone rcd --rc-web-gui \
    --rc-web-gui-no-open-browser\
    --rc-allow-origin "https://rclone.github.io" \
    --rc-web-fetch-url "https://api.github.com/repos/rclone/rclone-webui-react/releases/latest" \
    --rc-web-gui-update \
    --rc-addr 0.0.0.0:$PORT \
    --rc-user $USERNAME \
    --rc-pass $PASSWORD
else
  echo "[INFO] Starting Rclone serve ${SERVE_PROTOCOL}"
  rclone serve ${SERVE_PROTOCOL} \
    --addr 0.0.0.0:$PORT \
    --user $USERNAME \
    --pass $PASSWORD \
    "${SERVE_REMOTE}:"
fi
echo "[INFO] Rclone started!"