package com.spring.model;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountBean {
	private int id;

	@NotEmpty(message = "Name is required!")
	private String name;

	@NotEmpty(message = "Email is required!")
	@Email(message = "Invalid email format!")
	private String email;

	@NotEmpty(message = "Password is required")
	@Size(min = 3, message = "Password must be at least 3 characters")
	private String password;
	
	private int roleId;
	private int assignedCinemaId;
	private int status;
	
	private String roleTest;
}
