package com.jacaranda.model;

import java.sql.Date;
import java.util.Objects;

import com.jacaranda.exception.ProjectionException;
import com.jacaranda.exception.RoomException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Proyeccion")
public class Projection {
	
	@Id
	@ManyToOne
	@JoinColumns({@JoinColumn(name="sala"),@JoinColumn(name="cine")})
	private Room room;
	
	@Id
	@ManyToOne
	@JoinColumn(name="cip")
	private Film film;
	
	@Id
	@Column(name="fecha_estreno")
	private Date premiereDate;
	
	@Column(name="dias_estreno")
	private int premiereDays;
	
	@Column(name="espectadores")
	private int spectators;
	
	@Column(name="recaudacion")
	private int income;

	public Projection(Room room, Film film, Date premiere_date, int premiere_days, int spectators,
			int income) throws ProjectionException {
		super();
		setRoom(room);
		setFilm(film);
		setIncome(income);
		setPremieredate(premiere_date);
		setPremiereDays(premiere_days);
	}
	//Este constructor es para buscar el proyecto en infoProjection
	public Projection(Room room, Film film,Date premiere_date) throws ProjectionException {
		super();
		setRoom(room);
		setFilm(film);
		setPremieredate(premiere_date);
	}
	
	public Projection() {
		super();
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) throws ProjectionException {
		if(room == null) {
			throw new ProjectionException("Room cant be null");
		}
		this.room = room;
	}

	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) throws ProjectionException {
		if(film == null) {
			throw new ProjectionException("Film cant be null");
		}
		this.film = film;
	}

	public Date getPremieredate() {
		return premiereDate;
	}

	public void setPremieredate(Date premiereDate) throws ProjectionException {
		if(premiereDate == null) {
			throw new ProjectionException("Premiere date cant be null");
		}
		this.premiereDate = premiereDate;
	}

	public int getPremiereDays() {
		return premiereDays;
	}

	public void setPremiereDays(int premiereDays) throws ProjectionException {
		if(premiereDays <= 0) {
			throw new ProjectionException("Release days must be greater than 0");
		}
		this.premiereDays = premiereDays;
	}

	public int getSpectators() {
		return spectators;
	}

	public void setSpectators(int spectators) throws ProjectionException {
		if(spectators <= 0) {
			throw new ProjectionException("Spectators days must be greater than 0");
		}
		this.spectators = spectators;
	}

	public int getIncome() {
		return income;
	}

	public void setIncome(int income) throws ProjectionException {
		if(income <= 0) {
			throw new ProjectionException("Income days must be greater than 0");
		}
		this.income = income;
	}

	@Override
	public int hashCode() {
		return Objects.hash(film, premiereDate, room, premiereDate);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Projection other = (Projection) obj;
		return Objects.equals(film, other.film) && Objects.equals(premiereDate, other.premiereDate) && Objects.equals(room, other.room);
	}

	@Override
	public String toString() {
		return "Projection [room=" + room.getRoomNumber() + ", cip=" + film.getCip() + ", premiere_date=" + premiereDate
				+ ", premiere_days=" + premiereDays + ", spectators=" + spectators + ", income=" + income + "]";
	}
	
}
