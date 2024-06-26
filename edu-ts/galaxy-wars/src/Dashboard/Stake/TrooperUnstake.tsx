import React, { useEffect, useRef, useState } from 'react';

function TrooperUnstake(props: any) {
  const mountedRef = useRef(true);
  const { nft, handleNFTBlockClick, selectionT } = props;
  const [selection, setSelection] = useState(false);
  function handleNftClick() {
    setSelection(!selection);
    handleNFTBlockClick(nft.edition);
  }
  useEffect(() => {
    mountedRef.current = true;
    if (selectionT) setSelection(false);
    return () => {
      mountedRef.current = false;
    };
  }, [nft, selectionT, selection]);
  return (
    <div className='nftCard' key={nft.edition}>
      <img
        onClick={handleNftClick}
        src={nft.image || 'error'}
        alt=''
        className='nftIMG'
        style={{
          borderColor: selectionT ? 'red' : selection ? 'blue' : ''
        }}
      />
      <p>{nft.name}</p>
    </div>
  );
}
export default TrooperUnstake;
                                                                                                                                                                                   