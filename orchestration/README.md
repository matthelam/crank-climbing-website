# orchestration/

Pattern A substrate — **LangGraph orchestrates, Claude Code executes**.

Home for committed LangGraph graph definitions and the Crank agent roster (cognitive profiles per altitude band and concern lens). Running graph state — tokens, model calls, intermediate conversation — lives in LangGraph's persistence layer, not here.

| Subdirectory *(to materialise)* | Contains |
|---|---|
| `graphs/` | LangGraph state-machine definitions. First target: the extraction-ceremony graph that promotes Tier 2 Insights into Tier 3 intent artifacts. |
| `profiles/` | Crank's cognitive profile roster — authored in the 12-dimension language, compiled down to LangGraph node configs by the sibling Cognitive Profile Compiler repository. |

Claude Code skills, agents, and commands are execution surfaces and live under [`.claude/`](../.claude/) — not here. Don't put orchestration logic (verification gates, approval flow, extraction routing) into a skill; it belongs in a LangGraph node.

## Node system prompts route to `docs/agents/`

When authoring a LangGraph node's system prompt, **do not duplicate repo-wide agent conventions**. Reference [`docs/agents/`](../docs/agents/) by path inside the prompt template and let the node pick up session-start, tool dispatch, context compaction, ambiguity protocol, citation, and lock-once discipline from the canonical source. The node's own prompt carries only task-specific instructions — role, inputs, expected outputs, profile overrides from the Cognitive Profile Compiler.
