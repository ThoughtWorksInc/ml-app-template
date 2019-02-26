#!/bin/bash

# Use PORT environment variable if defined. Otherwise, default to 8080
PORT="${PORT:-8080}"

gunicorn -b 0.0.0.0:$PORT src.app:app
