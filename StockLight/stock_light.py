import requests, time, board, time, neopixel, math

# Load API key from file
with open("secret.txt", "r") as f:
    secret = f.read().replace("\n", "")

# Initialize lights
pixels = neopixel.NeoPixel(board.D18, 8, brightness=1.0)

TICKER = "GME"
last_price = -1
price = -1

BLUE_ALL = [(65, 50, 225)] * 8
OFF_ALL = [(0, 0, 0)] * 8
COLOR_VALS = [235, 215, 195, 175]
COLOR_BLUE = [0, 15, 55, 90]

def pct_to_disp(last, current):
    pct = current / last
    return min(math.ceil(abs(pct-1.0)*100),4)*(1 if pct > 1 else -1)

def get_color_for_code(code):
    # Red for loss, green for gain
    return (0 if code > 0 else COLOR_VALS[abs(code)-1],
         0 if code < 0 else COLOR_VALS[abs(code)-1],
         COLOR_BLUE[abs(code)-1])

def do_set_lights(color_arr):
    for i in range(8):
        pixels[i] = color_arr[i]

def set_lights(disp_code):
    if (disp_code == 0):
        do_set_lights(BLUE_ALL)
    else:
        c_arr = OFF_ALL[:] # Copy blank to modify
        for i in range(abs(disp_code)):
            j = i + 4 if disp_code > 0 else 3 - i
            c_arr[j] = get_color_for_code(i+1 if disp_code > 0 else -i-1)
        print(c_arr)
        do_set_lights(c_arr)

'''
req = requests.get("https://www.alphavantage.co/query", {
        "function": "GLOBAL_QUOTE", "symbol": TICKER, "apikey": secret
    })
'''

'''
        "function": "TIME_SERIES_INTRADAY", "symbol": TICKER, "apikey": secret,
        "interval": "1min", "outputsize": "compact", "datatype": "json"
'''

def check_price():
    req = requests.get("https://www.alphavantage.co/query", {
            "function": "CURRENCY_EXCHANGE_RATE", "apikey": secret,
            "from_currency": "BTC", "to_currency": "USD"
        })

    if (req.status_code != 200):
        print("Request error: {}".format(req.status_code))
        return -1
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
        return pr

# Wait for Wi-Fi connection
do_set_lights([(255, 255, 0)] * 8)
while True:
    try:
        r = requests.head("https://www.alphavantage.co", timeout=5)
        break
    except requests.ConnectionError as ex:
        pass

set_lights(0) # Blue loading state
price = check_price()
while True:
    last_price = price
    time.sleep(65) # API takes ~1 minute to update, so wait slightly longer
    price = check_price()
    if price < 0 or last_price < 0:
        set_lights(0)
    else:
        set_lights(pct_to_disp(last_price, price))
