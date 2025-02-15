package com.spring.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.spring.model.AccountBean;
import com.spring.model.CinemaBean;
import com.spring.model.ShowtimeBean;
import com.spring.model.StateBean;
import com.spring.model.TownshipBean;
import com.spring.repository.CinemaRepository;
import com.spring.repository.ShowtimeRepository;
import com.spring.repository.StateRepository;
import com.spring.repository.TownshipRepository;

@Controller
@RequestMapping("cinema")
public class CinemaController {

	@Autowired
	CinemaRepository cinemaRepo;

	@Autowired
	StateRepository stateRepo;

	@Autowired
	TownshipRepository townshipRepo;

	@Autowired
	ShowtimeRepository showtimeRepo;

	@GetMapping("/cinemaList")
	public ModelAndView showCinemas() {
		List<CinemaBean> cinemaList = cinemaRepo.getAllCinema();
		ModelAndView mav = new ModelAndView("cinemaList");
		mav.addObject("cinemaList", cinemaList);
		return mav;
	}

	@GetMapping("/addCinema")
	public ModelAndView showAddCinemaForm(@ModelAttribute("cinemaObj") CinemaBean obj, Model m) {
		List<StateBean> stateList = stateRepo.getAllState();
		List<TownshipBean> townshipList = townshipRepo.getAllTownship();
		List<ShowtimeBean> showtimeList = showtimeRepo.getAllShowtime();
		m.addAttribute("stateList", stateList);
		m.addAttribute("townshipList", townshipList);
		m.addAttribute("showtimeList", showtimeList);

		Gson gson = new GsonBuilder().create();
		String townshipJson = gson.toJson(townshipList);
		m.addAttribute("townshipJson", townshipJson);

		return new ModelAndView("addCinema", "cinemaObj", obj); // This will have the flash attributes (if any)
	}

	@PostMapping("/addCinema")
	public ModelAndView addCinema(@Validated @ModelAttribute("cinemaObj") CinemaBean obj, BindingResult br, Model m) {
		if (br.hasErrors()) {
			List<StateBean> stateList = stateRepo.getAllState();
			List<TownshipBean> townshipList = townshipRepo.getAllTownship();
			List<ShowtimeBean> showtimeList = showtimeRepo.getAllShowtime();
			m.addAttribute("stateList", stateList);
			m.addAttribute("townshipList", townshipList);
			m.addAttribute("showtimeList", showtimeList);

			String townshipJson = convertListToJson((List<TownshipBean>) townshipList); // Convert the list to JSON
			m.addAttribute("townshipJson", townshipJson); // Add the JSON string to the model

			return new ModelAndView("addCinema", "cinemaObj", obj);
		}

		System.out.println("selected showtime ids : " + obj.getSelectedShowtimeList());

		int generatedId = cinemaRepo.addNewCinema(obj);
		if (generatedId != -1) {
			cinemaRepo.updateCinemaShowtimes(generatedId, obj.getSelectedShowtimeList());
		}

		return new ModelAndView("redirect:cinemaList");
	}

	@GetMapping("cinemaDetail/{cinemaId}")
	public String showCinemaDetail(@PathVariable("cinemaId") int cinemaId, Model model) {
		CinemaBean cinemaObj = cinemaRepo.getCinemaById(cinemaId);
		List<ShowtimeBean> showtimeList = showtimeRepo.getShowtimeByCinemaId(cinemaId);

		model.addAttribute("cinemaObj", cinemaObj);
		model.addAttribute("showtimeList", showtimeList);
		return "cinemaDetail";
	}

	@GetMapping("editCinemaInfo/{cinemaId}")
	public ModelAndView showEditCinemaForm(@PathVariable("cinemaId") int cinemaId, Model m) {
		List<StateBean> stateList = stateRepo.getAllState();
		List<TownshipBean> townshipList = townshipRepo.getAllTownship();
		List<ShowtimeBean> showtimeList = showtimeRepo.getAllShowtime();
		m.addAttribute("stateList", stateList);
		m.addAttribute("townshipList", townshipList);
		m.addAttribute("showtimeList", showtimeList);

		Gson gson = new GsonBuilder().create();
		String townshipJson = gson.toJson(townshipList);
		m.addAttribute("townshipJson", townshipJson);

		CinemaBean cinemaObj = cinemaRepo.getCinemaById(cinemaId);
		cinemaObj.setSelectedShowtimeList(showtimeRepo.getShowtimeByCinemaId(cinemaId).stream().map(ShowtimeBean::getId)
				.collect(Collectors.toList()));

		m.addAttribute("cinemaObj", cinemaObj);

		return new ModelAndView("editCinemaInfo", "cinemaObj", cinemaObj);
	}

	@PostMapping("/editCinema")
	public ModelAndView editCinema(@Validated @ModelAttribute("cinemaObj") CinemaBean obj, BindingResult br, Model m) {
		if (br.hasErrors()) {
			List<StateBean> stateList = stateRepo.getAllState();
			List<TownshipBean> townshipList = townshipRepo.getAllTownship();
			List<ShowtimeBean> showtimeList = showtimeRepo.getAllShowtime();
			m.addAttribute("stateList", stateList);
			m.addAttribute("townshipList", townshipList);
			m.addAttribute("showtimeList", showtimeList);

			String townshipJson = convertListToJson((List<TownshipBean>) townshipList); // Convert the list to JSON
			m.addAttribute("townshipJson", townshipJson); // Add the JSON string to the model

			return new ModelAndView("editCinemaInfo", "cinemaObj", obj);
		}

		System.out.println("selected showtime ids : " + obj.getSelectedShowtimeList());
		
		  int result = cinemaRepo.updateCinema(obj); 
		  if (result != -1) {
			  cinemaRepo.updateCinemaShowtimes(obj.getId(), obj.getSelectedShowtimeList());
		  }
		 
		return new ModelAndView("redirect:cinemaList");
	}

	@GetMapping("manageSeats/{cinemaId}")
	public String showManageSeatsForm(@PathVariable("cinemaId") int cinemaId, Model model) {
		CinemaBean cinemaObj = cinemaRepo.getCinemaById(cinemaId);
		model.addAttribute("cinemaObj", cinemaObj);
		return "manageSeats";
	}
	
	@GetMapping("hardDeleteCinema/{cinemaId}")
	public ModelAndView hardDeleteCinema(@PathVariable("cinemaId") int cinemaId, Model model) {
		
		int result = cinemaRepo.hardDeleteCinema(cinemaId);
		
		return new ModelAndView("redirect:/cinema/cinemaList");
	}

	public <T> String convertListToJson(List<T> objList) {
		Gson gson = new GsonBuilder().create();
		return gson.toJson(objList);
	}

}
