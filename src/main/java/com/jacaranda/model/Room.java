package com.jacaranda.model;

import java.util.Objects;

import com.jacaranda.exception.RoomException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table (name="Sala")
public class Room {
	
	
	@Id
	@ManyToOne
	@JoinColumn(name="cine")
	private Cinema cinema;
	
	
	@Id
	@Column(name="sala")
	private int roomNumber;
	
	@Column(name="aforo")
	private int capacity;
	
	
	
	public Room() {
	}



	public Room(Cinema cinema, int roomNumber, int capacity) throws RoomException {
		super();
		this.cinema = cinema;
		this.roomNumber = roomNumber;
		setCapacity(capacity);
	}






	public Cinema getCinema() {
		return cinema;
	}



	public void setCinema(Cinema cinema) {
		this.cinema = cinema;
	}



	public int getRoomNumber() {
		return roomNumber;
	}



	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}



	public int getCapacity() {
		return capacity;
	}



	public void setCapacity(int capacity) throws RoomException {
		if(capacity < 1) throw new RoomException("Capacidad de la sala no valida");
		this.capacity = capacity;			
	}
	
	
	
	

	@Override
	public int hashCode() {
		return Objects.hash(capacity, cinema);
	}
	
	
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Room other = (Room) obj;
		return capacity == other.capacity && Objects.equals(cinema, other.cinema);
	}



	@Override
	public String toString() {
		return "Room [cinema=" + cinema.getCinema() + ", roomNumber=" + roomNumber + ", capacity=" + capacity + "]";
	}
	
	
}
