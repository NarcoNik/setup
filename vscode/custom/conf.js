import { readFileSync, writeFileSync } from 'fs';

// read json data
let data = JSON.parse(readFileSync(`build/json/mainnet-beta-cyberbasketball.json`));
let newData = [];
for (var i = 0; i < 5024; i++) {
  let items = data.items;
  newData.push(items[i]);
}
const dataM = newData.map(x => {
  return {
    ...x,
    onChain: true,
    verifyRun: true
  };
});
for (var i = 0; i < 5024; i++) {
  data.items[i] = dataM[i];
}

writeFileSync(`build/json/mainnet-beta-cyberbasketball.json`, JSON.stringify(data, null, 2));
