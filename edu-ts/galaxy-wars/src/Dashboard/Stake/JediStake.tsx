import { ethers } from 'ethers';
import React, { useEffect, useRef, useState } from 'react';

import { n4 } from '../../helpers/formatters.ts';

function JediStake(props: any) {
  const mountedRef = useRef(true);
  const { stake, nft, handleNFTBlockClick, selectionJ } = props;
  const [selection, setSelection] = useState(false);
  function handleNftClick() {
    setSelection(!selection);
    handleNFTBlockClick(nft.edition);
  }
  const [nowFarm, setIdFarm] = useState(0);
  function getIdFarm(p: number | string) {
    stake.getNFTpending(p).then((r: bigint) => setIdFarm(Number(n4.format(Number(ethers.utils.formatEther(r))))));
  }
  useEffect(() => {
    mountedRef.current = true;
    if (selectionJ) setSelection(false);
    getIdFarm(nft.edition);
    return () => {
      mountedRef.current = false;
    };
  }, [nft, selection, selectionJ]);
  return (
    <div className='nftCard' key={nft.edition}>
      <img
        onClick={handleNftClick}
        src={nft.image || 'error'}
        alt=''
        className='nftIMG'
        style={{
          borderColor: selectionJ ? 'red' : selection ? 'blue' : ''
        }}
      />
      <p>
        {nft.name} <br />
        {`${nowFarm} SETH`}
      </p>
    </div>
  );
}
export default JediStake;
                                                                                                                                                                                   