import axios from 'axios';
import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import useIPFS from './useIPFS.ts';

function useNFTBalanceStake(mint: any, stake: any) {
  const mountedRef = useRef(true);
  const { address, isConnected } = useAccount();
  const { resolveJsonLink, resolveImgLink } = useIPFS();
  const [NFTBalance, setNFTBalance] = useState([]);
  async function getInventory() {
    if (!mountedRef.current) return null;
    const stakedId = await stake.getStakedTokens('0x9d67E799E179939bF891D3ac66F23dfd513dEeEF');
    const arrayOfURL = await Promise.all(stakedId.map((z: number | any) => mint.tokenURI(z).then((x: any) => x)));
    const metadata = await Promise.all(arrayOfURL.map(c => axios.get(resolveJsonLink(c)).then((v: any) => v.data)));
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
  const idJedi = Jedi.map((x: object | any) => x.edition);
  const idJediOne = idJedi[0];
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      getBalance();
    }, 100);
    return () => {
      mountedRef.current = false;
      clearTimeout(t);
    };
  }, [isConnected, address]);
  return { Trooper, Jedi, Legend, idJediOne };
}
export default useNFTBalanceStake;
