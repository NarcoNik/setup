// @js-ignore
import { Buffer } from 'buffer';

const nextTick = require('next-tick');

window.Buffer = Buffer;
window.global = window.global ?? window;
window.process = window.process ?? { env: { DEBUG: undefined }, version: '', nextTick };
global.Buffer = Buffer;

export {};
