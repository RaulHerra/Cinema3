package com.jacaranda.exception;

public class RoomException extends Exception {

	private static final long serialVersionUID = 1L;

	public RoomException() {
	}

	public RoomException(String message) {
		super(message);
	}

	public RoomException(Throwable cause) {
		super(cause);
	}

	public RoomException(String message, Throwable cause) {
		super(message, cause);
	}

	public RoomException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
