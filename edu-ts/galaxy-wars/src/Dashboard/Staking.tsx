import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { Staked, Unstaked } from './Stake/index.ts';

function Staking(props: any) {
  const mountedRef = useRef(true);
  const { token, mint, stake, chain } = props;
  const { isConnected } = useAccount();
  const [auth, setAuth] = useState(false);
  const [value, setValue] = useState('1');
  function handleChange(newValue: string) {
    setValue(newValue);
  }
  useEffect((): any => {
    if (!isConnected) return;
    mountedRef.current = true;
    let t: any;
    if (isConnected && !auth) {
      t = setTimeout(() => {
        setAuth(true);
      }, 100);
    }
    return () => {
      clearTimeout(t);
      mountedRef.current = false;
    };
  }, [isConnected, value, auth]);
  return (
    <div className='Stake_cont'>
      <div className='Header_staking'>
        <div className='stake_switch'>
          <button className={value === '1' ? 'textstake' : 'textstakedis'} onClick={() => handleChange('1')}>
            Wallet
          </button>
          <button className={value === '1' ? 'textstakedis' : 'textstake'} onClick={() => handleChange('2')}>
            Stake
          </button>
        </div>
        {isConnected && auth && (
          <>
            {value === '1'
              ? isConnected && value === '1' && <Unstaked token={token} mint={mint} stake={stake} chain={chain} />
              : isConnected && value === '2' && <Staked token={token} mint={mint} stake={stake} chain={chain} />}
          </>
        )}
      </div>
      <br />
      <br />
    </div>
  );
}
export default Staking;
                                                                                                        