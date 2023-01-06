import requests
import os

def get(url, token):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.get(url, headers=headers)
    return response

def patch(url, token, body):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.patch(url, headers=headers, json=body)
    return response

CF_BUNDLE_VERSION = os.environ['CF_BUNDLE_VERSION']
JWT_TOKEN = os.environ['JWT_TOKEN']
MESSAGE = os.environ['MESSAGE']

buildsResponse = get("https://api.appstoreconnect.apple.com/v1/builds?filter[version]={}".format(CF_BUNDLE_VERSION), JWT_TOKEN)
targetBetaBuildLink = buildsResponse.json()["data"][0]["relationships"]["betaBuildLocalizations"]["links"]["related"]

betaBuildResponse = get(targetBetaBuildLink, JWT_TOKEN)
if betaBuildResponse.status_code != 200:
    print(cloudProductsResponse.status_code)
    exit()

betaBuildData = betaBuildResponse.json()["data"]
if betaBuildData == []:
    print("Error: ビルド情報が空です。正しいビルドバージョンを入れてください。")
    exit()

betaBuildTargetLocaleId = [x for x in betaBuildData if x["attributes"]["locale"] == "ja"][0]["id"]

patchLocaleData = {
    "data": {
        "attributes": {
            "whatsNew": MESSAGE
        },
        "id": betaBuildTargetLocaleId,
        "type": "betaBuildLocalizations"
    }
}
patchLocaleResponse = patch("https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/{}".format(betaBuildTargetLocaleId), JWT_TOKEN, patchLocaleData)

print(patchLocaleResponse)
