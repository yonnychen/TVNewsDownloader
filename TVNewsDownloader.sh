#!/usr/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use relative paths based on script location
EPISODE_FILE="$SCRIPT_DIR/Episode_Number.txt"
DOWNLOAD_DIR="$SCRIPT_DIR"
LOG_FILE="$SCRIPT_DIR/error.log"
YTDLP="/usr/local/bin/yt-dlp"
# THROTTLE="256K"

# Delete all mp4 files in the download directory
find "$DOWNLOAD_DIR" -maxdepth 1 -type f -name "*.mp4" -exec rm -f {} \;

# Read episode numbers
read -r SEVEN_EP ACA_EP < "$EPISODE_FILE"

# Increment Seven News episode
NEXT_SEVEN_EP=$((SEVEN_EP + 1))

if [ "$NEXT_SEVEN_EP" -lt 10 ]; then
    SEVEN_URL="https://7plus.com.au/seven-news-melbourne?episode-id=7NNM26-00$NEXT_SEVEN_EP"
elif [ "$NEXT_SEVEN_EP" -lt 100 ]; then
    SEVEN_URL="https://7plus.com.au/seven-news-melbourne?episode-id=7NNM26-0$NEXT_SEVEN_EP"
else
    SEVEN_URL="https://7plus.com.au/seven-news-melbourne?episode-id=7NNM26-$NEXT_SEVEN_EP"
fi

# Download Seven News
if ! "$YTDLP" -P "$DOWNLOAD_DIR" "$SEVEN_URL"; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ❌ Failed to download Seven News Melbourne 2026 episode $NEXT_SEVEN_EP" >> "$LOG_FILE"
    echo "URL: $SEVEN_URL" >> "$LOG_FILE"
    echo >> "$LOG_FILE"
else
    SEVEN_EP=$NEXT_SEVEN_EP
fi

# Check if today is Sunday
DAY_OF_WEEK=$(date +%u)  # 1 = Monday, 7 = Sunday
if [ "$DAY_OF_WEEK" -ne 7 ]; then
    NEXT_ACA_EP=$((ACA_EP + 1))
    ACA_URL="https://www.9now.com.au/a-current-affair/season-2026/episode-$NEXT_ACA_EP"

    if ! "$YTDLP" -P "$DOWNLOAD_DIR" "$ACA_URL"; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ❌ Failed to download A Current Affair 2026 episode $NEXT_ACA_EP" >> "$LOG_FILE"
        echo "URL: $ACA_URL" >> "$LOG_FILE"
        echo >> "$LOG_FILE"
    else
        ACA_EP=$NEXT_ACA_EP
    fi
fi

# Update episode numbers
echo "$SEVEN_EP $ACA_EP" > "$EPISODE_FILE"