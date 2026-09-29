## *Overview*
*An automated Bash-based utility designed to capture daily broadcasts of* 7News Melbourne and A Current Affair.

## *Deployment Instructions*
*Deploy the script to a Linux-based environment and complete the following setup steps:*

1. Grant Execution Permissions

    *Grant execution privileges to the script:*

    ```Bash
    chmod +x TVNewsDownloader/TVNewsDownloader.sh
    ```

2. Configure Automated Scheduling (Cron)

    *Open the crontab configuration editor:*

    ```Bash
    crontab -e
    ```
    *Append the following entry to automate the download process daily at 11:00 PM:*

    ```Bash
    # Schedule daily download of 7News and A Current Affair at 23:00
    0 23 * * * /home/<username>/TVNewsDownloader/TVNewsDownloader.sh
    ```
    (Note: Replace ***\<username>*** with your actual system username).