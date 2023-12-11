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
	@JoinColumns({@JoinColumn(name="sala"),
				@JoinColumn(name="cine"),
				@JoinColumn(name="cip"),
				@JoinColumn(name="fecha_estreno")})
	private Projection projection;
	
	@ManyToOne
	@JoinColumn(name="usuario")
	private User user;
	
	@Column(name="fecha_compra")
	private Date buyDate;

	public Ticket(int id, Cinema cinema, Projection projection, User user, Date buyDate) {
		super();
		this.id = id;
		this.projection = projection;
		this.user = user;
		this.buyDate = buyDate;
	}
	
	public Ticket() {
		super();
	}
	
	
	
}