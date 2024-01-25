// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;


contract DonationContract {

    error DonationContract__WetinBeThis();

    address private owner;

    uint256 public totalDonations;

    uint256 public donationsCount;

    struct Donation {
        uint256 value;
        uint256 time;
    }

    constructor() {
        owner = msg.sender;
    }


    mapping(address => Donation[]) public addressToAmountFunded;
    
    function donate() public payable {
        if(msg.value <= 0) {
            revert DonationContract__WetinBeThis();
        }
        Donation memory donation = Donation(msg.value, block.timestamp);
        donationsCount++;
        totalDonations = totalDonations + msg.value;
        addressToAmountFunded[msg.sender].push(donation);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function totalDonationsFromMe() public view returns(uint256){
        return addressToAmountFunded[msg.sender].length;
    }


    function allMyDonations() public view returns(uint256[] memory values,uint256[] memory dates) {
        uint256 count = totalDonationsFromMe();
        values = new uint256[](count);
        dates = new uint256[](count);

        for(uint256 i =0; i < count; i++) {
            Donation memory donation = addressToAmountFunded[msg.sender][i];
            values[i] = donation.value;
            dates[i] = donation.time;
        }

        return(values, dates);
    }

    receive() external payable {
        totalDonations = totalDonations + msg.value;
        donationsCount++;
}

}

