import sys
import json
import os

import requests

appid = os.environ["WOLFRAM_ALPHA_APPID"]


def wolfram_alpha(input, appid=appid):
    endpoint = "https://www.wolframalpha.com/api/v1/llm-api"
    headers = {"Authorization": f"Bearer {appid}"}
    # TODO: there are other parameters available, check them out: https://products.wolframalpha.com/llm-api/documentation
    params = {"input": input}
    return requests.get(endpoint, headers=headers, params=params).text


match sys.argv[1:]:  # ignore script name
    case []:
        kwargs = {"appid": appid, **json.load(sys.stdin)}
        output = wolfram_alpha(**kwargs)
        print(output)
    case ["spec"]:
        print(
            json.dumps(
                {
                    "name": "compute",
                    "description": "Compute expert-level answers using WolframAlpha",
                    "parameters": {
                        "type": "object",
                        "required": ["input"],
                        "properties": {
                            "input": {
                                "type": "string",
                            },
                        },
                    },
                },
                separators=(",", ":"),
            )
        )
