"use client";

import Link from "next/link";
import type { NextPage } from "next";
import { useStoreList } from "~~/hooks/useStoreList";

const Explore: NextPage = () => {
  const { data: storeList } = useStoreList();

  return (
    <div>
      <div className="text-center mt-8 bg-primary p-10">
        <h1 className="text-4xl my-0">Explore</h1>
      </div>

      <ol className="list-decimal list-inside">
        {storeList?.map(({ addr, description, location, name, pos }) => (
          <li key={addr} className="my-2">
            <Link href={`/explore/${addr}`} className="text-blue-500 hover:underline flex flex-col">
              <h2>{name}</h2>
              <p>{description}</p>
              <p>Location: {location}</p>
              <p>Position: {pos.toString()}</p>
            </Link>
          </li>
        ))}
      </ol>
    </div>
  );
};

export default Explore;
