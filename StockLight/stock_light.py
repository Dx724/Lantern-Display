import requests
import json
from collections import OrderedDict

with open("secret.txt", "r") as f:
    secret = f.read().replace("\n", "")

print(secret)

TICKER = "GME"

req = requests.get("https://www.alphavantage.co/query", {
        "function": "TIME_SERIES_INTRADAY", "symbol": TICKER, "apikey": secret,
        "interval": "1min", "outputsize": "compact", "datatype": "json"
    })

if (req.status_code != 200):
    print("Request error: {}".format(req.status_code))
else:
    # Note that while dictionaries are ordered in Python 3.7+, this is
    # simply an implementation detail. Thus, use OrderedDict to ensure
    # compatibility with past and future versions.
    response = req.json(object_pairs_hook=OrderedDict)

    #Obtain most recent price from time series
    price = next(iter(response["Time Series (1min)"].items()))[1]["4. close"]
    pr = float(price)
    print(response)
