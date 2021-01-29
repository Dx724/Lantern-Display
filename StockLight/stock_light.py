import requests

with open("secret.txt", "r") as f:
    secret = f.read().replace("\n", "")

TICKER = "GME"
'''
req = requests.get("https://www.alphavantage.co/query", {
        "function": "GLOBAL_QUOTE", "symbol": TICKER, "apikey": secret
    })
'''

'''
        "function": "TIME_SERIES_INTRADAY", "symbol": TICKER, "apikey": secret,
        "interval": "1min", "outputsize": "compact", "datatype": "json"
'''
req = requests.get("https://www.alphavantage.co/query", {
        "function": "CURRENCY_EXCHANGE_RATE", "apikey": secret,
        "from_currency": "BTC", "to_currency": "USD"
    })

if (req.status_code != 200):
    print("Request error: {}".format(req.status_code))
else:
    response = req.json()
    #price = response["Global Quote"]["05. price"]
    '''
    # Note that while dictionaries are ordered in Python 3.7+, this is
    # simply an implementation detail. Thus, use OrderedDict to ensure
    # compatibility with past and future versions.
    response = req.json(object_pairs_hook=OrderedDict)

    #Obtain most recent price from time series
    price = next(iter(response["Time Series (1min)"].items()))[1]["4. close"]
    '''
    price = response["Realtime Currency Exchange Rate"]["5. Exchange Rate"]
    pr = float(price)
    print(pr)
