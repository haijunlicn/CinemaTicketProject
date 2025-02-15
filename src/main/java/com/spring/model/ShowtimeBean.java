package com.spring.model;

import java.sql.Time;
import java.time.LocalTime;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShowtimeBean {
	private int id;
	
	@NotNull(message = "Enter a start hour!")
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime localStartHour;
	
	@NotNull(message = "Enter an end hour!")
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime localEndHour;
	
	private Time startHour;
	
	private Time endHour;
	private int status;

	// Method to get formatted showtime in "HH:mm - HH:mm" format
	public String getFormattedShowtime() {
		String formattedStartHour = startHour.toString().substring(0, 5); // "HH:mm"
		String formattedEndHour = endHour.toString().substring(0, 5); // "HH:mm"
		return formattedStartHour + " - " + formattedEndHour;
	}
}