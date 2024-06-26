import React, { useEffect, useRef, useState } from 'react';

function LegendUnstake(props: any) {
  const mountedRef = useRef(true);
  const { nft, handleNFTBlockClick, selectionH } = props;
  const [selection, setSelection] = useState(false);
  function handleNftClick() {
    setSelection(!selection);
    handleNFTBlockClick(nft.edition);
  }
  useEffect(() => {
    mountedRef.current = true;
    if (selectionH) setSelection(false);
    return () => {
      mountedRef.current = false;
    };
  }, [nft, selection, selectionH]);
  return (
    <div className='nftCard' key={nft.edition}>
      <img
        onClick={handleNftClick}
        src={nft.image || 'error'}
        alt=''
        className='nftIMG'
        style={{
          borderColor: selectionH ? 'red' : selection ? 'blue' : ''
        }}
      />
      <p>{nft.name}</p>
    </div>
  );
}
export default LegendUnstake;
                                                                                                                                                                                  