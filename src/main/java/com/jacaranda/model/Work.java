package com.jacaranda.model;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Trabajo")
public class Work {

	@Id 
	@ManyToOne
	@JoinColumn(name="nombre_persona")
	private Character character;
	
	@Id
	@ManyToOne
	@JoinColumn(name="cip")
	private Film film;

	@Id
	@ManyToOne
	@JoinColumn(name="tarea")
	private Task task;
	
	public Work() {
		super();
	}

	public Work(Character character, Film film, Task task) {
		super();
		this.character = character;
		this.film = film;
		this.task = task;
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
	
	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	@Override
	public int hashCode() {
		return Objects.hash(character, film);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Work other = (Work) obj;
		return Objects.equals(character, other.character) && Objects.equals(film, other.film);
	}
	
	
	
}
