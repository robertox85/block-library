#!/bin/bash

# Nome del plugin e del blocco
PLUGIN_NAME="block-library"
BLOCK_NAME="$1"
BLOCK_TITLE="$BLOCK_NAME"
# Controllo che il nome del blocco sia stato fornito
if [ -z "$BLOCK_NAME" ]; then
    echo "Devi fornire il nome del blocco come argomento dello script."
    exit 1
fi

# Converto il nome del blocco in nome-blocco se ci sono spazi, usa Slug come riferimento
BLOCK_NAME=$(echo "$BLOCK_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')


# Controllo che il blocco esista, e in caso lo elimino
if [ -d "blocks/$BLOCK_NAME" ]; then
    rm -rf "blocks/$BLOCK_NAME"
    # Rimuovo da packages.json le stringhe di build e start, create in precedenza da questo script:
    # jq --arg BLOCK_NAME "$BLOCK_NAME" \
    # '.scripts |= .+ {
    #     "start:\($BLOCK_NAME)": "wp-scripts start blocks/\($BLOCK_NAME)/src/index.js --output-path=blocks/\($BLOCK_NAME)/build/ && cd blocks/\($BLOCK_NAME) && node ../../copy-json.js \($BLOCK_NAME)",
    #     "build:\($BLOCK_NAME)": "wp-scripts build blocks/\($BLOCK_NAME)/src/index.js --output-path=blocks/\($BLOCK_NAME)/build/ && cd blocks/\($BLOCK_NAME) && node ../../copy-json.js \($BLOCK_NAME)"
    # }' "package.json" > "package.tmp.json" && mv "package.tmp.json" "package.json"

    # Rimuovo da package.json le stringhe di build e start, create in precedenza da questo script:
    jq --arg BLOCK_NAME "$BLOCK_NAME" \
    'del(.scripts["start:\($BLOCK_NAME)"])' "package.json" > "package.tmp.json" && mv "package.tmp.json" "package.json"
    jq --arg BLOCK_NAME "$BLOCK_NAME" \
    'del(.scripts["build:\($BLOCK_NAME)"])' "package.json" > "package.tmp.json" && mv "package.tmp.json" "package.json"

    
    echo "Il blocco $BLOCK_NAME è stato eliminato."
    exit 0
else
    echo "Il blocco $BLOCK_NAME non esiste."
    exit 1
fi