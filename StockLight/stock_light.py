with open("secret.txt", "r") as f:
    secret = f.read().replace("\n", "")

print(secret)
