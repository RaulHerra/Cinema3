package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Cinema;
import com.jacaranda.model.Room;
import com.jacaranda.util.BdUtil;

public class CinemaRepository extends DbRepository {


	/*Este método se utiliza para recueperar todas las rooms del cine, para ello le pasamos la clave del
	 * cine por parametro*/
	public static ArrayList<Room> getRooms(String cinema) throws Exception{
		ArrayList<Room> listRooms = null;
		Session session = null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Room> queryRoom = (SelectionQuery<Room>)

					session.createNativeQuery("select * from Sala where cine = :cine",Room.class);
					//Seteo el parametro que le he pasado
					queryRoom.setParameter("cine", cinema);
			//En esta variable guardo los resultados de la query en lista
			listRooms = (ArrayList<Room>) queryRoom.getResultList();
			session.close();
 		}catch (Exception e) {
 			session.close();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}

		session.close();
		return listRooms;
	}

	
	/*Este método borra todas las room que contenga el cine que le pasamos por parametros y 
	 * además borra todas proyecciones de cada sala que se vaya borrando
	 */
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
			List<Room> Rooms = cinema.getRooms() ;
			
			/*Recorro la lista de rooms que recupero del cine y llamo al método
			 * de RoomRepository.delete() que el se encargá de borrar todas las proyecciones
			 * que tiene la sala y una vez que se borra todas la proyecciones se borra la sala*/
			for(Room room : Rooms) { 
				RoomRepository.delete(room);
			}
			//Cuando ha terminado de recorrer todas las rooms, el cine ya no tiene ninguna room
			//Y borramos el cine
			session.remove(cinema);
			//Si no hay ningún problema hacemos un commit para que se guarden los cambios y se cierra session
			transaction.commit();
			session.close();
		}catch (Exception e) {
			//Si hay algún error hacemos un rollback, cierro session y lanzo las excepcion
			transaction.rollback();
			session.close();
			throw new Exception("Error al borrar el objeto " + e.getMessage());

		}

	}
}
