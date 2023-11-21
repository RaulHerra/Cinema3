package com.jacaranda.model;

import java.sql.Date;
import java.util.Objects;

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
	private Film cip;
	
	@Id
	@Column(name="fecha_estreno")
	private Date premiere_date;
	
	@Column(name="dias_estreno")
	private int premiere_days;
	
	@Column(name="espectadores")
	private int spectators;
	
	@Column(name="recaudacion")
	private int income;

	public Projection(Cinema cinema, Room room, Film cip, Date premiere_date, int premiere_days, int spectators,
			int income) {
		super();
		this.room = room;
		this.cip = cip;
		this.premiere_date = premiere_date;
		this.premiere_days = premiere_days;
		this.spectators = spectators;
		this.income = income;
	}
	
	public Projection() {
		super();
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public Film getCip() {
		return cip;
	}

	public void setCip(Film cip) {
		this.cip = cip;
	}

	public Date getPremiere_date() {
		return premiere_date;
	}

	public void setPremiere_date(Date premiere_date) {
		this.premiere_date = premiere_date;
	}

	public int getPremiere_days() {
		return premiere_days;
	}

	public void setPremiere_days(int premiere_days) {
		this.premiere_days = premiere_days;
	}

	public int getSpectators() {
		return spectators;
	}

	public void setSpectators(int spectators) {
		this.spectators = spectators;
	}

	public int getIncome() {
		return income;
	}

	public void setIncome(int income) {
		this.income = income;
	}

	@Override
	public int hashCode() {
		return Objects.hash(cip, premiere_date, room);
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
		return Objects.equals(cip, other.cip) && Objects.equals(premiere_date, other.premiere_date) && Objects.equals(room, other.room);
	}

	@Override
	public String toString() {
		return "Projection [room=" + room + ", cip=" + cip + ", premiere_date=" + premiere_date
				+ ", premiere_days=" + premiere_days + ", spectators=" + spectators + ", income=" + income + "]";
	}
}
