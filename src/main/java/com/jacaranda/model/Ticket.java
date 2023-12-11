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
	
	static private int autoIncrementId = 0;
	
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

	public Ticket(Projection projection, User user, Date buyDate) {
		super();
		this.id = autoIncrementId++;
		this.projection = projection;
		this.user = user;
		this.buyDate = buyDate;
	}
	
	public Ticket() {
		super();
	}

	public Projection getProjection() {
		return projection;
	}

	public void setProjection(Projection projection) {
		this.projection = projection;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	public int getId() {
		return id;
	}
	
}
