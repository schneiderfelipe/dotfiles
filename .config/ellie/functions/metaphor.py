import sys
import json
import os
import dataclasses

from metaphor_python import Metaphor

api_key = os.environ["METAPHOR_API_KEY"]


def dict_factory(data):
    def include_pair(pair):
        key, value = pair
        return key != "id" and value is not None and not isinstance(value, Metaphor)

    return dict(pair for pair in data if include_pair(pair))


match sys.argv[1:]:  # ignore script name
    case ["search"]:
        metaphor = Metaphor(api_key=api_key)

        kwargs = json.load(sys.stdin)
        # TODO: use update for defaults, see wolframalpha
        if "use_autoprompt" not in kwargs:
            kwargs["use_autoprompt"] = True
        response = metaphor.search(**kwargs)

        data = dataclasses.asdict(response, dict_factory=dict_factory)
        # TODO: log data.autoprompt_string
        # print(data["autoprompt_string"])

        for result in data["results"]:
            print(json.dumps(result, separators=(",", ":")))
    case ["find_similar"]:
        metaphor = Metaphor(api_key=api_key)

        kwargs = json.load(sys.stdin)
        response = metaphor.find_similar(**kwargs)

        data = dataclasses.asdict(response, dict_factory=dict_factory)

        for result in data["results"]:
            print(json.dumps(result, separators=(",", ":")))
    case ["search", "spec"]:
        print(
            json.dumps(
                {
                    "name": "search",
                    "description": "Search web queries using metaphor.systems",
                    "parameters": {
                        "type": "object",
                        "required": ["query"],
                        "properties": {
                            "query": {
                                "type": "string",
                            },
                            "include_domains": {
                                "type": "array",
                                "items": {"type": "string"},
                                "uniqueItems": True,
                            },
                            # TODO: include start published date?
                        },
                    },
                },
                separators=(",", ":"),
            )
        )
        # TODO: improve error messages when spec is malformed.
        # The bare minimum is name, parameters, parameters>type, parameters>properties}
    case ["find_similar", "spec"]:
        print(
            json.dumps(
                {
                    "name": "find_similar",
                    "description": "Find similar URLs using metaphor.systems",
                    "parameters": {
                        "type": "object",
                        "required": ["url"],
                        "properties": {
                            "url": {
                                "type": "string",
                            },
                            "include_domains": {
                                "type": "array",
                                "items": {"type": "string"},
                                "uniqueItems": True,
                            },
                            # TODO: include start published date?
                        },
                    },
                },
                separators=(",", ":"),
            )
        )
