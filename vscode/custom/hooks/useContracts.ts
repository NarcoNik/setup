import { ethers } from 'ethers';
import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { n3 } from '../helpers/formatters.ts';

function useContracts(mint: any, stake: any) {
  const mountedRef = useRef(true);
  const { address, isConnected } = useAccount();
  const [payMint, setPayMint] = useState(0);
  const [currentPrice, setCurrentPrice] = useState(0);
  const [currentSteelPrice, setCurrentSteelPrice] = useState(0);
  const [a, setCirc] = useState(0);
  function getcirulatingSupply() {
    mint.cirulatingSupply().then((r: any) => setCirc(Number(ethers.utils.formatUnits(r, 'wei'))));
  }
  function getCurrentPrice() {
    mint.getCurrentPrice().then((r: any) => {
      setPayMint(r);
      setCurrentPrice(Number(n3.format(Number(ethers.utils.formatEther(r)))));
    });
  }
  function getCurrentSteelPrice1() {
    stake.getCurrentStealPrice().then((r: any) => setCurrentSteelPrice(r));
  }
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    const t = setTimeout(async () => {
      getCurrentPrice();
      getcirulatingSupply();
      getCurrentSteelPrice1();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [address, isConnected, currentPrice, a]);
  return { payMint, currentPrice, a, currentSteelPrice };
}
export default useContracts;
