#!/usr/bin/env bash

gunicorn -b 0.0.0.0:8080 src.app:app
