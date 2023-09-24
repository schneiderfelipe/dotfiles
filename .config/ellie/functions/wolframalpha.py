import sys
import json
import os

import requests

appid = os.environ["WOLFRAM_ALPHA_APPID"]


def wolframalpha(input, appid=appid):
    endpoint = "https://www.wolframalpha.com/api/v1/llm-api"
    headers = {"Authorization": f"Bearer {appid}"}
    # TODO: there are other parameters available, check them out: https://products.wolframalpha.com/llm-api/documentation
    params = {"input": input}
    return requests.get(endpoint, headers=headers, params=params).text


match sys.argv[1:]:  # ignore script name
    case []:
        kwargs = {"appid": appid, **json.load(sys.stdin)}
        output = wolframalpha(**kwargs)
        print(output)
    case ["spec"]:
        print(
            json.dumps(
                {
                    "name": "wolframalpha",
                    "description": "Understand natural language queries about various subjects, perform mathematical calculations and conversions, and obtain up-to-date data",  # noqa: E501
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
