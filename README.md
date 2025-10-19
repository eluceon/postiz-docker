# Postiz Self-Hosted with Docker Compose

This repository provides a Docker Compose setup for deploying [Postiz](https://github.com/gitroomhq/postiz-app), an open-source social media management platform supporting YouTube, Instagram, and many other platforms.

## Features

- Easy self-hosted deployment with Docker Compose
- Includes Postiz app, PostgreSQL database, and Redis cache
- Supports local storage for configs and uploads
- Secure JWT authentication and configurable environment variables
- Healthchecks for all services
- Backup script included for database and volumes

## Getting Started

### 1. Clone the repository
`git clone git@github.com:eluceon/postiz-docker.git`
`cd postiz-docker`

### 2. Configure environment variables (.env)

### 3. Start the services
`docker compose up -d`

### 4. Access Postiz frontend at your specified domain.

### 5. Automated Backups
#### Make backup script executable
`chmod +x backup-postiz.sh`

#### Setup cron job
`crontab -e`
##### Add this line for daily backups:
`0 4 * * * /root/backup-postiz.sh >> /var/log/postiz-backup.log 2>&1`
