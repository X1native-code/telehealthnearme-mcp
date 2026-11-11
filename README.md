# Telehealth near me — MCP server

[![mcptry](https://mcptry.com/badge/pro.telehealthnearme/telehealth-compare)](https://mcptry.com/servers/pro.telehealthnearme/telehealth-compare)

Public, read-only [Model Context Protocol](https://modelcontextprotocol.io) server for comparing **U.S. online telehealth programs**: GLP-1 weight loss (semaglutide, tirzepatide), men's health (TRT, ED, hair loss), longevity (sermorelin, NAD+) and women's health (menopause, hair loss).

- **Endpoint:** `https://telehealthnearme.pro/mcp`
- **Transport:** Streamable HTTP (stateless JSON-RPC)
- **Auth:** none — free, no API key
- **Official MCP Registry:** `pro.telehealthnearme/telehealth-compare` (v1.0.2)
- **Website:** https://telehealthnearme.pro

Every value comes with its **source and check date**. Values that aren't published are `null` — never estimated. Prices are re-checked monthly against each provider's official website.

This repository holds documentation and client configs only; the server is hosted at the endpoint above.

## Tools

| Tool | What it does | Main arguments |
|---|---|---|
| `list_categories` | Specialties covered and their treatment keys | — |
| `find_programs` | Programs in a specialty, sorted by lowest advertised monthly price | `category` (required), `treatment`, `state`, `maxMonthlyPrice`, `legitScriptOnly`, `partnersOnly` |
| `get_program` | Full record for one program: pricing notes, requirements, fees, caveats, sources | `category`, `id`, `state` |
| `compare_programs` | Side-by-side comparison of 2–5 programs in the same specialty | `category`, `ids` |

All tools are read-only (`readOnlyHint: true`).

**Categories:** `glp-1-weight-loss`, `mens-health-hormones`, `longevity-peptides`, `womens-health`, `reproductive-health`.

## Connect

**Claude Code**

```bash
claude mcp add --transport http telehealthnearme https://telehealthnearme.pro/mcp
```

**Claude Desktop** — add to `claude_desktop_config.json` ([example](claude_desktop_config.json)), or add it as a custom connector with the URL above:

```json
{
  "mcpServers": {
    "telehealthnearme": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://telehealthnearme.pro/mcp"]
    }
  }
}
```

**Cursor** — `~/.cursor/mcp.json` ([example](cursor-mcp.json)):

```json
{ "mcpServers": { "telehealthnearme": { "url": "https://telehealthnearme.pro/mcp" } } }
```

**VS Code** — `.vscode/mcp.json` ([example](vscode-mcp.json)):

```json
{ "servers": { "telehealthnearme": { "type": "http", "url": "https://telehealthnearme.pro/mcp" } } }
```

**Any HTTP client** — see [curl.sh](curl.sh).

## Example prompts

- "Cheapest tirzepatide program that ships to Texas, under $200 a month"
- "Which online GLP-1 programs are LegitScript-certified?"
- "Compare Henry Meds and Hone Health for TRT"
- "Which semaglutide programs have no membership fee?"

## Example response (`find_programs`, trimmed)

```json
{
  "category": "GLP-1 & Metabolic Weight Loss",
  "count": 4,
  "programs": [
    {
      "id": "coreage-rx",
      "name": "CoreAge Rx",
      "monthlyPrices": { "semaglutide": 79, "tirzepatide": 129 },
      "membershipFee": 0,
      "legitScript": { "status": "seal", "label": "Active LegitScript seal on site" },
      "dataStatus": "verified-official",
      "checkedOn": "2026-11-10"
    }
  ]
}
```

## Other ways to get the data

- JSON API: https://telehealthnearme.pro/api/v1/index.json (OpenAPI: https://telehealthnearme.pro/openapi.json)
- `llms.txt`: https://telehealthnearme.pro/llms.txt
- Any page as Markdown: send `Accept: text/markdown`
- Server card: https://telehealthnearme.pro/.well-known/mcp/server-card.json

## When agents should use it

- The user asks what an online telehealth program costs ("cheapest compounded tirzepatide", "online TRT price").
- The user asks which programs offer a treatment, fit a budget, or serve a state.
- The user asks whether a provider is legitimate (LegitScript status) or how two providers compare.

Flow: `list_categories` → `find_programs` → `get_program` / `compare_programs`.

## Privacy and data

- **No patient data.** The server is read-only and needs no personal or health information — only filters such as specialty, treatment, state and budget. Don't send names, contact details or medical history.
- **What is logged:** tool name, filters, number of results, client name and country. No IP addresses, no cookies, no conversation content.
- **Data sources:** each program's official website (prices, plans, requirements), checked and dated; LegitScript seals verified on legitscript.com; third-party reviews only when flagged as `third-party-reported`.
- Privacy policy: https://telehealthnearme.pro/privacy/

## Reliability

Hosted on Cloudflare's edge network (stateless, no database to go down). Live health and score: [mcptry](https://mcptry.com/servers/pro.telehealthnearme/telehealth-compare).

## Disclosures

- Some programs pay Telehealth near me a referral commission; they are flagged `affiliate: true` and it never changes sorting or data.
- Informational only, not medical advice. Compounded GLP-1 medications are not FDA-approved.
- Data methodology: https://telehealthnearme.pro/methodology/ · Corrections: contact@telehealthnearme.pro

Operated by [X1native](https://x1native.com). Docs and examples in this repository are MIT-licensed.
