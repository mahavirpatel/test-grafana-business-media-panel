#!/bin/bash

set -e

# Download videos (original, full length)
wget -O jupiter.mp4 "https://archive.org/download/public-domain-archive/J%C3%BApiter%28720P_HD%29.mp4"
wget -O saturn.mp4 "https://ia801408.us.archive.org/27/items/public-domain-archive/Saturno%28720P_HD%29.mp4"

# Download images
wget -O jupiter.jpg "https://ia601309.us.archive.org/35/items/SPD-SLRSY-342/Jupiter_Detail.jpg"
wget -O saturn.jpg "https://ia801302.us.archive.org/13/items/SPD-SLRSY-2108/PIA01364.jpg"

# Encode all files to base64 (no line wraps)
JUP_IMG_BASE64=$(base64 -w 0 jupiter.jpg)
SAT_IMG_BASE64=$(base64 -w 0 saturn.jpg)
JUP_VID_BASE64=$(base64 -w 0 jupiter.mp4)
SAT_VID_BASE64=$(base64 -w 0 saturn.mp4)

touch init.sql

# Create init.sql
cat <<EOF > init.sql
-- Enable UUID support
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create table
CREATE TABLE media (
  id UUID PRIMARY KEY,
  image BYTEA,
  video BYTEA
);

-- Permissions for all users (for demo/dev purposes)
GRANT SELECT, INSERT, UPDATE, DELETE ON media TO PUBLIC;

-- Insert Jupiter video + image
INSERT INTO media (id, image, video)
VALUES (
  '11111111-1111-4111-8111-111111111111',
  decode('$JUP_IMG_BASE64', 'base64'),
  decode('$JUP_VID_BASE64', 'base64')
);

-- Insert Neptuno video + Saturn image
INSERT INTO media (id, image, video)
VALUES (
  '22222222-2222-4222-8222-222222222222',
  decode('$SAT_IMG_BASE64', 'base64'),
  decode('$SAT_VID_BASE64', 'base64')
);
EOF

echo "init.sql has been generated with full-length videos and images."
