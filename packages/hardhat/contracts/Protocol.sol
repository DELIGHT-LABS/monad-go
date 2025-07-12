pragma solidity ^0.8.0;

import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
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
    uint256 index;
    address store_address;
    string name;
    string description;
    int256 price;
    string image_url;
}

struct Order {
    uint256 index;
    int256[] menu;
    int256 total_price;
    int256 request_index;
    int256 delivery_fee;
}

struct Deliver {
    string name;
    address addr;
}

struct Delivery_Request {
    uint256 index;
    address user_addr;
    address store_addr;
    address deliver_addr;
    uint256 order_index;
}

contract Protocol is IProtocol, Initializable, OwnableUpgradeable {
    // 지불 토큰 주소
    address public pay_token_address;

    Store[] public stores;
    mapping(address => User) public userMap;
    mapping(address => Store) public storeMap;
    mapping(address => Deliver) public deliverMap;
    // store address로 menu index의 list매핑
    mapping(address => Menu[]) public storeMenuMap;

    // 요청한 유저의 주소 -> delivery_request index[]
    mapping(address => uint256[]) public userOrderMap;
    // order index -> order
    mapping(uint256 => Order) public orderMap;
    // delivery_requset index
    mapping(uint256 => Delivery_Request) public deliveryRequestMap;
    // delivery request index
    uint256[] public pending_delivery;

    function initialize(address _pay_token_address) public initializer {
        __Ownable_init(msg.sender);
        pay_token_address = _pay_token_address;
    }

    function registerUser(string calldata name, string calldata location, int256 pos) external override {
        require(bytes(userMap[msg.sender].name).length == 0, "User already registered");
        
        userMap[msg.sender] = User({
            name: name,
            addr: msg.sender,
            location: location,
            pos: pos
        });
    }

    function getStores() public view returns(Store[] memory) {
        return stores;
    }

    function registerStore(string calldata name, string calldata description, string calldata location, int256 pos) external override {
        require(bytes(storeMap[msg.sender].name).length == 0, "Store already registered");

        storeMap[msg.sender] = Store({
            name: name,
            description: description,
            addr: msg.sender,
            location: location,
            pos: pos
        });

        stores.push(storeMap[msg.sender]);
    }
    function registerDeliver(string calldata name) external override {
        require(bytes(deliverMap[msg.sender].name).length == 0, "Deliver already registered");

        deliverMap[msg.sender] = Deliver({
            addr: msg.sender,
            name: name
        });
    }

    function addMenu(string calldata name, string calldata description, int256 price, string calldata image_url) external override {
        require(bytes(storeMap[msg.sender].name).length != 0, "Not found stores");

        storeMenuMap[msg.sender].push(Menu({
            index: storeMenuMap[msg.sender].length+1,
            name: name,
            store_address: msg.sender,
            description: description,
            price: price,
            image_url: image_url
        }));
    }

    function getStoreMenu(address store_address) public view returns(Menu[] memory) {
        return storeMenuMap[store_address];
    }

    function removeMenu(int256 menu_index) external override {
        revert("Unimplemented");
    }
    function removeUser(address user_addr) external override {
        revert("Unimplemented");
    }
    function removeStore(address user_addr) external override {
        revert("Unimplemented");
    }
    function removeDelivery(address user_addr) external override {
        revert("Unimplemented");
    }
    function order(int256[] calldata menu_index) external payable override {
        revert("Unimplemented");
    }
    function approveDelivery(int256 delivery_request_index) external override {
        revert("Unimplemented");
    }
    function confirmOrder(int256 order_index) external override {
        revert("Unimplemented");
    }
}