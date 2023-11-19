package com.jacaranda.model;

import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

public class CharacterFilm {

	@Id 
	@ManyToOne
	@JoinColumn(name="idCharacter")
	private Character character;
	
	@Id
	@ManyToOne
	@JoinColumn(name="idFilm")
	private Film film;

	public CharacterFilm() {
		super();
	}

	public CharacterFilm(Character character, Film film) {
		super();
		this.character = character;
		this.film = film;
	}

	public Character getCharacter() {
		return character;
	}

	public void setCharacter(Character character) {
		this.character = character;
	}

	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) {
		this.film = film;
	}
	
}
