import requests

for c in list(range(ord("あ"), ord("ん") + 1)) + list(range(ord("ア"), ord("ン") + 1)):
    res = requests.get(
        "https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search",
        params={
            "q": "",
            "targets": "tags",
            "filters[tagsExact][0]": chr(c),
            "_sort": "-viewCounter",
        },
    )
    print(res.json()["meta"]["totalCount"], chr(c))
