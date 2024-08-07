import * as React from 'react';
import { NavLink, Route, Routes } from 'react-router-dom';

import Dashboard from './Components/Dashboard.tsx';
import Home from './Components/Home.tsx';
import NotFound from './Components/NotFound.tsx';
import ConnectCustom from './ConnectCustom.tsx';
import IsLoading from './context/IsLoading.tsx';
import { logo } from './img/index.ts';

function App() {
  return (
    <div className='Apps'>
      <div className='Back'>
        <header className='header'>
          <NavLink to='/'>
            <img className='logo' alt='' src={logo} />
          </NavLink>
          <ConnectCustom />
        </header>
        <IsLoading>
          <Routes>
            <Route path='/' element={<Home />} />
            <Route path='/dashboard' element={<Dashboard />} />
            <Route path='/*' element={<NotFound />} />
          </Routes>
        </IsLoading>
        <div className='[ l-Section l-Section--stars ]'>
          <div className='stars-small'></div>
          <div className='stars-big'></div>
        </div>
      </div>
    </div>
  );
}
export default App;
                     