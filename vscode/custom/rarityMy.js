const basePath = process.cwd();
const fs = require('fs');
const layersDir = `${basePath}/layers`;

const { layerConfigurations } = require(`${basePath}/src/config.js`);

const { getElements } = require('../src/main.js');

// read json data
let data = JSON.parse(fs.readFileSync(`${basePath}/build/json/_metadata.json`));
let editionSize = data.length;

let rarityData = [];
// intialize layers to chart
// layerConfigurations.forEach((config) => {
//     let layers = config.layersOrder;

//     layers.forEach((layer) => {
//         // get elements for each layer
//         let elementsForLayer = [];
//         let elements = getElements(`${layersDir}/${layer.name}/`);
//         elements.forEach((element) => {
//             // just get name and weight for each element
//             let rarityDataElement = {
//                 trait: element.name,
//                 // weight: element.weight.toFixed(0),
//                 occurrence: 0, // initialize at 0
//                 chance: 0,
//             };
//             elementsForLayer.push(rarityDataElement);
//         });
//         let layerName =
//             layer.options?.["displayName"] != undefined
//                 ? layer.options?.["displayName"]
//                 : layer.name;
//         // don't include duplicate layers
//         if (!rarityData.includes(layer.name)) {
//             // add elements for each layer to chart
//             rarityData[layerName] = elementsForLayer;
//         }
//     });
// });
// // fill up rarity chart with occurrences from metadata
// data.forEach((item) => {
//     let attributes = item.attributes;
//     // let edition = item.edition;
//     attributes.forEach((attribute) => {
//         let traitType = attribute.trait_type;
//         let value = attribute.value;
//         let rarityDataTraits = rarityData[traitType];
//         rarityDataTraits.forEach((rarityDataTrait) => {
//             if (rarityDataTrait.trait == value) {
//                 // keep track of occurrences
//                 rarityDataTrait.occurrence++;
//             }
//         });
//     });
// });
// // convert occurrences to occurence string
// for (var layer in rarityData) {
//     for (var attribute in rarityData[layer]) {
//         // get chance
//         let chance = (
//             (rarityData[layer][attribute].occurrence / editionSize) *
//             100
//         ).toFixed(2);
//         // show two decimal places in percent
//         rarityData[layer][
//             attribute
//         ].occurrence = `${rarityData[layer][attribute].occurrence} in ${editionSize} editions (${chance} %)`;
//         rarityData[layer][attribute].chance = chance;
//     }
// }
// print out rarity data
// for (var layer in rarityData) {
//     console.log(`Trait type: ${layer}`);
//     for (var traitt in rarityData[layer]) {
//         console.log(rarityData[layer][traitt]);
//     }
// }
// const n4 = new Intl.NumberFormat("en-us", {
//     style: "decimal",
//     minimumFractionDigits: 0,
//     maximumFractionDigits: 0,
// });

const newData = data.map(obj => {
  // let alpha = [];
  let atrib = [];
  let type = '';
  obj.attributes.map(x => {
    for (var i = 0; i < obj.attributes.length; i++) {
      atrib[i] = obj.attributes[i];
    }
  });
  obj.attributes.forEach(obj => {
    let traitType = obj.trait_type;
    let value = obj.value;
    if (traitType == 'type') {
      type += value;
    }
    if (traitType == 'type sith') {
      type += value;
      traitType = 'type';
    }
    if (traitType == 'type jedi') {
      type += value;
      traitType = 'type';
    }
    if (traitType == 'type legend') {
      type += value;
      traitType = 'type';
    }
  });
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
    image: obj.image,
    edition: obj.edition,
    // dna: obj.dna,
    // type: type,
    // attributes: obj.attributes,
    attributes: [
      {
        trait_type: 'background',
        value: 'stars'
      },
      {
        trait_type: 'rarity',
        value: 'pass'
      }
    ]

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

fs.writeFileSync(`${basePath}/build/json/_metadata.json`, JSON.stringify(newData, null, 2));
