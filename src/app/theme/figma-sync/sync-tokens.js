// figma-sync/extract-tokens.js (esqueleto)
const fs = require('fs');
const fetch = require('node-fetch'); // ou axios
const FIGMA_TOKEN = process.env.FIGMA_TOKEN;
const FILE_KEY = process.env.FIGMA_FILE_KEY;
async function extract() {
 const url = `https://api.figma.com/v1/files/${FILE_KEY}`;
 const res = await fetch(url, { headers: { 'X-Figma-Token': FIGMA_TOKEN } });
 const data = await res.json();
 // percorra nodes e extraia tokens -> salve tokens.json
 fs.writeFileSync('tokens.json', JSON.stringify(data, null, 2));
}
extract().catch(console.error);
