package com.jacaranda.exception;

public class CinemaException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CinemaException() {
	}

	public CinemaException(String message) {
		super(message);
	}

	public CinemaException(Throwable cause) {
		super(cause);
	}


}
