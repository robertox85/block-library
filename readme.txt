=== Block Library ===
Contributors:      Roberto Di Marco
Tags:              gutenberg, blocks, custom blocks
Tested up to:      6.1
Stable tag:        0.1.0
License:           GPL-2.0-or-later
License URI:       https://www.gnu.org/licenses/gpl-2.0.html


Un plugin WordPress che fornisce una serie di blocchi personalizzati per l'editor Gutenberg.

== Description ==

Il plugin Block Library è stato sviluppato con l'obiettivo di fornire una serie di blocchi personalizzati per l'editor Gutenberg di WordPress. Questi blocchi consentono di creare layout di pagine personalizzate e complesse.

Le caratteristiche principali includono:

1. Una biblioteca di blocchi personalizzati che rispondono a una varietà di necessità di design e funzionalità.
2. Una categoria di blocchi personalizzata, chiamata 'Block Library', per organizzare i blocchi personalizzati all'interno dell'editor Gutenberg.
3. Uno script bash per automatizzare la creazione di nuovi blocchi personalizzati.
4. Uno script bash per automatizzare la rimozione di blocchi personalizzati.
5. Uno script bash per automatizzare la creazione di nuovi pattern personalizzati.
6. Uno script bash per automatizzare la rimozione di pattern personalizzati.

== Installation ==

1. Assicurati di avere Node.js e npm installati sulla tua macchina.
2. Esegui `npm install` nella directory principale del plugin per installare tutte le dipendenze del progetto.
3. Rendi eseguibile lo script di generazione del blocco eseguendo `chmod +x create-block.sh` nella directory principale del plugin.
3. Rendi eseguibile lo script di generazione del blocco eseguendo `chmod +x remove-block.sh` nella directory principale del plugin.
4. Rendi eseguibile lo script di generazione del blocco eseguendo `chmod +x create-pattern.sh` nella directory principale del plugin.
5. Rendi eseguibile lo script di generazione del blocco eseguendo `chmod +x remove-pattern.sh` nella directory principale del plugin.

== Usage ==

Il comando `npm run build` può essere utilizzato per eseguire una build globale dei blocchi, o il comando `npm run build:"block-name"` può essere utilizzato per eseguire una build per un singolo blocco.

Per creare un nuovo blocco, esegui `./create-block.sh "<block-name>"` sostituendo `<block-name>` con il nome del nuovo blocco che vuoi creare.

Per rimuovere un blocco, esegui `./remove-block.sh "<block-name>"` sostituendo `<block-name>` con il nome del blocco che vuoi rimuovere.

Per creare un nuovo pattern, esegui `./create-pattern.sh "<pattern-name>"` sostituendo `<pattern-name>` con il nome del nuovo pattern che vuoi creare.

Per rimuovere un pattern, esegui `./remove-pattern.sh "<pattern-name>"` sostituendo `<pattern-name>` con il nome del pattern che vuoi rimuovere.

== Changelog ==

= 1.0.0 =
* Release iniziale.
