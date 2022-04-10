# How to use the system

## Contract Deployment

1. Deploy TicketAgreementV202204 contract. Note down it's address
2. Deploy Airline contract. Note down it's address
3. Execute 'setTicketAgreement' method on Airline contract by passing TicketAgreementV202204 contract's address noted above
5. Deploy customer contract
6. Execute 'setAirline' method on Customer contract by passing Airline contract's address noted above

## Airline Contract

1. addFlight - To add a flight in the system. **Note:** A flight must be added in the system to make it available for the booking
2. setTicketAgreement - Sets the address of ticket agreement contract that will be assigned to the new tickets

## Customer Contract

1. setAirline - Sets the address of airline contract
2. buyTicket - Allows user to buy the ticket
