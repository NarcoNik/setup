import { darkTheme, getDefaultWallets, lightTheme, RainbowKitProvider } from '@rainbow-me/rainbowkit';
import * as React from 'react';
import { configureChains, createClient, WagmiConfig } from 'wagmi';
import { bsc, bscTestnet } from 'wagmi/chains';
import { infuraProvider } from 'wagmi/providers/infura';
import { publicProvider } from 'wagmi/providers/public';

const chains = [bsc, bscTestnet];
const infuraId = process.env.REACT_APP_INFURA_ID ? process.env.REACT_APP_INFURA_ID : '';
const projectId = process.env.REACT_APP_WC_ID ? process.env.REACT_APP_WC_ID : '';

const { provider } = configureChains(chains, [infuraProvider({ apiKey: infuraId }), publicProvider()]);
const { connectors } = getDefaultWallets({
  appName: 'galaxy-wars',
  projectId,
  chains
});
const wagmiClient = createClient({ autoConnect: true, connectors, provider });

function Provider(props: any) {
  const { children } = props;
  return (
    <WagmiConfig client={wagmiClient}>
      <RainbowKitProvider
        coolMode
        chains={chains}
        initialChain={97}
        showRecentTransactions={true}
        modalSize='wide'
        appInfo={{
          appName: 'galaxy-wars',
          learnMoreUrl: 'https://galaxy-wars.store'
          // disclaimer: Disclaimer
        }}
        theme={{
          lightMode: lightTheme({
            borderRadius: 'small',
            fontStack: 'rounded',
            overlayBlur: 'small'
          }),
          darkMode: darkTheme({
            borderRadius: 'small',
            fontStack: 'rounded',
            overlayBlur: 'small'
          })
        }}
      >
        {children}
      </RainbowKitProvider>
    </WagmiConfig>
  );
}
export default Provider;
// const Disclaimer: DisclaimerComponent = ({ Text, Link }) => (
//   <Text>
//     By connecting your wallet, you agree to the <Link href='https://termsofservice.xyz'>Terms of Service</Link> and acknowledge you have
//     read and understand the protocol <Link href='https://disclaimer.xyz'>Disclaimer</Link>
//   </Text>
// );
                                                                                                                                                                                                      