import { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

function useIsPause(mint: any, stake: any) {
  const mountedRef = useRef(true);
  const { isConnected } = useAccount();
  const [isMintPause, setIsMintPause] = useState(false);
  const [isStakePause, setIsStakePause] = useState(false);
  function mintPaused() {
    if (!mountedRef.current) return null;
    mint.paused().then((r: any) => setIsMintPause(r));
  }
  function stakePaused() {
    if (!mountedRef.current) return null;
    stake.paused().then((r: any) => setIsStakePause(r));
  }
  useEffect(() => {
    if (!isConnected) return;
    mountedRef.current = true;
    const t = setTimeout(() => {
      mintPaused();
      stakePaused();
    }, 100);
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected]);
  return { isMintPause, isStakePause };
}
export default useIsPause;
