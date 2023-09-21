import sys
import json
import os
from metaphor_python import Metaphor
import dataclasses

api_key = os.environ["METAPHOR_API_KEY"]

def dict_factory(data):
    def include_pair(pair):
        key, value = pair
        return key != "id" and \
            value is not None and \
            not isinstance(value, Metaphor)
    return dict(pair for pair in data if include_pair(pair))


match sys.argv[1:]:  # ignore script name
    case ["search"]:
        metaphor = Metaphor(api_key=api_key)

        kwargs = json.load(sys.stdin)
        if "use_autoprompt" not in kwargs:
            kwargs["use_autoprompt"] = True
        response = metaphor.search(**kwargs)

        data = dataclasses.asdict(response, dict_factory=dict_factory)
        # TODO: log data.autoprompt_string
        # print(data["autoprompt_string"])

        for result in data["results"]:
            print(json.dumps(result, separators=(',', ':')))
    case ["search", "spec"]:
        # TODO: some interesting options suppressed,
        # include domains is particularly useful (e.g. "find me youtube videos")
        print(
            json.dumps(
                {
                    "name": "search",
                    "description": "Search the web using metaphor.systems",
                    "parameters": {
                        "type": "object",
                        "required": ["query"],
                        "properties": {
                            "query": {
                                "type": "string",
                            },
                        },
                    },
                },
                separators=(',', ':')
            )
        )
        # TODO: improve error messages when spec is malformed.
        # The bare minimum is name, parameters, parameters>type, parameters>properties}
