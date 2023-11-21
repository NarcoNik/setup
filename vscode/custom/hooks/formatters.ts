import { ethers } from 'ethers';

const n8 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 8
});
const n6 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 6
});
const n5 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 5
});
const n2 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 4
});
const n4 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 2
});
const n3 = new Intl.NumberFormat('en-us', {
  style: 'decimal',
  minimumFractionDigits: 0,
  maximumFractionDigits: 3
});
const c2 = new Intl.NumberFormat('en-us', {
  style: 'currency',
  currency: 'USD',
  minimumFractionDigits: 2,
  maximumFractionDigits: 2
});
function getEllipsisTxt(str: string) {
  if (str) return `${str.substr(0, 4)}...${str.substr(str.length - 4, str.length)}`;
  else return '';
}
function getEllipsisTxtt(str: string) {
  if (str) return `${str.substr(0, 4)}...${str.substr(str.length - 2, str.length)}`;
  else return '';
}
function toHex(num: number) {
  return ethers.BigNumber.from(num.toString()).toHexString();
}
// const toHex = num => {
//   const val = Number(num);
//   return ethers.BigNumber.from(val.toString()).toHexString();
//   return `0x${val.toString(16)}`;
// };
export { c2, getEllipsisTxt, getEllipsisTxtt, n2, n3, n4, n5, n6, n8, toHex };
