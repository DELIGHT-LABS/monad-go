import { useScaffoldReadContract } from "./scaffold-eth";

export function useOrderList(customerAddress?: string) {
  return useScaffoldReadContract({
    contractName: "Protocol",
    functionName: "orderMap",
    args: [customerAddress ? BigInt(customerAddress) : BigInt(0)],
  });
}
