booking=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargobooking -H 'Content-Type: application/json' -d '{
    "bookingAmount": 100,
    "originLocation": "USNYC",
    "destLocation" : "CNHKG",
    "destArrivalDeadline" : "2020-01-28"
}')
bookingId=$(echo `jq -r  .bookingId <<< "${booking}"`)
echo $bookingId

curl -s -X GET "https://$1/cargotracker/serviceapi/voyageRouting/optimalRoute?origin=USYNC&destination=CNHKG&deadline=2020-01-28" | jq

routing=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargorouting -H 'Content-Type: application/json' -d $booking)
echo $routing

receive=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "USNYC",
    "handlingType" : "RECEIVE",
    "completionTime": "2020-01-14",
    "voyageNumber" : ""
}')
echo $receive

firstload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "USNYC",
    "handlingType" : "LOAD",
    "completionTime": "2020-01-15",
    "voyageNumber" : "0104S"
}')
echo $firstload

firstunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "JNTKO",
    "handlingType" : "UNLOAD",
    "completionTime": "2020-01-17",
    "voyageNumber" : "0104S"
}')
echo $firstunload

secondload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "JNTKO",
    "handlingType" : "LOAD",
    "completionTime": "2020-01-19",
    "voyageNumber" : "0105S"
}')
echo $secondload

secondunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHGH",
    "handlingType" : "UNLOAD",
    "completionTime": "2020-01-21",
    "voyageNumber" : "0105S"
}')
echo $secondunload

thirdload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHGH",
    "handlingType" : "LOAD",
    "completionTime": "2020-01-23",
    "voyageNumber" : "0106S"
}')
echo $thirdload

thirdunload=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHKG",
    "handlingType" : "UNLOAD",
    "completionTime": "2020-01-25",
    "voyageNumber" : "0106S"
}')
echo $thirdunload

customs=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHKG",
    "handlingType" : "CUSTOMS",
    "completionTime": "2020-01-26",
    "voyageNumber" : ""
}')
echo $customs

claim=$(curl -s -X POST https://$1/cargotracker/serviceapi/cargohandling -H 'Content-Type: application/json' -d '{
    "bookingId" : "'$bookingId'",
    "unLocode" : "CNHKG",
    "handlingType" : "CLAIM",
    "completionTime": "2020-01-27",
    "voyageNumber" : ""
}')
echo $claim