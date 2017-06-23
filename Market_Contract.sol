pragma solidity >= 0.4.10;
contract Market {
    
    /* Status enum for the 3 possible states */
    enum Status { OFFERED, TAKEN, CONFIRMED}
    
    event OfferAdded(uint id, string product, uint price);
    event OfferTaken(uint id);
    event OfferConfirmed(uint id);

    /* Struct for storing an offer */
    struct Offer {
        string name;
        uint price;
        address taker;
        Status status;
    }
    
    Offer[] public Offers;
    
    
    /// @dev add a new offer
    /// @param product_ product name
    /// @param price_ price in wei
    /// @return id of the new offer
    
    function addOffer(string product_, uint price_) returns (uint id) {
        var new_offer = Offer({name: product_, price: price_, taker: 0, status: Status.OFFERED});
        uint offer_id = Offers.length;
        Offers.push(new_offer);
        OfferAdded(offer_id,Offers[offer_id].name,Offers[offer_id].price);
        return offer_id;
    }
    
    /// @dev take a offer
    /// @param id id of the offer
    function takeOffer(uint id) payable {
        require(msg.value == Offers[id].price && Offers[id].status == Status.OFFERED);
        Offers[id].taker = msg.sender;
        Offers[id].status = Status.TAKEN;
        OfferTaken(id);
    }
    
    /// @dev confirm a shipment
    /// @param id id of the offer
    function confirm(uint id) {
        require(msg.sender == Offers[id].taker && Offers[id].status == Status.TAKEN);
        Offers[id].status = Status.CONFIRMED;
        OfferConfirmed(id);
    }
    
}

