# TV News Downloader

A Bash script that downloads the next configured episodes of Seven News Melbourne and *A Current Affair* using `yt-dlp`.

## Features

- Builds episode URLs for the 2026 Seven News Melbourne and *A Current Affair* releases.
- Advances each programme's episode number only after its download succeeds.
- Skips *A Current Affair* on Sundays, based on the machine's local date and time.
- Appends failed download details and URLs to `error.log` beside the script.
- Stores the current episode numbers in `Episode_Number.txt` beside the script.

## Requirements

- Bash on Linux or another Unix-like environment.
- `yt-dlp` installed and executable at `/usr/local/bin/yt-dlp`, as specified in the script.
- Network access to 7plus and 9Now, and write permission for the script directory.

If `yt-dlp` is installed elsewhere, update the `YTDLP` path near the top of `TVNewsDownloader.sh`.

## Setup

1. Place `TVNewsDownloader.sh` and `Episode_Number.txt` in the same directory.
2. Make the script executable:

    ```bash
    chmod +x /path/to/TVNewsDownloader.sh
    ```

3. Check `Episode_Number.txt`. It must contain two space-separated integers:

    ```text
    <last-successful-Seven-News-episode> <last-successful-ACA-episode>
    ```

    For example, `179 135` makes the next run attempt Seven News episode 180 and *A Current Affair* episode 136. Set these values to match the episodes you want the script to attempt next.

4. Test manually before scheduling:

    ```bash
    /path/to/TVNewsDownloader.sh
    ```

## Schedule with cron

To run every day at 11:00 PM, open the crontab editor:

```bash
crontab -e
```

Add an entry using the full path to the script:

```cron
0 23 * * * /path/to/TVNewsDownloader.sh
```

Cron uses the host's configured local time. The script skips *A Current Affair* when that local date is Sunday.

## Important: Existing MP4 files

At the beginning of every run, the script deletes **all `.mp4` files directly inside its own directory** before attempting either download. Move any files you need to keep elsewhere, or change the cleanup command in the script before running it. Files in subdirectories are not deleted by this command.

## Troubleshooting

- Review `error.log` for failed downloads. The log includes a timestamp, programme and episode number, and URL.
- Confirm the `yt-dlp` path is correct and executable.
- Confirm `Episode_Number.txt` contains exactly two valid integers and that the script directory is writable.
- Run the script manually to see `yt-dlp` output directly.