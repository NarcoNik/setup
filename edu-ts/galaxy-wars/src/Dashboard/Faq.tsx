import React, { useState } from 'react';

function Faq(props: any) {
  const { title, content } = props;
  const [isActive, setIsActive] = useState(false);
  return (
    <div className='accordion-item'>
      <div className='accordion-title' onClick={() => setIsActive(prev => !prev)}>
        <div>{title}</div>
        <div>{isActive ? <span className='faq-m'>-</span> : <span className='faq-p'>+</span>}</div>
      </div>
      {isActive && <div className='accordion-content'>{content}</div>}
    </div>
  );
}
export default Faq;
                                                                                                                                     