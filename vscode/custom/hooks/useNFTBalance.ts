import axios from 'axios';
import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import useIPFS from './useIPFS.ts';

function useNFTBalance(mint: any) {
  const mountedRef = useRef(true);
  const { address, isConnected } = useAccount();
  const { resolveJsonLink, resolveImgLink } = useIPFS();
  const [NFTBalance, setNFTBalance] = useState([]);
  async function getInventory() {
    if (!mountedRef.current) return null;
    const arrayOfURL = await mint.getUserMetadata('0x9d67E799E179939bF891D3ac66F23dfd513dEeEF');
    const metadata = await Promise.all(arrayOfURL.map((z: any) => axios.get(resolveJsonLink(z)).then((x: any) => x.data)));
    return metadata;
  }
  async function getBalance() {
    if (!mountedRef.current) return null;
    const dataM = await getInventory();
    if (dataM) {
      const meta: any = dataM;
      for (const NFT of meta) {
        if (NFT) {
          NFT.image = resolveImgLink(NFT.image);
          if (NFT.type === 'Legend') {
            if (NFT.attributes[1].trait_type === 'body legend') NFT.name = NFT.attributes[1].value;
          } else NFT.name = `${NFT.type} ${NFT.edition}`;
        }
      }
      setNFTBalance(meta);
    }
  }
  const Trooper = NFTBalance.filter((x: object | any) => x.type !== 'Jedi' && x.type !== 'Sith' && x.type !== 'Legend');
  const Jedi = NFTBalance.filter((x: object | any) => x.type !== 'Trooper' && x.type !== 'Legend');
  const Legend = NFTBalance.filter((x: object | any) => x.type !== 'Jedi' && x.type !== 'Sith' && x.type !== 'Trooper');
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      getBalance();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected, address]);
  return { Trooper, Jedi, Legend };
}
export default useNFTBalance;
