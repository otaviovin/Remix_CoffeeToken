//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// The example below shows how the function payable works with condition, it can be used to
// sell something in a marketplace, for example, define a value os a product, if the value transfered is
// correct than returns the message "you bought", if the value is not correct, than returns
// the message "you have to pay the right value, aborting"

contract sampleContract {
    string public myString = "Hello World";

    //the function "payable" the contract is allowed to receive Ethers,
    //without this function we can not transfer Ether by this contract
    function updateString(string memory _newString) public payable {
        //msg.value: value of the transaction
        //msg.sender: address that is sending the value of the transaction
        if (msg.value == 1 ether) {
            //if the value of the transfer is 1 ether the string is changed when try to transact
            //the _newString
            myString = _newString;
        } else {
            //if the value of the transfer is different of 1 ether, than the
            //string is not updated to the string os the _newString
            payable (msg.sender).transfer(msg.value);
        }
    }
}