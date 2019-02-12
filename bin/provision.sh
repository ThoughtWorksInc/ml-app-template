#!/usr/bin/env bash

app_name='simple-cd-demo'

heroku login
heroku create $app_name