import { readFileSync, writeFileSync } from 'fs';

const basePath = process.cwd();

// read json data
const metadata = JSON.parse(readFileSync(`../build/json/_metadata.json`));

let legendId = [];
metadata.forEach(x => {
  if (x.type === 'Legend') legendId.push(x.edition);
});
writeFileSync(`../build/json/_legend.json`, JSON.stringify(legendId, null, 2));

let jediId = [];
metadata.forEach(x => {
  if (x.type === 'Jedi' || x.type === 'Sith') jediId.push(x.edition);
});
writeFileSync(`../build/json/_jedi.json`, JSON.stringify(jediId, null, 2));
