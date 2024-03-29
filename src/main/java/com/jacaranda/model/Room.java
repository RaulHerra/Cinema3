package com.jacaranda.model;

import java.util.List;
import java.util.Objects;

import com.jacaranda.exception.RoomException;
import com.jacaranda.repository.RoomRepository;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
	
	@OneToMany(mappedBy = "room")
	private List<Projection> projections;
	
	private static final int MIN_CAPACITY = 20;
	private static final int MIN_ROOM_NUMBER= 0;
	
	public Room() {
		super();
	}

	public Room(Cinema cinema, int roomNumber, int capacity) throws RoomException {
		super();
		setCinema(cinema);
		setRoomNumber(roomNumber);
		setCapacity(capacity);
	}
	
	/**
	 * ONLY USE TO SEARCH BY OBJECT 
	 * @param cinema
	 * @param roomNumber
	 * @throws RoomException
	 */
	public Room(Cinema cinema, int roomNumber) throws RoomException {
		this(cinema, roomNumber,21);
	}
	
	

	public Cinema getCinema() {
		return cinema;
	}

	public void setCinema(Cinema cinema) throws RoomException {
		if(cinema == null) throw new RoomException("Cinema can't be null");
		this.cinema = cinema;
	}

	public int getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(int roomNumber) throws RoomException {
		if(roomNumber < MIN_ROOM_NUMBER ) throw new RoomException("Room number should be higher than 0");
		this.roomNumber = roomNumber;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) throws RoomException {
		if(capacity <= MIN_CAPACITY) throw new RoomException("Capacity should be higher or equal to 20");
		this.capacity = capacity;			
	}
	
	public List<Projection> getProjections() throws Exception {
		return RoomRepository.getProjections(cinema,roomNumber);
	}

	public void setProjections(List<Projection> projections) {
		this.projections = projections;
	}

	
	@Override
	public int hashCode() {
		return Objects.hash(cinema, roomNumber);
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
		return Objects.equals(cinema, other.cinema) && roomNumber == other.roomNumber;
	}

	@Override
	public String toString() {
		return "Room : cinema=" + cinema.getCinema() + ": roomNumber=" + roomNumber + ": capacity=" + capacity ;
	}
	
	
}