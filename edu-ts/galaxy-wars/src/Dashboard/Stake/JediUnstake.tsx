import React, { useEffect, useRef, useState } from 'react';

function JediUnstake(props: any) {
  const mountedRef = useRef(true);
  const { nft, handleNFTBlockClick, selectionJ } = props;
  const [selection, setSelection] = useState(false);
  function handleNftClick() {
    setSelection(!selection);
    handleNFTBlockClick(nft.edition);
  }
  useEffect(() => {
    mountedRef.current = true;
    if (selectionJ) setSelection(false);
    return () => {
      mountedRef.current = false;
    };
  }, [nft, selection, selectionJ]);
  return (
    <div className='nftCard'>
      <div className='nftBox' key={nft.edition}>
        <img
          onClick={handleNftClick}
          src={nft.image || 'error'}
          alt=''
          className='nftIMG'
          style={{
            borderColor: selectionJ ? 'red' : selection ? 'blue' : ''
          }}
        />
      </div>
      <p>{nft.name}</p>
    </div>
  );
}
export default JediUnstake;
                                                                                                                                                                                  