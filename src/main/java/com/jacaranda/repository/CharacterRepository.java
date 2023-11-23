package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Work;
import com.jacaranda.util.BdUtil;
import com.jacaranda.model.Character;

public class CharacterRepository extends DbRepository{

	
	public static ArrayList<Work> getWorks(String nombrePersona) throws Exception{

		ArrayList<Work> listWorks = null;

		Session session = null;

		try {

			session = BdUtil.getSessionFactory().openSession();

			

			SelectionQuery<Work> queryWork = (SelectionQuery<Work>)

					session.createNativeQuery("select * from Trabajo where nombre_persona = :nombre_persona",Work.class);

			queryWork.setParameter("nombre_persona", nombrePersona);

			listWorks = (ArrayList<Work>) queryWork.getResultList();

 		}catch (Exception e) {

 			session.close();

 			throw new Exception("Failed to connect to database "+ e.getMessage());

 		}

		session.close();

		return listWorks;

	}
	
	public static void delete(Character characterc) throws Exception {

		Transaction transaction = null;

		Session session;

		

		try {

			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {

			throw new Exception("Failed to connect to database " + e.getMessage());

		}
		
		transaction = session.beginTransaction();
		try {

			ArrayList<Work> works = (ArrayList<Work>) characterc.getWorks();

			for(Work w : works) {

				session.remove(w);

			}

			session.remove(characterc);

			transaction.commit();

		}catch (Exception e) {

			transaction.rollback();

			session.close();

			throw new Exception("Failed to connect to database " + e.getMessage());

		}

	}
}
