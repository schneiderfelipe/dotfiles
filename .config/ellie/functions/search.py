import os

import metaphor_python
from langchain.agents import AgentExecutor
from langchain.agents import OpenAIFunctionsAgent
from langchain.agents import tool
from langchain.chat_models import ChatOpenAI
from langchain.schema import SystemMessage


NUM_RESULTS = 5


metaphor_client = metaphor_python.Metaphor(api_key=os.environ["METAPHOR_API_KEY"])


@tool
def search(query: str) -> metaphor_python.SearchResponse:
    """Query a web search engine."""
    return metaphor_client.search(query, num_results=NUM_RESULTS, use_autoprompt=True)


@tool
def find_similar(url: str) -> metaphor_python.SearchResponse:
    """Get web search results similar to a given URL."""
    response = metaphor_client.find_similar(url, num_results=NUM_RESULTS + 1)
    response.results = [result for result in response.results if result.url != url]
    return response


@tool
def get_contents(ids: list[str]) -> metaphor_python.GetContentsResponse:
    """
    Get the contents of webpages.

    The IDs passed in should be a list of IDs as fetched from `search` or `find_similar`.
    """  # noqa: E501
    return metaphor_client.get_contents(ids)


def main(query: str):
    llm = ChatOpenAI(temperature=0)
    tools = [search, find_similar, get_contents]

    system_message = SystemMessage(
        content="You are a web researcher who uses search engines to look up information. "  # noqa: E501
        "You answer the user's queries based on credible information you find online."
    )
    prompt = OpenAIFunctionsAgent.create_prompt(system_message)

    agent = OpenAIFunctionsAgent(llm=llm, tools=tools, prompt=prompt)
    agent_executor = AgentExecutor.from_agent_and_tools(agent, tools, verbose=True)

    response = agent_executor.run(query)
    print(response)


if __name__ == "__main__":
    main("How to read energies using the cclib library?")
