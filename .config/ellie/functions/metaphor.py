import dataclasses
import typing
import inspect
import json
import os
import sys

import pydantic
from metaphor_python import Metaphor

api_key = os.environ["METAPHOR_API_KEY"]


def schema(function):
    def get_fields(f) -> dict[str, tuple]:
        def get_field(parameter: inspect.Parameter) -> tuple:
            assert (
                parameter.annotation is not inspect.Parameter.empty
            ), f"parameter '{parameter}' lacks type annotation"
            return (
                parameter.annotation,
                ...
                if parameter.default is inspect.Parameter.empty
                else parameter.default,
            )

        return {
            name: get_field(parameter)
            for name, parameter in inspect.signature(f).parameters.items()
        }

    K = typing.TypeVar("K")
    V = typing.TypeVar("V")

    def remove_keys(data: dict[K, V], keys: list[K]) -> dict[K, V]:
        return {
            key: remove_keys(value, keys) if isinstance(value, dict) else value
            for key, value in data.items()
            if key not in keys
        }

    name = function.__name__
    assert name, "function lacks a name"
    assert len(name) > 1, f"{name} name is too short"

    description = inspect.getdoc(function).strip()
    assert description, f"{name} lacks documentation"

    fields = get_fields(function)
    model = pydantic.create_model(name, **fields)
    schema = model.schema()
    parameters = remove_keys(schema, ["title"])
    assert parameters, f"{name} lacks parameters"
    assert "type" in parameters, f"{name} parameters lack type"
    assert "properties" in parameters, f"{name} parameters lack properties"

    return dict(name=name, description=description, parameters=parameters)


def dict_factory(data: dict) -> dict:
    def include_pair(pair: tuple):
        key, value = pair
        return key != "id" and value is not None and not isinstance(value, Metaphor)

    return dict(pair for pair in data if include_pair(pair))


match sys.argv[1:]:  # ignore script name
    case ["search"]:
        metaphor = Metaphor(api_key=api_key)

        kwargs = json.load(sys.stdin)
        # TODO: use update for defaults, see wolfram
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
                    "description": "Search the web using metaphor.systems",
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
