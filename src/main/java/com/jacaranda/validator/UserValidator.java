package com.jacaranda.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserValidator {

	//This will be used for username, name and surname
	public static boolean isValidName(String name) {
		Pattern pattern = Pattern.compile("^[A-Z]");
		Matcher matcher = pattern.matcher(name);
		return matcher.find();
	}
	
	public static boolean isValidEmail(String email) {
		Pattern pattern = Pattern.compile("^(([^<>()\\].,;:\\s@\"]+(\\.[()\\[\\\\.,;:\\s@\"]+)*)|(\".+\"))@(([0-9]1,3\\.[0-9]1,3\\.[0-9]1,3\\.[0-9]1,3)|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$");
		Matcher matcher = pattern.matcher(email);
		return matcher.find();
	}
	
	public static boolean isValidPassword(String pass) {
		Pattern pattern = Pattern.compile("^(?=.*[A-z])(?=.*[0-9])(?=.*[¿?¡!@\\_\\-#\\$%\\^&*])(?=.{6,})");
		Matcher matcher = pattern.matcher(pass);
		return matcher.find();
	}
}
