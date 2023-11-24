const basePath = process.cwd();
import { readFileSync, writeFileSync } from 'fs';
const layersDir = `${basePath}/layers`;

const { baseUri, layerConfigurations } = require(`${basePath}/src/config.js`);

import { getElements } from '../src/main.js';

// read json data
let data = JSON.parse(readFileSync(`${basePath}/build/json/_metadata.json`));
let editionSize = data.length;

let rarityData = [];
let silver = [];
let gold = [];

const newData = data.map(obj => {
  // let alpha = [];
  // let atrib = [];
  let type = '';
  let img = '';
  // obj.attributes.map(x => {
  //     for (var i = 0; i < obj.attributes.length; i++) {
  //         atrib[i] = obj.attributes[i];
  //     }
  // });
  obj.attributes.forEach(obj => {
    let traitType = obj.trait_type;
    // let value = obj.value;
    if (traitType == 'Bronze') {
      type += 'Bronze';
    }
    if (traitType == 'Silver') {
      type += 'Silver';
    }
    if (traitType == 'Gold') {
      type += 'Gold';
    }
  });
  if (type == 'Bronze') {
    img = `${baseUri}/1.gif`;
  }
  if (type == 'Silver') {
    img = `${baseUri}/2.gif`;
    silver.push(obj.edition);
  }
  if (type == 'Gold') {
    img = `${baseUri}/3.gif`;
    gold.push(obj.edition);
  }

  // for (var i = 0; i < obj.attributes.length; i++) {
  //     if (atrib[i].rarity != 100) {
  //         alpha[i] = 100 - Number(atrib[i].rarity);
  //         score += (alpha[i] / obj.attributes.length) * 100;
  //     }
  // }

  return {
    name: obj.name,
    // symbol: obj.symbol,
    description: obj.description,
    image: img,
    edition: obj.edition,
    dna: obj.dna,
    type: type
    // score: n4.format(score),
    // attributes: obj.attributes.map((x) => {
    //     return {
    //         ...x,
    //         // rarity: rarityData[x.trait_type].find(
    //         //     (l) => x.value === l.trait
    //         // ).occurrence,
    //         rarity: rarityData[x.trait_type].find(
    //             (l) => x.value === l.trait
    //         ).chance,
    //     };
    // }),
    // creators: obj.creators,
    // seller_fee_basis_points: obj.seller_fee_basis_points,
  };
});

let numNew;

newData.forEach(obj => {
  numNew = Number(obj.edition);
  obj.name = obj.name;
  obj.description = obj.description;
  obj.image = obj.image;
  obj.edition = numNew;
  writeFileSync(`${basePath}/build/json/${numNew}`, JSON.stringify(obj, null, 2));
});
writeFileSync(`${basePath}/build/json/_metadata.json`, JSON.stringify(newData, null, 2));
writeFileSync(`${basePath}/build/json/_silver.json`, JSON.stringify(silver, null, 2));
writeFileSync(`${basePath}/build/json/_gold.json`, JSON.stringify(gold, null, 2));
