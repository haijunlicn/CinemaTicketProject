package com.spring.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.spring.model.CinemaBean;
import com.spring.model.ShowtimeBean;
import com.spring.model.StateBean;
import com.spring.model.TownshipBean;
import com.spring.repository.ShowtimeRepository;

@Controller
@RequestMapping("showtime")
public class ShowtimeController {
	@Autowired
	ShowtimeRepository showtimeRepo;

	@GetMapping("/showtimeList")
	public ModelAndView showCinemas() {
		List<ShowtimeBean> showtimeList = showtimeRepo.getAllShowtime();
		ModelAndView mav = new ModelAndView("showtimeList");
		mav.addObject("showtimeList", showtimeList);
		return mav;
	}

	@GetMapping("/addShowtime")
	public ModelAndView showAddCinemaForm(@ModelAttribute("showtimeObj") ShowtimeBean obj, Model m) {
		return new ModelAndView("addShowtime", "showtimeObj", obj);
	}

	@PostMapping("/addShowtime")
	public ModelAndView addCinema(@Validated @ModelAttribute("showtimeObj") ShowtimeBean obj, BindingResult br,
			Model m) {
		if (br.hasErrors()) {
			return new ModelAndView("addShowtime", "showtimeObj", obj);
		}

		showtimeRepo.addNewShowtime(obj);
		return new ModelAndView("redirect:showtimeList");
	}

	@GetMapping("editShowtime/{showtimeId}")
	public ModelAndView showEditShowtimeForm(@PathVariable("showtimeId") int showtimeId, Model m) {
		ShowtimeBean showtimeObj = showtimeRepo.getShowtimeById(showtimeId);
		return new ModelAndView("editShowtime", "showtimeObj", showtimeObj);
	}

	@PostMapping("/editShowtime")
	public ModelAndView editShowtime(@Validated @ModelAttribute("showtimeObj") ShowtimeBean obj, BindingResult br, Model m) {
		if (br.hasErrors()) {
			return new ModelAndView("editShowtime", "showtimeObj", obj);
		}
		int result = showtimeRepo.updateShowtime(obj);
		return new ModelAndView("redirect:showtimeList");
	}

}
