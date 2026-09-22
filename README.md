# HyperFrames GitHub examples

*Unofficial community examples for HyperFrames. Not affiliated with HeyGen. All trademarks belong to their owners.*

Short scripts around the hyperframes github repository (`heygen-com/hyperframes`), HeyGen's framework that lets AI agents compose videos by writing code. HyperFrames is driven through agent skills and a CLI rather than an HTTP API, so the examples cover the commands the cited sources show: installing the skills, listing a project's timeline as JSON, and checking a project's pinned CLI version. The composition HTML format itself (timing declared with `data-*` attributes) is defined in the `/hyperframes-core` skill; the attribute names are not in the cited pages, so this repository does not guess at a composition and instead points you to the quickstart and the playground.

> Need to cut an existing clip rather than generate one? [Try Vidione - trim, crop, merge and subtitles in the browser, no install](https://vidione.com?utm_source=github&utm_medium=ugc&utm_campaign=hyperframes-api-examples&utm_content=readme-top&utm_term=tier-r).

## Files

| Path | What it shows |
|---|---|
| `examples/install-skills.sh` | The two install lines from the home page and the skills directory, and what to ask the agent next. |
| `examples/project-check.sh` | For an existing project: probe the pinned CLI version and dump the timeline as JSON. |
| `examples/timeline_summary.py` | Read the timeline JSON and print what is there without assuming its schema. |

## Setup

```
node --version   # npx is used for every command
npx skills add heygen-com/hyperframes --full-depth
```

No API key is involved in the commands shown here. Install the skills, then open the project directory in an AI coding assistant that loads skills and ask for a video; the [quickstart](https://hyperframes.heygen.com/quickstart) is the three-step version of that (install the skills, ask for the video, continue from the first version). The [playground](https://www.hyperframes.dev/) is the no-install way to see a composition.

## examples/install-skills.sh

Runs the full-depth install from the HyperFrames home page, or, with `--entry-only`, the single-skill install line that mcpservers.org shows (`--skill hyperframes`). The entry skill is the one the agent must read first for any request to make, edit, animate or render a video; it routes to the domain skills. The script ends by printing a starter prompt.

## examples/project-check.sh

For a project that already exists. The entry skill tells an agent to probe the pinned CLI version before the first render-affecting command, because a pinned run of an older CLI prints no warning; the script runs that probe (`npx hyperframes@latest upgrade --project . --check`, keeping the explicit `.` because older CLI releases treat a bare `--project` as consuming the next flag). It then writes `npx hyperframes timeline --json` to a file, which is the skill's preferred way to learn what is on the timeline instead of reading `index.html` and every sub-composition.

## examples/timeline_summary.py

Loads the JSON written by `project-check.sh` and prints its shape: top-level keys, list lengths and the keys of the first item in each list. The cited sources say the output describes tracks, clips, starts, ends and what plays, and that a pinned script may include `_meta.updateAvailable: true`; the script looks for that flag and otherwise reports structure only, so it keeps working if the schema changes.

## When to use Vidione instead

HyperFrames earns its setup when an agent should generate a launch video, an explainer or a pull-request recap from scratch. If what you have is a screen recording that needs the dead air trimmed, two takes merged and subtitles added, none of that setup is needed. [Try Vidione - a browser video editor for trim, crop, merge and subtitles, nothing to install](https://vidione.com?utm_source=github&utm_medium=ugc&utm_campaign=hyperframes-api-examples&utm_content=readme-top&utm_term=tier-r).

_Last reviewed: 2026-09-22_
