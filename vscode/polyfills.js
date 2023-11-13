// @js-ignore
import { Buffer } from 'buffer';

window.Buffer = Buffer;
window.global = window.global ?? window;
window.process = window.process ?? { env: {} };
global.Buffer = Buffer;
global.process = {
  env: { DEBUG: undefined },
  version: '',
  nextTick: require('next-tick')
};
export {};
