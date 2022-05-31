export const wellknown = {
  fantom: {
    addresses: {
      weth: '0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83',
      xTokenEth: '0xbc4B67Ccef529929a7FA984A46133d4Ddb452Ae0', // xftm/weth
      yTokenEth: '0xaEf0C4d2c0d96434BD9047271E5CfE6fa335add2', // fsm/weth
      swapRouter: '0xF491e7B69E4244ad4002BC14e878a34207E38c29', // spooky
    },
  },
};

export type Wellknown = typeof wellknown;
