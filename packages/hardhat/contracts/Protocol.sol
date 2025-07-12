pragma solidity ^0.8.0;

import "./interface/IProtocol.sol";

struct User {
    string name;
    address addr;
    string location;
    int256 pos;
}

struct Store {
    address addr;
    string location;
    int256 pos;
    string name;
    string description;
}

struct Menu {
    int256 index;
    address store_address;
    string name;
    string description;
    int256 price;
    string image_url;
}

struct Order {
    int256 index;
    int256[] menu;
    int256 total_price;
    int256 request_index;
}

struct Deliver {
    string name;
    address addr;
}

struct Delivery_Request {
    int256 index;
    address user_addr;
    address store_addr;
    address deliver_addr;
    int256 order_index;
}

contract Protocol is IProtocol {
    // 지불 토큰 주소
    address public pay_token_address;
    address public owner;

    mapping(address => User) public userMap;
    mapping(address => Store) public storeMap;
    mapping(address => Deliver) public deliverMap;
    // store address로 menu index의 list매핑
    mapping(address => Menu[]) public storeMenuMap;

    // 요청한 유저의 주소 -> delivery_request index[]
    mapping(address => int256[]) public orderMap;
    mapping(int256 => Delivery_Request) public deliveryRequestMap;
    // delivery request index
    int256[] public pending_delivery;
}