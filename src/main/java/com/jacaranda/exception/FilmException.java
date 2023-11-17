package com.jacaranda.exception;

public class FilmException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public FilmException() {
	}

	public FilmException(String message) {
		super(message);
	}

	public FilmException(Throwable cause) {
		super(cause);
	}

	public FilmException(String message, Throwable cause) {
		super(message, cause);
	}

}
