#!/usr/bin/env bash
set -e

curl --request POST http://localhost:8080/predict \
     --header "Content-Type: application/json" \
     --data \
              '{ 
                "AGE": 65.2,
                "B": 396.9,
                "CHAS": 0,
                "CRIM": 0.00632,
                "DIS": 4.09,
                "INDUS": 2.31,
                "LSTAT": 4.98,
                "NOX": 0.538,
                "PTRATIO": 15.3,
                "RAD": 1.0,
                "RM": 6.575,
                "TAX": 296,
                "ZN": 18 
              }'