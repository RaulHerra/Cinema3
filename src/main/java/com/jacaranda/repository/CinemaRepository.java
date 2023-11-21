package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Cinema;
import com.jacaranda.model.Room;
import com.jacaranda.util.BdUtil;

public class CinemaRepository extends DbRepository {


	
	public static ArrayList<Room> getRooms(String cinema) throws Exception{

		ArrayList<Room> listRooms = null;

		Session session = null;

		try {

			session = BdUtil.getSessionFactory().openSession();

			

			SelectionQuery<Room> queryRoom = (SelectionQuery<Room>)

					session.createNativeQuery("select * from Sala where cine = :cine",Room.class);

			queryRoom.setParameter("cine", cinema);

			listRooms = (ArrayList<Room>) queryRoom.getResultList();
			session.close();

 		}catch (Exception e) {

 			session.close();

 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());

 		}

		session.close();

		return listRooms;

	}

	

	public static void delete(Cinema cinema) throws Exception {

		Transaction transaction = null;

		Session session;

		

		try {

			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {

			throw new Exception("Error al conectar con la base de datos " + e.getMessage());

		}
		
		transaction = session.beginTransaction();
		try {

			ArrayList<Room> Rooms = (ArrayList<Room>) cinema.getRooms() ;

			for(Room room : Rooms) {

				RoomRepository.delete(room);

			}

			session.remove(cinema);

			transaction.commit();
			session.close();

		}catch (Exception e) {

			transaction.rollback();

			session.close();

			throw new Exception("Error al borrar el objeto " + e.getMessage());

		}

	}
}
