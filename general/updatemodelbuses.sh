#!/bin/bash
cd ~/discord/DiscordMusic/
echo "ModelBuses Update Automator"
git pull
yarn install
pm2 restart 6
echo "Updated"
