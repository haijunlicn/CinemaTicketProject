package com.spring.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SeatBean {
	private int id;
    private int cinemaId;
    private String seatNum;
    private int row;
    private int col;
    private String seatType;
    private double price;
    private String currencyType;
    private int status;
}
