## Automated SSL Renewal w/ Dockerized Certbot
ADL services are typically deployed with Docker, with HTTP served by the usual pairing of Nginx with SSL certificates provided by Certbot.  While this has provided a clean way of configuring machines without explicit host OS installs of either, it does complicate the automated SSL renewal usually provided by Certbot.

Instead of the default Certbot cronjob, we run a modified version of our manual SSL renewal script.

### TL;DR
1. `git clone https://github.com/adlnet/auto-ssl ~/auto-ssl`
2. `cd ~/auto-ssl`
3. Open the root crontab `sudo crontab -e`
4. Paste the following lines:
```
PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin
0 2 * * 6 /home/ubuntu/auto-ssl/renew.sh <project path>
```
replacing `<project path>` with the proper folder path (i.e. `~/tla/adl-auth`).  That's it.

**Note**: The `/home/ubuntu` is most common, as we typically use an Ubuntu OS.  For CentOS or something else, just provide a path to the `auto-ssl/renew.sh` file. 

### More Detail
This cronjob is specified with time `0 2 * * 6`, meaning it will run:
- `6`: On Saturdays
- `*`: Any Month
- `*`: Any Day
- `2`: At 2AM
- `0`: and 0 minutes

the values for which can obviously be adjusted for whatever your use case may be.

The path argument supplied by `<project path>` tells the script where to locate the corresponding `docker-compose.yml` file for whichever server's SSL is being automated.  Additionally, this output can be found at `~/renew.log` and the script can be manually run just via
```
sudo ~/auto-ssl/renew.md <project-path>
```
to ensure that everything is working properly -- you should see something like this
```
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
The following certificates are not due for renewal yet:
  /etc/letsencrypt/live/tla-dev-auth.usalearning.net/fullchain.pem expires on 2021-06-01 (skipped)
No renewals were attempted.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

**Note:** If crontab is not being run as the root user, you'll need to add them to the Docker group:
```
sudo usermod -aG docker $USER
```
