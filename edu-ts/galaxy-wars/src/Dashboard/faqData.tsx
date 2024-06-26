import * as React from 'react';

const faqData = [
  {
    id: 1,
    title: <i>1) Clonetrooper - the base class on which your team is based</i>,
    content: (
      <span className='faq-text'>
        Earn: 50 SETH/day <br />
        Tax: 20% of the earnings are automatically distributed to Siths and Jedis when claiming SETH <br />
        Ability: <br />
        -Can be unstaked when you reach a balance of at least 100 SETH
      </span>
    )
  },
  {
    id: 2,
    title: <i>2) Jedi and Sith - unique class with passive and active abilities.</i>,
    content: (
      <span className='faq-text'>
        Earn: collects a tax of 20% from clonetroopers, this tax is divided between all Jedi and Sith in staking <br />
        Tax: does not pay tax to any class <br />
        Ability: <br />
        - Can steal a random just minted GEN2 and GEN3 NFT <br />
        - When a Jedi or sith uses HYPNOSIS, they steals 15% of the earned SETH from another random players team <br />- Can be unstaked at
        any time
      </span>
    )
  },
  {
    id: 3,
    title: <i>3) Legends - The rarest class of 50 unique heroes from the Star Wars universe.</i>,
    content: (
      <span className='faq-text'>
        Earn: 150 SETH/day <br />
        Tax: Does not pay tax to any class <br />
        Ability: <br />
        -If there is a clonetrooper in the team with the Legend, he is relieved of the obligation to pay 20% tax.
        <br />
        -Increases the Hypnosis skill from 15% to 30%.
        <br />
        -Can be unstaked at any time.
      </span>
    )
  },
  {
    id: 4,
    title: <i>4) How to mint a NFT?</i>,
    content: (
      <span className='faq-text'>
        - To mint a NFT select the desired amount of NFTs using the + and - buttons, then press the mint button and confirm the transaction.
        <br />- Wait up to 5 minutes and your NFTs will be shown in the wallet section.
      </span>
    )
  },
  {
    id: 5,
    title: <i>5) How to play?</i>,
    content: (
      <span className='faq-text'>
        - To start playing in the wallet tab select the desired NFTs to be sent to the battlefield and press stake.
        <br />- Then confirm approve transaction (necessary for the contract to work and completely safe for you), and then submit the main
        transaction.
        <br />- To see your NFTs on the field of battle go to the stake tab.
      </span>
    )
  },
  {
    id: 6,
    title: <i>6) When SETH farming starts?</i>,
    content: (
      <span className='faq-text'>Farming SETH and the official start of the game will begin automatically after minting GEN1 NFTs</span>
    )
  },
  {
    id: 7,
    title: <i>7) How to claim rewards? </i>,
    content: (
      <span className='faq-text'>
        - In the stake tab select the class you want to claim the rewards from and click on the claim button then confirm the transaction.{' '}
        <br />- If you want to collect rewards from all the characters, press the claim all button and confirm the transaction
      </span>
    )
  },
  {
    id: 8,
    title: <i>8) How to unstake NFTs?</i>,
    content: (
      <span className='faq-text'>
        - To collect NFTs from the battlefield select the desired NFTs and press unstake+claim button.
        <br /> - Then confirm the transaction <br />
        <br />* Please note, that if you want to unstake the clonetrooper its balance should be more than 100 SETH
      </span>
    )
  },
  {
    id: 9,
    title: <i>9) How to mint NFT GEN2 and GEN3? </i>,
    content: (
      <span className='faq-text'>
        - NFTs GEN2 and GEN3 can be minted only for SETH coin.
        <br /> - The cost of minting NFT GEN2 is 150 SETH, nft GEN3 is 300 SETH. <br />- To mint NFTs you need to choose the desired amount
        of NFTs for minting, then press mint button.
        <br /> - Then confirm approve transaction (necessary for contract work and completely safe for you), and then submit the main
        transaction
      </span>
    )
  },
  {
    id: 10,
    title: <i>10) How buy SETH? </i>,
    content: (
      <span className='faq-text'>
        - To safely buy SETH click buy SETH button and you will move to the Pancake swap.
        <br /> - Now you just have to swap the desired amount of SETH in the BNB/SETH pair
      </span>
    )
  }
];
export default faqData;
                                                                                                                        