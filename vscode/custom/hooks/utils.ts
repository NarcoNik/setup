import axios from 'axios';
import { toast } from 'react-toastify';

import Data from './data.json';

const { ethereum } = window;
const api = 'https://api.db-ip.com/v2/free/self/';
const WETH = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2';
const MULTICALL_ADDRESS = '0xcA11bde05977b3631167028862bE2a173976CA11';
const MAX_APPROVAL = '1158472395435294898592384258348512586931256';
const TOKEN_ADDR = Data.token.addr;
const TOKEN_ABI = Data.token.abi;
const MINT_ADDR = Data.mint.addr;
const MINT_ABI = Data.mint.abi;
const STAKE_ADDR = Data.stake.addr;
const STAKE_ABI = Data.stake.abi;
const sleep = (ms: number) => new Promise(r => setTimeout(r, ms));
async function getABI(addr: any, abiUrl: any) {
  console.log('Getting ABI for', addr);
  let res: any = await axios.get(abiUrl.format(addr));
  res = res.data.result[0];
  let abi = JSON.parse(res.ABI);
  let impl = '';
  if (res.Proxy === '1' && res.Implementation !== '') {
    impl = res.Implementation;
    console.log('Getting impl ABI for', impl);
    abi = JSON.parse((await axios.get(abiUrl.format(impl))).data.result[0].ABI);
  }
  return [abi, impl];
}
function notify(text: string, type: string, id: string | number) {
  const options: object | any = {
    position: 'top-center',
    autoClose: false,
    hideProgressBar: true,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    progress: undefined,
    isLoading: true,
    theme: 'dark',
    draggablePercent: 60,
    toastId: id
  };
  if (type === 'loading') return toast(text, options);
  if (type === 'success') return toast.update(options.toastId, { render: text, type, isLoading: false, autoClose: 5000, hideProgressBar: false });
  if (type === 'error') return toast.update(options.toastId, { render: text, type, isLoading: false, autoClose: 5000, hideProgressBar: false });
}
function errorMessage(e: any, id: string | number) {
  const err = e.error;
  let text = '';
  if (err === undefined) {
    console.error(e);
    text = e.message.split('(')[0];
    if (e.code === -32603 && e.message.split(']')[0] === '[ethjs-query')
      text = 'Error only testnet, transaction successfully completed. Pls refresh the page and see result for your transaction';
    if (e.message === 'Internal JSON-RPC error.') text = `${e.data.message.split(':')[1]} ${e.data.message.split(':')[2]}`;
    if (e.message === 'Internal JSON-RPC error.' && e.data.message.split(':')[1] === undefined) text = e.data.message;
    notify(text, 'error', id);
  } else {
    console.error(err);
    text = err.data.message.split(':')[1];
    if (text === undefined) text = err.data.message;
    if (err.message === 'Internal JSON-RPC error.') text = `${err.data.message.split(':')[1]} ${err.data.message.split(':')[2]}`;
    notify(text, 'error', id);
  }
}
export {
  api,
  errorMessage,
  ethereum,
  getABI,
  MAX_APPROVAL,
  MINT_ABI,
  MINT_ADDR,
  MULTICALL_ADDRESS,
  notify,
  sleep,
  STAKE_ABI,
  STAKE_ADDR,
  TOKEN_ABI,
  TOKEN_ADDR,
  WETH
};
