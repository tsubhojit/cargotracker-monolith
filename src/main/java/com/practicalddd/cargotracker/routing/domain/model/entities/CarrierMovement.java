package com.practicalddd.cargotracker.routing.domain.model.entities;


import javax.persistence.*;

import com.practicalddd.cargotracker.handling.domain.model.valueobjects.Location;

import java.util.Date;

@Entity
@Table(name="carrier_movement")
public class CarrierMovement {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Temporal(TemporalType.DATE)
    @Column(name="arrival_date")
    private Date arrivalDate;
    @Temporal(TemporalType.DATE)
    @Column(name="departure_Date")
    private Date departureDate;
    @Embedded
    @AttributeOverride(name = "unLocCode", column = @Column(name = "arrival_location_id"))
    private Location arrivalLocation;
    @Embedded
    @AttributeOverride(name = "unLocCode", column = @Column(name = "departure_location_id"))
    private Location departureLocation;

    public CarrierMovement(){}

    public CarrierMovement(Location departureLocation,
                           Location arrivalLocation, Date departureDate, Date arrivalDate) {

        this.departureDate = departureDate;
        this.arrivalDate = arrivalDate;
        this.departureLocation = departureLocation;
        this.arrivalLocation = arrivalLocation;
    }

    public Location getDepartureLocation() {
        return departureLocation;
    }

    public Location getArrivalLocation() {
        return arrivalLocation;
    }

    public Date getDepartureDate() {
        return this.departureDate;
    }

    public Date getArrivalDate() {
        return this.arrivalDate;
    }


}
