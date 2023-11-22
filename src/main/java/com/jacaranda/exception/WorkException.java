package com.jacaranda.exception;

public class WorkException extends Exception {

	private static final long serialVersionUID = 1L;

	public WorkException() {
	}

	public WorkException(String message) {
		super(message);
	}

	public WorkException(Throwable cause) {
		super(cause);
	}

}
