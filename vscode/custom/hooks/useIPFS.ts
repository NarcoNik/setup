function useIPFS() {
  function resolveImgLink(url: string) {
    if (!url.includes('ipfs://') || !url) return url;
    else return url.replace('ipfs://', 'https://ipfs.io/ipfs/');
  }
  function resolveJsonLink(url: string) {
    if (!url.includes('https://gateway.pinata.cloud/ipfs/') || !url) return url;
    else return url.replace('https://gateway.pinata.cloud/ipfs/', 'https://ipfs.io/ipfs/');
  }
  function myGateImg(url: string) {
    if (!url.includes('ipfs://') || !url) return url;
    else return url.replace('ipfs://', 'https://peach-just-kiwi-801.mypinata.cloud/ipfs/');
  }
  function myGateJson(url: string) {
    if (!url.includes('https://ipfs.io/ipfs/') || !url) return url;
    else return url.replace('https://ipfs.io/ipfs/', 'https://peach-just-kiwi-801.mypinata.cloud/ipfs/');
  }
  return { resolveImgLink, resolveJsonLink, myGateImg, myGateJson };
}
export default useIPFS;
