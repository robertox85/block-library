#!/bin/bash

# Nome del plugin e del blocco
PLUGIN_NAME="block-library"
PATTERN_NAME="$1"
PATTERN_TITLE="$PATTERN_NAME"
# Controllo che il nome del blocco sia stato fornito
if [ -z "$PATTERN_NAME" ]; then
    echo "Devi fornire il nome del blocco come argomento dello script."
    exit 1
fi

# Converto il nome del blocco in nome-blocco se ci sono spazi, usa Slug come riferimento
PATTERN_NAME=$(echo "$PATTERN_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

# Controllo che il blocco esista, e in caso lo elimino
if [ -d "patterns/$PATTERN_NAME" ]; then
    rm -rf "patterns/$PATTERN_NAME"
    echo "Il blocco $PATTERN_NAME è stato eliminato."
    exit 0
else
    echo "Il blocco $PATTERN_NAME non esiste."
    exit 1
fi
