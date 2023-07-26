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

# Controllo che il blocco non esista già
if [ -d "patterns/$PATTERN_NAME" ]; then
    echo "Il pattern $PATTERN_NAME esiste già."
    exit 1
fi



# Crea la directory del blocco
mkdir -p "patterns/$PATTERN_NAME"

# Create an index.php file in the new directory
cat > "patterns/$PATTERN_NAME/index.php" <<EOF
<?php
// Pattern properties
return [
    'title' => 'Pattern Title',
    'content' => 'Pattern Content',
    'categories' => array( 'block-library' ),
];
EOF

echo "Il pattern $PATTERN_NAME è stato creato."