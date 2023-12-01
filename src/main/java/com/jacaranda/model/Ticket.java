package com.jacaranda.model;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Entrada")
public class Ticket {

	@Id
	@Column(name = "idEntrada")
	private int id;
	
	@ManyToOne
	@JoinColumn(name="cine")
	private Cinema cinema;
	
	@ManyToOne
	@JoinColumns({@JoinColumn(name="sala"),@JoinColumn(name="cine")})
	private Room room;
	
	@ManyToOne
	@JoinColumn(name="cip")
	private Film film;
	
	@ManyToOne
	@JoinColumn(name="fecha_estreno")
	private Date premiereDate;
	
	@ManyToOne
	@JoinColumn(name="usuario")
	private User user;
	
	@Column(name="fecha_compra")
	private Date buyDate;
	
	
}
