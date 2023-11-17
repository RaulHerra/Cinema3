package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Film;
import com.jacaranda.util.BdUtil;

public class FilmRepository {

	public static void addFilm(Film f){
		/*Inicializo a null la transacion para despues ver si hacemos un commit sobre la bd o un rollback*/
		Transaction transaction = null; 
		/*Creo esta variable session que es la que voy a utilizar para interactuar con la bd*/
		Session session = BdUtil.getSessionFactory().openSession();
		/*Inicializo la transacion y con el beginTrassacion le digo que todas las operaciones posteriores son parte
		 * de esta transaccion*/
		transaction = session.beginTransaction();
		try {
			/*Intento guardar la pelicula en la bd*/
			session.persist(f);
			/*Si no hay fallos hago un commit*/
			transaction.commit();
		}catch (Exception e) {
			/*En el caso de algún fallo hago un rollback para deshacer las anteriores operaciones y que no se 
			 * guarden en la bd*/
			transaction.rollback();
		}
			/*Cierro la session para evitar posibles fallos, de dejar conexiones abiertas en la bd*/
		session.close();
	}
	
	/*Aqui hago exactemente lo mismo que en el método de arriba pero lo que cambia 
	 * es que arriba le digo con el persit que me guarde el cine y aqui con el merge le
	 * digo que me lo actualice*/
	public static void editFilm(Film f){
		Transaction transaction = null;
		Session session = BdUtil.getSessionFactory().openSession();
		transaction = session.beginTransaction();
		try {
			session.merge(f);
			transaction.commit();
		}catch (Exception e) {
			System.out.println(e.getMessage());
			transaction.rollback();
		}
			
		session.close();
	}
	
	/*Recupero todos las peliculas*/
	public static List<Film> getFilms(){
		Session session = BdUtil.getSessionFactory().openSession();
		/* Como utilizo la query de Hiberante el nombre de las tablas son el nombre de las clases Java*/
		List<Film> Films = (List<Film>) session.createSelectionQuery( "From Film" ).getResultList();
		
		return Films;
	}
	
	/*Recupero todos los cip de las peliculas*/
	public static List<String> getCipFilms(){
		Session session = BdUtil.getSessionFactory().openSession();
		List<String> cipFilm = (List<String>) session.createSelectionQuery( "select f.cip From Film f" ).getResultList();
		return cipFilm;
	}
	
	/*Este método me da todos los cines con el cip que le paso aqui no utilizo una transaccion porque no 
	 * quiero hacer ningun cambio sobre la base de datos*/
	public static Film getFilm(String cip) {
		Film result = null;
		Session session = BdUtil.getSessionFactory().openSession();

		/*Creo una consulta sobre peliculas donde le digo que cip es igual al cip que le paso por parametro*/
		SelectionQuery<Film> q =
				session.createSelectionQuery("From Film where cip = :cip", Film.class);
				q.setParameter("cip", cip); //Aquí le digo que el cip de la consulta ":cip" es el que le he pasado por parametro
				List<Film> films = q.getResultList(); //Meto en una lista de peliculas el resultado de la query
				if(films.size() != 0) {
					//Si la lista no está vacía me quedo con el primero y despues lo devuelvo
					result = films.get(0);
				}
				session.close();
				return result;
	}
	
	/*Hago los mismo que arriba pero esta vez si utilizo una transaccion ya que quiero borrar una pelicula*/
	public static void deleteFilm(String cip) {
		Film result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		Transaction transaction = null;

		SelectionQuery<Film> q =
				session.createSelectionQuery("From Film where cip = :cip", Film.class);
				q.setParameter("cip", cip);
				List<Film> films = q.getResultList();
		if(films.size() != 0) {
			/*Si no está vacia la lista*/
			transaction = session.beginTransaction(); //Inicializo la transaccion
			result = films.get(0); //Almaceno el cine que quiero borrar
			session.remove(result); //Lo borro con el metodo remove
			transaction.commit(); //Y le hago un commit para que se guarde los cambios en la base de datos
		}
		session.close();
	}
	
	
}
