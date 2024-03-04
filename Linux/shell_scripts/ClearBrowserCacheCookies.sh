#!/bin/bash

# Limpa cache e cookies do Firefox
echo "Limpando cache e cookies do Firefox..."
find ~/.mozilla/firefox/*.default*/ -name "cookies.sqlite" -delete
find ~/.mozilla/firefox/*.default*/ -name "cache2" -type d -exec rm -rf {} +

# Limpa cache e cookies do Google Chrome/Chromium
echo "Limpando cache e cookies do Google Chrome/Chromium..."
find ~/.config/google-chrome/Default/ -name "Cookies" -delete
find ~/.config/google-chrome/Default/ -name "Cache" -type d -exec rm -rf {} +
find ~/.config/chromium/Default/ -name "Cookies" -delete
find ~/.config/chromium/Default/ -name "Cache" -type d -exec rm -rf {} +

echo "Limpeza concluída."
