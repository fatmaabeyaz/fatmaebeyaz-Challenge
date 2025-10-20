import { Transaction } from '@mysten/sui/transactions';

// 1 SUI = 1,000,000,000 MIST
const SUI_TO_MIST = 1_000_000_000;

export const listHero = (
  packageId: string,
  heroId: string,
  priceInSui: string
) => {
  const tx = new Transaction();

  // TODO: Convert SUI to MIST
  // Hint: Remember 1 SUI = 1_000_000_000 MIST
  const priceInMist = BigInt(parseFloat(priceInSui) * SUI_TO_MIST);

  // TODO: Add moveCall to list a hero for sale
  // Function: ${packageId}::marketplace::list_hero
  tx.moveCall({
    target: `${packageId}::marketplace::list_hero`,
    arguments: [
      tx.object(heroId), // Hint: Use tx.object() for the hero object
      tx.pure.u64(priceInMist), // Hint: Use tx.pure.u64() for the price
    ],
  });

  return tx;
};