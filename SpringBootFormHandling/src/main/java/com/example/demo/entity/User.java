package com.example.demo.entity;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class User {

	@Size(min = 3, max = 50)
	private String name;
	
	@Email(message = "Please enter a valid email address")
	@NotBlank
	private String email;
	
	@NotBlank
	private String gender;
	
	@NotBlank
	@Size(min = 8, max = 15)
	private String password;
	
	@NotBlank
	private String profession;
	
	@Size(max = 100)
	private String note;
	
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date birthday;
	
	@AssertTrue
	private boolean married;
	
	@Max(value = 300_000)
	@Min(value = 20_000)
	private long income;
}
