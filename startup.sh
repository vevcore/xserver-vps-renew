#!/bin/bash

docker compose up -d && docker logs --tail=100 -f xserver-vps-renew-engine
