package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Film;
import com.jacaranda.model.Projection;
import com.jacaranda.model.Work;
import com.jacaranda.util.BdUtil;

public class FilmRepository extends DbRepository{

	
	public static ArrayList<Work> getWorks(String cip) throws Exception{ //ESTE MÉTODO LO UTILIZAREMOS PARA OBTENER LA LISTA DE TRABAJOS CON LAS PELÍCULAS
		//CREAMOS EL ARRAYLIST E INICIAMOS LA SESIÓN
		ArrayList<Work> listWorks = null;

		Session session = null;

		try {
			
			//INICIAMOS LA SESSION
			session = BdUtil.getSessionFactory().openSession();
			
			//CREAMOS UNA SELECTION QUERY DE TRABAJOS
			SelectionQuery<Work> queryWork = (SelectionQuery<Work>)

			//HACEMOS UNA NATIVE-QUERY DONDE SELECCIONAMOS TODOS LOS TRABAJOS DONDE EL CIP SEA IGUAL AL QUE LE PASAMOS POR PARÁMETRO
			session.createNativeQuery("select * from Trabajo where cip = :cip",Work.class);
			//ESTABLECEMOS EL PARÁMETRO EN LA SELECTION-QUERY CON EL VALOR DE CIP
			queryWork.setParameter("cip", cip);
			//PEDIMOS QUE NOS DEVUELVA LA LISTA RESULTANTE
			listWorks = (ArrayList<Work>) queryWork.getResultList();

 		}catch (Exception e) {
 			
 			session.close();

 			throw new Exception("Failed to connect to database "+ e.getMessage());

 		}
		//CERRAMOS LA SESSION
		session.close();

		//DEVOLVEMOS LA LISTA
		return listWorks;

	}

	

	public static void delete(Film film) throws Exception { //ESTE SERÁ EL MÉTODO PARA BORRAR UNA PELICULA
		//CREMAMOS LAS VARIAVLES TRANSACTION Y SESSION
		Transaction transaction = null;
		
		Session session;

		

		try {
			//INICIAMOS LA SESSION
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {

			throw new Exception("Failed to connect to database" + e.getMessage());

		}
		//INICIAMOS LA TRANSACTION
		transaction = session.beginTransaction();
		
		try {
			//CREAMOS UNA LISTA DE TRABAJOS Y LLAMAMOS A LA LISTA DE TRABAJOS DE LA CLASE FILM
			ArrayList<Work> works = (ArrayList<Work>) film.getWorks() ;

			for(Work w : works) { //RECORREMOS LA LISTA DE TRABAJOS

				session.remove(w); //LO ELIMINAMOS

			}

			session.remove(film); // POSTERIORMENTE ELIMINAMOS LA PELICULA
			
			//ESTE TRAMO DE CÓDIGO SERÁ PARA BORRAR LA PELICULA DE PROYECCIONES
			//CREAMOS UNA NATIVE QUERY DE PROYECCIONES Y LE DECIMOS QUE ELIMINE DE PROYECCION DONDE EL CIP SEA IGUAL AL CIP QUE PASAMOS POR PARÁMETRO
			NativeQuery<Projection> query = session.createNativeQuery("Delete From Proyeccion Where cip = :cip",Projection.class);
			//LE DAMOS EL VALOR A LA QUERY CREADA DEL CIP DE LA PELICULA QUE PASAMOS
			query.setParameter("cip", film.getCip());
			//EJECUTAMOS LA SENTENCIA
			query.executeUpdate();
			
			//GUARDAMOS LOS CAMBIOS
			transaction.commit();

		}catch (Exception e) {
			
			//EN CASO DE ERROR HAREMOS UN ROLLBACK Y CERRAMOS LA SESSION

			transaction.rollback();

			session.close();

			throw new Exception("Failed to connect to database" + e.getMessage());

		}
		
		//CERRAMOS LA SESSION
		session.close();

	}
}
