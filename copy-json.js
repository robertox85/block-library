const fs = require('fs');
const path = require('path');

// Prendiamo il nome del blocco dai parametri della riga di comando
const args = process.argv.slice(2);
if (args.length !== 1) {
  console.log('Usage: node copy-json.js <block-name>');
  process.exit(1);
}

const blockName = args[0];

// Utilizza la directory corrente come directory del blocco
const blockDir = process.cwd();

// Costruisci i percorsi sorgente e di destinazione
const srcPath = path.join(blockDir, 'src', 'block.json');
const destPath = path.join(blockDir, 'build', 'block.json');

fs.copyFile(srcPath, destPath, (err) => {
  if (err) throw err;
  console.log(`block.json was copied from ${blockName}`);
});
