package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Film;
import com.jacaranda.model.Work;
import com.jacaranda.util.BdUtil;

public class FilmRepository extends DbRepository{

	
	public static ArrayList<Work> getWorks(String cip) throws Exception{

		ArrayList<Work> listWorks = null;

		Session session = null;

		try {

			session = BdUtil.getSessionFactory().openSession();

			

			SelectionQuery<Work> queryWork = (SelectionQuery<Work>)

					session.createNativeQuery("select * from Trabajo where cip = :cip",Work.class);

			queryWork.setParameter("cip", cip);

			listWorks = (ArrayList<Work>) queryWork.getResultList();

 		}catch (Exception e) {

 			session.close();

 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());

 		}

		session.close();

		return listWorks;

	}

	

	public static void delete(Film film) throws Exception {

		Transaction transaction = null;

		Session session;

		

		try {

			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {

			throw new Exception("Error al conectar con la base de datos " + e.getMessage());

		}
		
		transaction = session.beginTransaction();
		try {

			ArrayList<Work> works = (ArrayList<Work>) film.getWorks() ;

			for(Work w : works) {

				session.remove(w);

			}

			session.remove(film);

			transaction.commit();

		}catch (Exception e) {

			transaction.rollback();

			session.close();

			throw new Exception("Error al borrar el objeto " + e.getMessage());

		}

	}
}
