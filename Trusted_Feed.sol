pragma solidity >= 0.4.10;

contract Feed {
    
    address owner;
    uint value;

    /* event to be fired when the value changes */
    event Updated(uint value);
    
    /// @dev constructor, called at deployment
    /// @param initialValue the value after deployment
    function Feed(uint initialValue) {
        owner = msg.sender;
        value = initialValue;
        //update(initialValue);
    }
    
    modifier onlyOwner {
        if(msg.sender != owner){
            throw;
        }else{
            _;
        }
    }
    
    function getValue() payable returns (uint)  {
        require(msg.value >= 1 ether);//this throws if it is not true
        //send money to the owner
        owner.transfer(msg.value);
        return value;
    }
    
    /// @dev update the stored value
    /// @param value_ the new value
    function update(uint value_) onlyOwner {
        /* update the state if the sender is the creator */
        value = value_;
        Updated(value);
    }
    
}
