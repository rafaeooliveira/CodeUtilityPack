@echo off
title Limpeza de Cache e Cookies dos Navegadores

:: Fechar os navegadores
taskkill /F /IM chrome.exe /T
taskkill /F /IM firefox.exe /T
taskkill /F /IM msedge.exe /T

:: Limpar cache e cookies do Google Chrome
del /q /s /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*"
del /q /s /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\cookies*"

:: Limpar cache e cookies do Mozilla Firefox
:: O Firefox armazena dados em perfis diferentes, então é necessário identificar o perfil correto
for /d %%p in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    del /q /s /f "%%p\cache2\*"
    del /q /s /f "%%p\cookies.sqlite"
    del /q /s /f "%%p\webappsstore.sqlite"
)

:: Limpar cache e cookies do Microsoft Edge
del /q /s /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*"
del /q /s /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\cookies*"

echo Limpeza concluída.
pause
