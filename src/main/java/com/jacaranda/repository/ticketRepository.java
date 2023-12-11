package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Projection;
import com.jacaranda.model.Ticket;
import com.jacaranda.util.BdUtil;

import jakarta.persistence.Query;

public class ticketRepository extends DbRepository {

	public static List<Ticket> findByProjection(Projection projection) throws Exception{
		Session session;
		List<Ticket> result = null;

		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}

		try {
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Ticket> query = (SelectionQuery<Ticket>)

			session.createNativeQuery("SELECT * FROM `Entrada` WHERE cine=\""+projection.getRoom().getCinema().getCinema()+"\" and sala=\""+projection.getRoom().getRoomNumber()+"\" and cip=\""+projection.getFilm().getCip()+"\" and fecha_estreno="+projection.getPremiereDate()+";",Ticket.class);
			result = (ArrayList<Ticket>) query.getResultList();
 		}catch (Exception e) {
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		
		session.close();
		return result;
	}
	
	//This method insert a ticket in the db, we can't use the generic method to insert a ticket
	@SuppressWarnings("deprecation")
	public static void addTicket(Ticket ticket) throws Exception{
		Transaction transaction = null; 
		Session session = null;

		try {
			session = BdUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}

		try {
			String query = "INSERT INTO `Entrada`(`cine`, `sala`, `cip`, `fecha_estreno`, `idEntrada`, `usuario`, `fecha_compra`) VALUES ('"+ticket.getProjection().getRoom().getCinema().getCinema()+
					"','"+ticket.getProjection().getRoom().getRoomNumber()+
					"','"+ticket.getProjection().getFilm().getCip()+
					"','"+ticket.getProjection().getPremiereDate()+
					"','"+ticket.getId()+
					"','"+ticket.getUser().getUsername()+
					"','"+ticket.getBuyDate()+"');";
			
			Query persistableQuery = session.createNativeQuery(query);
			persistableQuery.executeUpdate();
			
			transaction.commit();
 		}catch (Exception e) {
 			transaction.rollback();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
	}
	
	public static List<Object[]> findByUser(String username) throws Exception{
		Session session;
		List<Object[]> result = null;

		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}

		try {
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Object[]> query = (SelectionQuery<Object[]>)

			session.createNativeQuery("SELECT * FROM `Entrada` WHERE usuario='"+username+"';");
			result = (ArrayList<Object[]>) query.getResultList();
 		}catch (Exception e) {
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		
		session.close();
		return result;
	}
	
}
