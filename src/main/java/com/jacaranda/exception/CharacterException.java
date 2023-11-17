package com.jacaranda.exception;

public class CharacterException extends Exception {


	private static final long serialVersionUID = 1L;

	
	public CharacterException() {
	}

	public CharacterException(String message) {
		super(message);
	}

	public CharacterException(Throwable cause) {
		super(cause);
	}

	public CharacterException(String message, Throwable cause) {
		super(message, cause);
	}

}
