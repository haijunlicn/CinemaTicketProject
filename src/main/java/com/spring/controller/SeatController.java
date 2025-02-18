package com.spring.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.model.SeatBean;
import com.spring.repository.SeatRepository;

@Controller
@RequestMapping("/seats")
public class SeatController {
	@Autowired
	SeatRepository seatRepo;

	/*
	 * @GetMapping("/manageSeats/{cinemaId}") public String
	 * showSeatList(@PathVariable("cinemaId") int cinemaId, Model model) {
	 * List<SeatBean> seatList = seatRepo.getSeatsByCinemaId(cinemaId);
	 * 
	 * // Find max row and max col int maxRow = 0, maxCol = 0; for (SeatBean seat :
	 * seatList) { maxRow = Math.max(maxRow, seat.getRow()); maxCol =
	 * Math.max(maxCol, seat.getCol()); }
	 * 
	 * // Initialize 2D list List<List<SeatBean>> seatGrid = new ArrayList<>(); for
	 * (int i = 0; i <= maxRow; i++) { seatGrid.add(new
	 * ArrayList<>(Collections.nCopies(maxCol + 1, null))); }
	 * 
	 * // Populate the 2D list for (SeatBean seat : seatList) {
	 * seatGrid.get(seat.getRow()).set(seat.getCol(), seat); }
	 * 
	 * model.addAttribute("seatGrid", seatGrid); return "manageSeats"; }
	 */
	
	
	  @GetMapping("/manageSeats/{cinemaId}") public String
	  showProductList(@PathVariable("cinemaId") int cinemaId, Model model) {
	  List<SeatBean> seatList = seatRepo.getSeatsByCinemaId(cinemaId);
	  model.addAttribute("seatList", seatList);
	  
	  int maxRow = 0 , maxCol = 0; for (SeatBean seat : seatList) maxRow =
	  Math.max(maxRow, seat.getRow()); for (SeatBean seat : seatList) maxCol =
	  Math.max(maxCol, seat.getCol()); model.addAttribute("maxRow", maxRow);
	  model.addAttribute("maxCol", maxCol);
	  
	  return "manageSeats"; }
	 
}
