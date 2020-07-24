booking=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargobooking -H 'Content-Type: application/json' -d '{
    "bookingAmount": 100,
    "originLocation": "CNHKG",
    "destLocation" : "USNYC",
    "destArrivalDeadline" : "2020-01-28"
}')
bookingId=$(echo `jq -r  .bookingId <<< "${booking}"`)
echo $bookingId

curl -s -X GET "https://$1/cargotracker/serviceapi/voyageRouting/optimalRoute?origin=CNHKG&destination=USNYC&deadline=2020-01-28" | jq

routing=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargorouting -H 'Content-Type: application/json' -d $booking)
echo $routing

receive=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHKG",
    "handlingType" : "RECEIVE",
    "completionTime": "2019-08-23",
    "voyageNumber" : ""
}')
echo $receive

firstload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHKG",
    "handlingType" : "LOAD",
    "completionTime": "2019-08-25",
    "voyageNumber" : "0100S"
}')
echo $firstload

firstunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHGH",
    "handlingType" : "UNLOAD",
    "completionTime": "2019-08-28",
    "voyageNumber" : "0100S"
}')
echo $firstunload

secondload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHGH",
    "handlingType" : "LOAD",
    "completionTime": "2019-09-01",
    "voyageNumber" : "0101S"
}')
echo $secondload

secondunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "JNTKO",
    "handlingType" : "UNLOAD",
    "completionTime": "2019-09-10",
    "voyageNumber" : "0101S"
}')
echo $secondunload

thirdload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "JNTKO",
    "handlingType" : "LOAD",
    "completionTime": "2019-09-15",
    "voyageNumber" : "0102S"
}')
echo $thirdload

thirdunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "USNYC",
    "handlingType" : "UNLOAD",
    "completionTime": "2019-09-25",
    "voyageNumber" : "0102S"
}')
echo $thirdunload

customs=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "USNYC",
    "handlingType" : "CUSTOMS",
    "completionTime": "2019-09-26",
    "voyageNumber" : ""
}')
echo $customs

claim=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "USNYC",
    "handlingType" : "CLAIM",
    "completionTime": "2019-09-28",
    "voyageNumber" : ""
}')
echo $claim