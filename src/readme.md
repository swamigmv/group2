# Terms used in the system

1. Settle ticket - It is the process of calculating the refund amount to the customer, calculating amount to be paid to the airline and settling the ticket by making payments to the customer and airline from Escrow contract
2. Ticket agreement - It is the contract that contains the business rules for computing refund amount to the customer and amount to be paid to the airline

# How to use the system

## Contract Deployment

1. Deploy TicketAgreementV202204 contract. Note down it's address
2. Deploy Airline contract. Note down it's address
3. Execute 'setTicketAgreement' method on Airline contract by passing TicketAgreementV202204 contract's address noted above
4. Execute 'setWallet' method on Airline contract by passing miner 1 or miner 2 address. This address will be used as wallet for the airline
5. Deploy customer contract
6. Execute 'setAirline' method on Customer contract by passing Airline contract's address noted above

## Add Flight

Miner can add a flight in the system by performing below steps:
1. Using one of the miner account, execute "addFlight" method on "Airline" contract
2. Use Unix epoach time for specifying departure time of the flight

## Book Ticket

If customer wants to buy a ticket, then below steps need to be performed:
1. Using one of the customer account, execute "buyTicket" method on "Customer" contract
2. The flight must be added in the system to make it available for the booking
3. Use Unix epoach time for specifying departure time of the flight
4. The amount is deducted from customer account and credited to Escrow contract instance that is being created for the ticket. Airline **doesn't** receive fund at this stage
4. **Keep the ticket address returned by the method handy. It will be required for cancellation or settlment**

## Update Flight Departure Time

If flight's departure time is changed, then below steps need to be performed:
1. Using one of the miner account, execute "updateFlightDeparture" method on "Airline" contract
2. Use Unix epoach time for specifying original and new departure time of the flight
3. The method updates the flight status depending on the new departure time i.e. if new departure time is later than the original time, then flight is marked as delayed

## Cancelling the Flight

If flight is cancelled, then below steps need to be performed:
1. Using one of the miner account, execute "cancelFlight" method on "Airline" contract
2. Use Unix epoach time for specifying original departure time of the flight
3. The method marks the flight cancelled and refunds the ticket amount to the customer

## Cancelling the ticket

If customer wants to cancel the ticket, then below steps need to be performed:
1. Using customer account, execute "cancelTicket" method on "Customer" contract
2. Pass the address of the ticket returned by the system while booking it, as a parameter to the above method
3. The method marks the ticket cancelled. The method, based on the timing of the cancellation, refunds the amount to the customer and pays the amount to airline

## Departing the Flight

If airline wants to update the flight as departed, then below steps need to be performed:
1. Using one of the miner account, execute "departFlight" method on "Airline" contract
2. Use Unix epoach time for specifying actual departure time of the flight
3. The method marks the flight departed and pays the ticket amount to the airline. If flight is delayed then depending on the delay, some amount is refunded to the customer and remaining amount is paid to the airline

## Settling the Ticket

Typically this method will be executed by the customer incase airline doesn't update the status of the flight as departed. In this situation the funds are with Escrow account. Customer can claim refund by performing below steps if any refund is applicable:
1. Using customer account, execute "settleTicket" method on "Customer" contract
2. Pass the address of the ticket returned by the system while booking it, as a parameter to the above method
3. The method checks actual depature time is passed. If passsed then pays the ticket amount to the airline and refunded to the customer by applying the business rules

## Getting the Ticket Details

Anyone can get ticket details by performing below steps:
1. Using any account, execute "getTicket" method on "Customer" contract
2. Pass the address of the ticket returned by the system while booking it, as a parameter to the above method
3. The method returns ticket information/details

## Getting the Ticket Details

Anyone can get ticket details by performing below steps:
1. Using any account, execute "getTicket" method on "Customer" contract
2. Pass the address of the ticket returned by the system while booking it, as a parameter to the above method
3. The method returns ticket information/details

## Getting the address of Aireline Wallet

To get the wallet address configured for the airline, perform the below steps:
1. Using any account, execute "getWallet" method on "Airline" contract
2. The method returns address configured as wallet for the airline

## Getting the address of Flight and active Ticket Agreement

To get the flight address and configured ticket agreement address, perform the below steps:
1. Using miner account, execute "getTicketBookingConfiguration" method on "Airline" contract
2. The method returns the flight address and configured ticket agreement address
