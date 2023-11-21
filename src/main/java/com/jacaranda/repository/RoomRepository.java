package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Film;
import com.jacaranda.model.Room;
import com.jacaranda.model.Work;
import com.jacaranda.util.BdUtil;

public class RoomRepository extends DbRepository {

	public static ArrayList<Proyection> getProyection(Room room) throws Exception{

		ArrayList<Room> listRoom = null;

		Session session = null;

		try {

			session = BdUtil.getSessionFactory().openSession();

			

			SelectionQuery<Room> queryRoom = (SelectionQuery<Room>)

					session.createNativeQuery("select * from Proyeccion where cine = :cine and sala = :sala",Proyection.class);

			queryRoom.setParameter("cine", room.getCinema().getCinema());
			queryRoom.setParameter("sala", room.getRoomNumber());

			listRoom = (ArrayList<Room>) queryRoom.getResultList();

 		}catch (Exception e) {

 			session.close();

 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());

 		}

		session.close();

		return listRoom;

	}

	

	public static void delete(Room room) throws Exception {

		Transaction transaction = null;

		Session session;
		

		try {

			session = BdUtil.getSessionFactory().openSession();
			
		}catch (Exception e) {

			throw new Exception("Error al conectar con la base de datos " + e.getMessage());

		}
		
		transaction = session.beginTransaction();
		try {

			ArrayList<Proyection> rooms = getProyection(room);

			for(Proyection proyection : rooms) {
				//Pq asi en ñugar de hacer una sql directamente

				session.remove(proyection);

			}
			

			session.remove(room);

			transaction.commit();

		}catch (Exception e) {

			transaction.rollback();

			session.close();

			throw new Exception("Error al borrar el objeto " + e.getMessage());

		}
		session.close();

	}

}
