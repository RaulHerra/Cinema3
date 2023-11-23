package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Cinema;
import com.jacaranda.model.Projection;
import com.jacaranda.model.Room;
import com.jacaranda.util.BdUtil;

public class RoomRepository extends DbRepository {

	public static List<Projection> getProjections(Cinema cinema,int roomNumber) throws Exception{

		List<Projection> listProjections = null;

		Session session = null;

		try {

			session = BdUtil.getSessionFactory().openSession();

			

			SelectionQuery<Projection> queryProjection = (SelectionQuery<Projection>)

					session.createNativeQuery("select * from Proyeccion where cine = :cine and sala = :sala",Projection.class);

			queryProjection.setParameter("cine", cinema.getCinema());
			queryProjection.setParameter("sala", roomNumber);

			listProjections =  queryProjection.getResultList();

 		}catch (Exception e) {

 			session.close();

 			throw new Exception("Failed to connect to database "+ e.getMessage());

 		}

		session.close();

		return listProjections;

	}

	

	public static void delete(Room room) throws Exception {

		Transaction transaction = null;

		Session session;
		

		try {

			session = BdUtil.getSessionFactory().openSession();
			
		}catch (Exception e) {

			throw new Exception("Failed to connect to database " + e.getMessage());

		}
		
		transaction = session.beginTransaction();
		try {

			List<Projection> projections = room.getProjections();

			for(Projection projection : projections) {
				//Pq asi en lugar de hacer una sql directamente
				session.remove(projection);
			}
			

			session.remove(room);

			transaction.commit();

		}catch (Exception e) {

			transaction.rollback();

			session.close();

			throw new Exception("Failed to connect to database " + e.getMessage());

		}
		session.close();

	}
	
	
	public static void change(Room originalRoom, Room editedRoom ) throws Exception {
		
		//Solo son iguales si las pk no han sido modificadas
		if(originalRoom.equals(editedRoom)) {
			DbRepository.editEntity(editedRoom);
		}else {
			//en caso de no ser equals, se debe editar todas las projections
			
			// Añadimos la sala editada a la bbdd para que no nos de errores de FK
			DbRepository.addEntity(editedRoom);
			
			
			//Empezamos el proceso de editar las proyecciones a el codigo de la sala recien añadida
			Transaction transaction = null;
			Session session;

			try {
				session = BdUtil.getSessionFactory().openSession();
			}catch (Exception e) {
				throw new Exception("Error al conectar con la base de datos " + e.getMessage());
			}
			
			transaction = session.beginTransaction();
	
			
			try {
				NativeQuery<Projection> query  = session.createNativeQuery("UPDATE `Proyeccion` SET `sala` = :newRoomNumber WHERE `Proyeccion`.`cine` = :cinemaName AND `Proyeccion`.`sala` = : "
						+ "",Projection.class);
				query.setParameter("newRoomNumber", editedRoom.getRoomNumber()); //Seteo el nuevo numero de room
				query.setParameter("cinemaName", originalRoom.getCinema().getCinema());//Parametros de busqueda por el nombre del cine
				query.setParameter("oldRoomNumber", originalRoom.getRoomNumber());//Parametros de busqueda por la sala
				
				query.executeUpdate();
				

				transaction.commit();

	
				session.remove(originalRoom);

	
			}catch (Exception e) {
	
				transaction.rollback();
	
				session.close();
	
				throw new Exception("Failed to connect to database " + e.getMessage());
	
			}
			session.close();
		}
	}	
	
	

}
