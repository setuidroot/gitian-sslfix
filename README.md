# gitian-sslfix
Fix for distro.ibiblio.org SSL errors on Gitian for Monero

The original Github issue (the reason why I wrote this script) is here: https://github.com/monero-project/monero/issues/7147

# How to use
Just download and run (as root or with sudo.)

Download with wget:

````
wget -O /tmp/gitian-sslfix.sh https://raw.githubusercontent.com/setuidroot/gitian-sslfix/main/gitian-sslfix.sh
````

Run with sudo:

````
sudo chmod 775 /tmp/gitian-sslfix.sh && bash /tmp/gitian-sslfix.sh
````

# Quick run:

````
wget -O - https://raw.githubusercontent.com/setuidroot/gitian-sslfix/main/gitian-sslfix.sh | bash
````
