import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { MINT_ADDR, STAKE_ADDR } from '../helpers/utils.ts';

function useIsApprove(token: any, mint: any) {
  const mountedRef = useRef(true);
  const { address, isConnected } = useAccount();
  const [isApprovedNFT, setIsApprovedNFT] = useState(false);
  const [isApprovedToken, setIsApprovedToken] = useState(false);
  function isApproveNFT() {
    if (!mountedRef.current) return null;
    mint.isApprovedForAll(address, STAKE_ADDR).then((r: any) => setIsApprovedNFT(r));
  }
  function isApproveToken() {
    if (!mountedRef.current) return null;
    token.isApproved(address, MINT_ADDR).then((r: any) => setIsApprovedToken(r));
  }
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      isApproveNFT();
      isApproveToken();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [address, isConnected]);
  return { isApprovedNFT, isApprovedToken };
}
export default useIsApprove;
