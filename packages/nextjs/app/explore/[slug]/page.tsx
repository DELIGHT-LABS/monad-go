"use client";

import { use, useState } from "react";
import Link from "next/link";
import { useMenu } from "~~/hooks/useMenu";
import { useStoreList } from "~~/hooks/useStoreList";

interface Props {
  params: Promise<{ slug: string }>;
}

export interface Menu {
  index: string;
  name: string;
  price: number;
}

const Store = ({ params }: Props) => {
  const { slug: storeAddress } = use(params);
  const { data: menuList } = useMenu(storeAddress);
  const { data: storeList } = useStoreList();

  const store = storeList?.find(store => store.addr === storeAddress);

  const [selectedMenu, setSelectedMenu] = useState<Menu[]>([]);

  return (
    <>
      <div className="text-center mt-8 bg-primary p-10">
        <h1 className="text-4xl my-0">{store?.name}</h1>
      </div>

      <div className="flex flex-col items-center">
        <ol className="list-inside">
          {menuList?.map(({ description, image_url, index, name, price }) => (
            <li
              key={index}
              className="my-2 border-2 border-secondary rounded-2xl  hover:bg-secondary rounded-2xl py-2 w-full px-20"
            >
              <button
                className="text-blue-500 hover:underline "
                onClick={() =>
                  setSelectedMenu(prev => [
                    ...prev,
                    {
                      index: index.toString(),
                      name,
                      price: Number(price),
                    },
                  ])
                }
              >
                <h2>{name}</h2>
                <p>{description}</p>
                <p>Price: {price}</p>
                {image_url && <img src={image_url} alt={name} className="w-32 h-32 object-cover" />}
              </button>
            </li>
          ))}
        </ol>

        <div className="fixed bottom-0 left-0 right-0 bg-primary p-4 text-center flex justify-between">
          <div>
            <div>selected {selectedMenu.length}</div>
            <div>total price: {selectedMenu.reduce((acc, cur) => acc + Number(cur.price), 0)}</div>
          </div>
          <Link
            href={{
              pathname: "/explore/order",
              query: { slug: storeAddress, menuList: JSON.stringify(selectedMenu) },
            }}
            className="bg-secondary text-white px-4 py-2 rounded"
          >
            Order
          </Link>
        </div>
      </div>
    </>
  );
};

export default Store;
