#!/usr/bin/env bash

PORT=${2:-8000}
URL=${1:-http://localhost}
ENDPOINT="$URL:$PORT"

curl --location \
     --request POST "$ENDPOINT/predict" \
     --header 'Content-Type: application/json' \
     --data-raw '{  
                  "CHAS":{  
                     "0":1
                  },
                  "RM":{  
                     "0":6.6
                  },
                  "TAX":{  
                     "0":300.0
                  },
                  "PTRATIO":{  
                     "0":15.3
                  },
                  "B":{  
                     "0":396.9
                  },
                  "LSTAT":{  
                     "0":4.98
                  }
               }' \
      -w '%{http_code}\n' -s 