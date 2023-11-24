import { useState } from 'react';
import { useClipboard } from 'use-clipboard-copy';

export const useLang = () => {
  const [cop, setCop] = useState('Copy Address');
  const clipboard = useClipboard({
    onSuccess() {
      setCop('Copied!');
      setTimeout(() => {
        setCop('Copy Address');
      }, 1000);
    },
    onError() {
      setCop('No copied');
      setTimeout(() => {
        setCop('Copy Address');
      }, 1000);
    }
  });

  return { cop, clipboard };
};
