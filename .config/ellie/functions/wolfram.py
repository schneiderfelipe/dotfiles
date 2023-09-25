import sys
import json
import os

import requests

appid = os.environ["WOLFRAM_ALPHA_APPID"]


def wolfram_alpha(input: str, appid: str = appid) -> str:
    headers = {"Authorization": f"Bearer {appid}"}
    # TODO: there are other parameters available, check them out: https://products.wolframalpha.com/llm-api/documentation
    params = {"input": input}
    endpoint = "https://www.wolframalpha.com/api/v1/llm-api"
    return requests.get(endpoint, params=params, headers=headers).text


match sys.argv[1:]:  # ignore script name
    case []:
        kwargs = {"appid": appid, **json.load(sys.stdin)}
        output = wolfram_alpha(**kwargs)
        print(output)
    case ["spec"]:
        print(
            json.dumps(
                {
                    "name": "wolfram",
                    "description": "Access expert-level computation, math, "
                    "curated knowledge, answers & real-time data through "
                    "Wolfram|Alpha and Wolfram Language",
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
