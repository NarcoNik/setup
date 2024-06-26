import { useAddRecentTransaction } from '@rainbow-me/rainbowkit';
import React, { useEffect, useRef, useState } from 'react';
import { useAccount } from 'wagmi';

import { errorChain, errorMessage, initialChain, MAX_APPROVAL, MINT_ADDR, notify } from '../helpers/utils.ts';
import { useContracts, useIsApprove, useIsPause } from '../hooks/index.ts';
import { min, plus } from '../img/index.ts';

function Mint(props: any) {
  const mountedRef = useRef(true);
  const { token, mint, stake, chain } = props;
  const { address, isConnected } = useAccount();
  const { payMint, currentPrice, a } = useContracts(mint, stake, chain);
  const { isApprovedToken } = useIsApprove(token, mint, chain);
  const { isMintPause } = useIsPause(mint, stake, chain);
  const addRecentTransaction = useAddRecentTransaction();
  // Get token sold
  let total;
  let price;
  let sold = false;
  switch (true) {
    case a >= 0 && a < 2500:
      total = `${a} / 2 500 MINTED`;
      price = `Current Price ${currentPrice} BNB`;
      break;
    case a >= 2500 && a < 6000:
      total = `${a - 2500} / 3 500 MINTED`;
      price = `Current Price ${currentPrice} SETH`;
      break;
    case a >= 6000 && a < 10000:
      total = `${a - 6000} / 4 000 MINTED`;
      price = `Current Price ${currentPrice} SETH`;
      break;
    case a >= 10000:
      total = 'Sold out';
      price = '';
      sold = true;
      break;
    default:
      total = '0 / 2 500 MINTED';
      price = 'Current Price 0.07 BNB';
  }
  // Plus and Minus function
  let [count, setCount] = useState(1);
  function incrementCount() {
    if (count === 10) setCount(10);
    else {
      count += 1;
      setCount(count);
    }
  }
  function decrementCount() {
    if (count !== 1) {
      count -= 1;
      setCount(count);
    } else count = 1;
  }
  // Minting Function
  async function mintNFTexecution() {
    if (!mountedRef.current) return null;
    notify('Minting', 'loading', 'mint');
    if (a + count > 10000) count = 10000 - a;
    const payforMint = count * payMint * 1.05;
    try {
      const tx = await mint.mint(count, {
        from: address,
        value: payforMint.toString()
      });
      addRecentTransaction({ hash: tx.hash, description: `${count} NFT Mint` });
      await tx.wait();
      notify(`Successfully ${count} NFT Minted`, 'success', 'mint');
    } catch (e) {
      errorMessage(e, 'mint');
    }
  }
  async function approveToken() {
    if (!mountedRef.current) return null;
    notify('Approve', 'loading', 'tokenAprove');
    try {
      const tx = await token.approve(MINT_ADDR, MAX_APPROVAL);
      addRecentTransaction({
        hash: tx.hash,
        description: 'Approve tokens for minting nft'
      });
      //   await toast.promise(tx, {
      //     pending: 'Approving SETH for minting NFT',
      //     success: 'SETH has ben approved!',
      //     error: 'Approving error!'
      //   });
      await tx.wait();
      notify('Successfully approved tokens for minting nft', 'success', 'tokenAprove');
    } catch (e) {
      errorMessage(e, 'tokenAprove');
    }
  }
  async function mintNFT() {
    if (!mountedRef.current) return null;
    if (chain?.id !== initialChain) return errorChain('mint');
    if (isMintPause) notify('Contract not started', 'error', 'mint');
    if (a < 2500) await mintNFTexecution();
    else if (a >= 2500 && a < 10000) {
      if (!isApprovedToken) await approveToken();
      await mintNFTexecution();
    }
  }
  useEffect(() => {
    if (!isConnected) return;
    // if (chain?.id !== initialChain) return;
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
    };
  }, [isConnected, address]);
  return (
    <div className='btnMINT'>
      <div className='Minting_amount'>{total}</div>
      <br />
      {sold ? (
        ''
      ) : (
        <div className='NumBox'>
          <img className='min btnltf' alt='' src={min} onClick={decrementCount} />
          {count}
          <img className='plus btnrgt' alt='' src={plus} onClick={incrementCount} />
        </div>
      )}
      {sold ? (
        <>
          <a
            className='MINT'
            href='https://opensea.io/collection/weeds-lab-official'
            style={{
              textDecoration: 'none',
              margin: '16px 0px 0px 0px',
              padding: '4px 7px',
              fontSize: '21px'
            }}
          >
            buy on opensea
          </a>
        </>
      ) : (
        <button type='button' onClick={mintNFT} className='MINT'>
          Mint
        </button>
      )}
      <div className='Minting_prog_text_item'>{price}</div>
    </div>
  );
}
export default Mint;
                                                                                                                                                                                                                                                                                                                                                                       