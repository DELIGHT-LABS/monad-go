// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IProtocol {
    // user, 가게, deliver 등록
    function registerUser(string calldata name, string calldata location, int256 pos) external;
    function registerStore(string calldata name, string calldata description, string calldata location, int256 pos) external;
    function registerDeliver(string calldata name) external;

    // 메뉴 등록
    function addMenu(string calldata name, string calldata description, int256 price, string calldata image_url) external;

    // user, store, deliver, menu 제거
    function removeMenu(int256 menu_index) external;
    function removeUser(address user_addr) external;
    function removeStore(address user_addr) external;
    function removeDelivery(address user_addr) external;

    function order(int256[] calldata menu_index) external payable;
    function approveDelivery(int256 delivery_request_index) external;

    function confirmOrder(int256 order_index) external;


    // event
    event OrderMenu(int256 order_index, int256 total_price, int256 delivery_fee);
    event ConfirmDelivery(int256 delivery_request_index, int256 order_index);
    event ConfirmOrder(
      address user_addr,
    address store_addr,
    address deliver_addr
    );
}