import sys
import os
import json
import dataclasses
import typing
import inspect

import pydantic
from metaphor_python import Metaphor


API_KEY = os.environ["METAPHOR_API_KEY"]


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


def search(query: str, include_domains: set[str] | None = None):
    """Search the web using metaphor.systems"""
    # TODO: include start published date?
    include_domains = (
        list(include_domains) if include_domains is not None else include_domains
    )
    print(
        json.dumps(
            dataclasses.asdict(
                Metaphor(api_key=API_KEY).search(
                    query=query,
                    num_results=5,
                    include_domains=include_domains,
                    use_autoprompt=True,
                ),
                dict_factory=dict_factory,
            )
        )
    )


def find_similar(url: str, include_domains: set[str] | None = None):
    """Find similar URLs using metaphor.systems"""
    # TODO: include start published date?
    include_domains = (
        list(include_domains) if include_domains is not None else include_domains
    )
    print(
        json.dumps(
            dataclasses.asdict(
                Metaphor(api_key=API_KEY).find_similar(
                    url=url,
                    num_results=5,
                    include_domains=include_domains,
                ),
                dict_factory=dict_factory,
            )
        )
    )


match sys.argv[1:]:  # ignore script name
    case ["search"]:
        search(**json.load(sys.stdin))
    case ["search", "spec"]:
        print(json.dumps(schema(search)))

    case ["find_similar"]:
        find_similar(**json.load(sys.stdin))
    case ["find_similar", "spec"]:
        print(json.dumps(schema(find_similar)))
