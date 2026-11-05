@echo off
set /p XAMPP_SSL_DOMAIN="Enter Domain: "

if not exist .\%XAMPP_SSL_DOMAIN% mkdir .\%XAMPP_SSL_DOMAIN%

..\bin\openssl req -config openssl.conf -new -sha256 -newkey rsa:2048 -nodes -keyout %XAMPP_SSL_DOMAIN%\server.key -x509 -days 3650 -out %XAMPP_SSL_DOMAIN%\server.crt

echo.
echo -----
echo The certificate was provided.
echo.
pause