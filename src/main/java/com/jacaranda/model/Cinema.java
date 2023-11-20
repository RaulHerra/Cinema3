package com.jacaranda.model;

import java.util.List;
import java.util.Objects;

import com.jacaranda.exception.CinemaException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table (name ="Cine")
public class Cinema {
	
	private static final int MAX_LENGTH_ADDRESS_CINEMA = 65;
	private static final int MAX_LENGTH_CITY_CINEMA = 25;
	private static final int MAX_LENGTH_CINEMA = 25;

	@Id
	@Column(name = "cine")
	private String cinema;
	
	@Column(name = "ciudad_cine")
	private String cityCinema;
	
	@Column(name = "direccion_cine")
	private String addressCinema;
	
	@OneToMany(mappedBy = "cinema")
	private List<Room> rooms;
	
	public Cinema(String cinema, String cityCinema, String addressCinema) throws CinemaException {
		super();
		setCinema(cinema);
		setCityCinema(cityCinema);
		setAddressCinema(addressCinema);
	}

	public Cinema() {
		super();
	}

	public String getCinema() {
		return cinema;
	}

	public void setCinema(String cinema) throws CinemaException {
		if(cinema == null || cinema.length() > MAX_LENGTH_CINEMA) {
			throw new CinemaException("The length of the cinema name must be less than 25 characters and cannot be empty");
		}
		this.cinema = cinema;			
	}

	public String getCityCinema() {
		return cityCinema;
	}

	public void setCityCinema(String cityCinema) throws CinemaException {
		if(cityCinema == null || cityCinema.length() > MAX_LENGTH_CITY_CINEMA) {
			throw new CinemaException("The length of the movie city must be less than 25 characters and cannot be empty");
		}
		this.cityCinema = cityCinema;
	}

	public String getAddressCinema() {
		return addressCinema;
	}

	public void setAddressCinema(String addressCinema) throws CinemaException {
		if(addressCinema == null || addressCinema.length() > MAX_LENGTH_ADDRESS_CINEMA) {
			throw new CinemaException("The length of the cinema address must be less than 65 characters and cannot be empty");
		}
		this.addressCinema = addressCinema;
	}

	@Override
	public int hashCode() {
		return Objects.hash(cinema);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cinema other = (Cinema) obj;
		return Objects.equals(cinema, other.cinema);
	}

	@Override
	public String toString() {
		return "Cinema [cinema=" + cinema + ", cityCinema=" + cityCinema + ", addressCinema=" + addressCinema + "]";
	}

	public List<Room> getRooms() {
		return rooms;
	}

	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}
	
	
	
}
