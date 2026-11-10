#!/bin/sh
# Call the server directly (JSON-RPC over Streamable HTTP, no auth).
curl -s -X POST https://telehealthnearme.pro/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"find_programs","arguments":{"category":"glp-1-weight-loss","treatment":"tirzepatide","state":"TX","maxMonthlyPrice":200}}}'
