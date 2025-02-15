package com.spring.model;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CinemaBean {
	private int id;
	
	@NotEmpty(message = "Cinema name is required!")
	private String name;
	
	@NotNull(message = "Choose a township!")
	private Integer townshipId;
	private String townshipName;
	
	@NotNull(message = "Choose a state!")
	private Integer stateId;
	
	/* @NotEmpty(message = "Choose a state!") */
	private String stateName;
	private int totalSeats;
	private int rowCount;
	private int colCount;
	private String lat;
	private String lon;
	private int status;
	
	private List<Integer> selectedShowtimeList = new ArrayList<Integer>();
}
