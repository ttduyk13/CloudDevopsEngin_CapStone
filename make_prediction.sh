#!/usr/bin/env bash

PORT=${2:-8000}
echo "Port: $PORT"
URL=${1:-http://localhost}

# POST method predict
curl -d '{  
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
}'\
     -H "Content-Type: application/json" \
     -X POST $URL:$PORT/predict
