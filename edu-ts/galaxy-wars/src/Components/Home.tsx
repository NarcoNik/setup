import React, { useEffect, useRef, useState } from 'react';
import { NavLink } from 'react-router-dom';

function Telegram(props: any) {
  const { setAct } = props;
  const tgChat = 'https://t.me/galaxy_wars_chat_eu';
  const tgChan = 'https://t.me/galaxy_wars_eu';
  const tgChatRu = 'https://t.me/galaxy_wars_chat';
  const tgChanRu = 'https://t.me/galaxy_wars';
  return (
    <div className='HomeSocL'>
      <a className='link-h' target='_blank' rel='noopener noreferrer' href={tgChan} onClick={() => setAct(false)}>
        Channel EU
      </a>
      <a className='link-h' target='_blank' rel='noopener noreferrer' href={tgChat} onClick={() => setAct(false)}>
        Chat EU
      </a>

      <a className='link-h' target='_blank' rel='noopener noreferrer' href={tgChanRu} onClick={() => setAct(false)}>
        Channel ru
      </a>
      <a className='link-h' target='_blank' rel='noopener noreferrer' href={tgChatRu} onClick={() => setAct(false)}>
        Chat ru
      </a>
    </div>
  );
}
function Home() {
  const mountedRef = useRef(true);
  const [act, setAct] = useState(false);
  const twi = 'https://twitter.com/galaxywars_game';
  useEffect(() => {
    mountedRef.current = true;
    return () => {
      mountedRef.current = false;
    };
  }, []);
  return (
    <div className='Home_cont'>
      <div className='home'>
        <h1
          style={{
            color: 'yellow'
          }}
        >
          Launch page
        </h1>
        <p className='Home_text'>
          Welcome to the Galaxy Wars strategic NFT P2E game! <br />
          Now you are on the launch page, where all the useful links that you will need are conveniently located. <br />
          -To start playing and earning, follow the link
        </p>
        <NavLink className='link-g' to='/dashboard'>
          Dashboard
        </NavLink>
        <p className='Home_text'>-To find out all the technical information about the project, click on the</p>
        <a className='link-r' target='_blank' rel='noopener noreferrer' href='https://docs.galaxy-wars.store'>
          Documentation
        </a>
        <p className='Home_text'>
          We recommend that you do this before starting the game so that you are fully aware of all the subtleties of the game mechanics.{' '}
          <br />
          <br />
          -At the footer you can see links leading to the official social networks of the project
        </p>
        {act ? (
          <Telegram setAct={setAct} />
        ) : (
          <div className='HomeSocL'>
            <a className='link-h' target='_blank' rel='noopener noreferrer' href={twi}>
              Twitter
            </a>
            <button className='link-h' onClick={() => setAct(true)}>
              Telegram
            </button>
          </div>
        )}
      </div>
      <hr />
      <hr />
    </div>
  );
}
export default Home;
                                                                                                                                               