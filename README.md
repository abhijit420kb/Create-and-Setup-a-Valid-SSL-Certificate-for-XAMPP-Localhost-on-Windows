# Create and Setup a Valid SSL Certificate for XAMPP Localhost on Windows

**Step 1:** In your `X:\xampp\apache\` file location create a new folder with any name you want e.g `MakeCert`

**Step 2:** Copy `openssl.conf` and `make-cert.bat` file into the folder.

**Step 3:** Run `make-cert.bat` file.

**Step 4:** It will ask for a domain name, enter as you want e.g `localhost` or `local.test` etc.

**Step 5:** It will ask a few more questions. You may enter your own or just hit `Enter` for the default value.

```
-----
Country Name (2 letter code) [US]:
State or Province Name (full name) [NY]:
Locality Name (eg, city) [New York]:
Organization Name (eg, company) [Example, LLC]:
Common Name (e.g. server FQDN or YOUR name) [localhost]:
Email Address [test@example.com]:
-----
```

**Step 6:** If everything is successful, a folder will be created with your entered domain name, e.g `localhost` or `local.test` etc.

**Step 7:** Open the folder. Inside it you'll find `server.crt` and `server.key` files.

**Step 8:** Run/Open/Double-click `server.crt` to install it on Windows.

**Step 9:** Click on `Install Certificate` button.

**Step 10:** Select `Local Machine` as the Store Location.

**Step 11:** Select `Place all certificates in the following store` then click on `Browse` then select `Trusted Root Certification Authorities`

**Step 12:** `OK` > `Next` > `Finish`

**Step 13:** `server.crt` file into your `X:\xampp\apache\conf\ssl.crt\` directory.

**Step 14:** `server.key` file into your `X:\xampp\apache\conf\ssl.key\` directory.

**Step 14:** Restart `Apache` and restart your browser.

At this point it should work fine for the latest xampp and `https://localhost/` but if you use some other domain e.g `local.test` etc.

Then follow bellow steps.

**Add the site to the Windows hosts file**

- Open **Notepad** as administrator.
- Click **File** > **Open** > Browse `C:\Windows\System32\drivers\etc`
- The bottom of the window `Text documents (*.txt)` > Change to `All files (*.*)`
- Open `hosts` (the file has no extension).
- Add this to a new line:
```
127.0.0.1	local.test
```

At this point, it should work fine. You could follow the rest for add virtual host to xampp.

**Add the site to the XAMPP config**

Need to edit `X:\xampp\apache\conf\extra\httpd-xampp.conf` or `X:\xampp\apache\conf\extra\httpd-vhosts.conf`

```
## local.test
<VirtualHost *:80>
    ServerName local.test
    ServerAlias *.local.test

    DocumentRoot "X:/xampp/htdocs/"

    <Directory "X:/xampp/htdocs/">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:443>
    ServerName local.test
    ServerAlias *.local.test

    DocumentRoot "X:/xampp/htdocs/"

    <Directory "X:/xampp/htdocs/">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    SSLEngine on
    SSLCertificateFile "conf/ssl.crt/local.test/server.crt"
    SSLCertificateKeyFile "conf/ssl.key/local.test/server.key"
</VirtualHost>
```

**If you want separate folders for subdomains**

Open `X:\xampp\apache\conf\httpd.conf` in notepad.

Enable mod_vhost_alias `LoadModule vhost_alias_module modules/mod_vhost_alias.so` by remove `#`

Need to edit `X:\xampp\apache\conf\extra\httpd-xampp.conf` or `X:\xampp\apache\conf\extra\httpd-vhosts.conf`

```
## local.test
<VirtualHost *:80>
    ServerName local.test
    ServerAlias *.local.test

    VirtualDocumentRoot "X:/xampp/htdocs/%1"

    <Directory "X:/xampp/htdocs/">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:443>
    ServerName local.test
    ServerAlias *.local.test

    VirtualDocumentRoot "X:/xampp/htdocs/%1"

    <Directory "X:/xampp/htdocs/">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    SSLEngine on
    SSLCertificateFile "conf/ssl.crt/local.test/server.crt"
    SSLCertificateKeyFile "conf/ssl.key/local.test/server.key"
</VirtualHost>
```

**Important: Windows DNS**
Windows `hosts` files don't support wildcard entries.

This won't work:
`127.0.0.1 *.local.test`


You must add individual entries:
```
127.0.0.1   local.test
127.0.0.1   www.local.test
127.0.0.1   api.local.test
127.0.0.1   admin.local.test
```
OR
```
127.0.0.1   local.test    api.local.test    admin.local.test
```

**Reference Links**

https://stackoverflow.com/a/64800566/13166126

https://gist.github.com/turtlepod/3b8d8d0eef29de019951aa9d9dcba546

https://gist.github.com/turtlepod/e94928cddbfc46cfbaf8c3e5856577d0
