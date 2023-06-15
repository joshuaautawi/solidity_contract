// SPDX-Licence-Indentifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom{
    //Ether payment
    //Modifier
    //Visibility
    //Events
    event Occupy(address _occupant, uint _value);
    //Enums
    enum Statuses { 
        Vacant,
        Occupied
    }

    Statuses public currentStatus;

    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    //check status
    modifier whileVacant{
        require(currentStatus == Statuses.Vacant,"Currently occupied");
        _;
    }

    //check price
    modifier costs(uint _amount){
        require(msg.value >= _amount,"Not enough ehter provided");
        _;
    }


    function book()public payable whileVacant costs(2 ether){
        owner.transfer(msg.value);
        currentStatus = Statuses.Occupied;

        emit Occupy(msg.sender, msg.value);
    }
}