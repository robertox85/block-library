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

# Controllo che il blocco non esista già
if [ -d "blocks/$BLOCK_NAME" ]; then
    echo "Il blocco $BLOCK_NAME esiste già."
    exit 1
fi



# Crea la directory del blocco
mkdir -p "blocks/$BLOCK_NAME/src"

# Crea il file block.json del blocco
cat > "blocks/$BLOCK_NAME/src/block.json" << EOF
{
    "\$schema": "https://schemas.wp.org/trunk/block.json",
    "apiVersion": 3,
    "name": "$PLUGIN_NAME/$BLOCK_NAME",
    "version": "0.1.0",
    "title": "$BLOCK_TITLE",
    "category": "block-library",
    "description": "$BLOCK_TITLE block.",
    "textdomain": "$PLUGIN_NAME",
    "editorScript": "file:./index.js",
    "editorStyle": "file:./index.css",
    "style": "file:./style-index.css"
}

EOF

# Crea il file edit.js del blocco
cat << EOF > "blocks/$BLOCK_NAME/src/edit.js"
/**
 * Retrieves the translation of text.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/packages/packages-i18n/
 */
import { __ } from '@wordpress/i18n';

/**
 * React hook that is used to mark the block wrapper element.
 * It provides all the necessary props like the class name.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/packages/packages-block-editor/#useblockprops
 */
import { useBlockProps } from '@wordpress/block-editor';

/**
 * Lets webpack process CSS, SASS or SCSS files referenced in JavaScript files.
 * Those files can contain any CSS code that gets applied to the editor.
 *
 * @see https://www.npmjs.com/package/@wordpress/scripts#using-css
 */
import './editor.scss';

/**
 * The edit function describes the structure of your block in the context of the
 * editor. This represents what the editor will render when the block is used.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/block-api/block-edit-save/#edit
 *
 * @return {WPElement} Element to render.
 */
export default function Edit() {
    return (
        <p { ...useBlockProps() }>
            { __(
                '$BLOCK_TITLE – hello from the editor!',
                '$PLUGIN_NAME'
            ) }
        </p>
    );
}
EOF

# Crea il file save.js del blocco
cat << EOF > "blocks/$BLOCK_NAME/src/save.js"
/**
 * React hook that is used to mark the block wrapper element.
 * It provides all the necessary props like the class name.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/packages/packages-block-editor/#useblockprops
 */
import { useBlockProps } from '@wordpress/block-editor';

/**
 * The save function defines the way in which the different attributes should
 * be combined into the final markup, which is then serialized by the block
 * editor into \`post_content\`.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/block-api/block-edit-save/#save
 *
 * @return {WPElement} Element to render.
 */
export default function save() {
    return (
        <p { ...useBlockProps.save() }>
            { '$BLOCK_TITLE – hello from the saved content!' }
        </p>
    );
}
EOF

# Crea il file index.js del blocco
cat << EOF > "blocks/$BLOCK_NAME/src/index.js"
/**
 * Registers a new block provided a unique name and an object defining its behavior.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/block-api/block-registration/
 */
import { registerBlockType } from '@wordpress/blocks';

/**
 * Lets webpack process CSS, SASS or SCSS files referenced in JavaScript files.
 * All files containing \`style\` keyword are bundled together. The code used
 * gets applied both to the front of your site and to the editor.
 *
 * @see https://www.npmjs.com/package/@wordpress/scripts#using-css
 */
import './style.scss';

/**
 * Internal dependencies
 */
import Edit from './edit';
import save from './save';
import metadata from './block.json';

/**
 * Every block starts by registering a new block type definition.
 *
 * @see https://developer.wordpress.org/block-editor/reference-guides/block-api/block-registration/
 */
registerBlockType( metadata.name, {
    /**
     * @see ./edit.js
     */
    edit: Edit,

    /**
     * @see ./save.js
     */
    save,
} );
EOF

# Crea il file style.scss del blocco
echo ".wp-block-block-library-block-$BLOCK_NAME {}" > "blocks/$BLOCK_NAME/src/style.scss"

# Crea il file editor.scss del blocco
echo ".wp-block-block-library-block-$BLOCK_NAME {}" > "blocks/$BLOCK_NAME/src/editor.scss"

# Aggiunge i script di sviluppo e build per il blocco in package.json
jq --arg BLOCK_NAME "$BLOCK_NAME" \
    '.scripts |= .+ {
        "start:\($BLOCK_NAME)": "wp-scripts start blocks/\($BLOCK_NAME)/src/index.js --output-path=blocks/\($BLOCK_NAME)/build/ && cd blocks/\($BLOCK_NAME) && node ../../copy-json.js \($BLOCK_NAME)",
        "build:\($BLOCK_NAME)": "wp-scripts build blocks/\($BLOCK_NAME)/src/index.js --output-path=blocks/\($BLOCK_NAME)/build/ && cd blocks/\($BLOCK_NAME) && node ../../copy-json.js \($BLOCK_NAME)"
    }' "package.json" > "package.tmp.json" && mv "package.tmp.json" "package.json"

echo "Il blocco $BLOCK_NAME è stato creato."