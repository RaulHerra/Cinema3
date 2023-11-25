package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Work;
import com.jacaranda.util.BdUtil;
import com.jacaranda.model.Character;

public class CharacterRepository extends DbRepository{

	
	public static ArrayList<Work> getWorks(String nombrePersona) throws Exception{ //ESTE MÉTODO SERÁ PARA OBTENER UN ARRAYLIST DE TRABAJOS ASOCIADOS A UNA PERSONA
		
		//CREAMOS EL ARRAYLIST DE TRABAJOS
		ArrayList<Work> listWorks = null;
		//CREAMOS LA SESSION
		Session session = null;

		try {
			//INICIAMOS LA SESSION
			session = BdUtil.getSessionFactory().openSession();
			
			//CREAMOS LA SELECTION QUERY DE WORK(TRABAJO)
			SelectionQuery<Work> queryWork = (SelectionQuery<Work>)
			//HACEMOS UN SELECT DE TODOS AQUELLOS TRABAJOS DONDE EL NOMBRE DE LA PERSONA SEA IGUAL AL NOMBRE DE LA PERSONA QUE PASAMOS
			session.createNativeQuery("select * from Trabajo where nombre_persona = :nombre_persona",Work.class);
			//ESTABLECEMOS EL PARÁMETRO
			queryWork.setParameter("nombre_persona", nombrePersona);
			//LA SELECTION QUERY DE WORK TENDRÁ COMO VALOR UN ARRAYLIST DE TODOS LOS RESULTADOS DEVUELTOS POR LA CONSULTA
			listWorks = (ArrayList<Work>) queryWork.getResultList();

 		}catch (Exception e) {
 			//EN CASO DE ERROR CERRAMOS LA SESSION
 			session.close();

 			throw new Exception("Failed to connect to database "+ e.getMessage());

 		}
		
		//CERRAMOS LA SESSION
		session.close();
		//DEVOLVEMOS EL LISTADO DE TRABAJOS
		return listWorks;

	}
	
	public static void delete(Character characterc) throws Exception { //MÉTODO PARA ELIMINAR UN CARACTER Y SUS TRABAJOS ASOCIADOS

		//CREAMOS LA SESSION Y LA TRANSACTION
		Transaction transaction = null;

		Session session;

		

		try {
			//INICIAMOS LA SESSION
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {

			throw new Exception("Failed to connect to database " + e.getMessage());

		}
		
		//INICIAMOS LA TRANSACTION
		transaction = session.beginTransaction();
		try {
			//CREAMOS UN ARRAYLIST DE TRABAJOS CON LA LISTA DE TRABAJOS DE LA CLASE PERSONAJE
			ArrayList<Work> works = (ArrayList<Work>) characterc.getWorks();

			for(Work w : works) {//RECORREMOS EL ARRAYLIST

				session.remove(w);//ELIMINAMOS LOS TRABAJOS ASOCIADOS

			}

			session.remove(characterc);//ELIMINAMOS EL PERSONA

			transaction.commit();//GUARDAMOS LOS CAMBIOS
			
			session.close();//CERRAMOS LA SESSION

		}catch (Exception e) {
			//EN CASO DE ERROR CERRAMOS LA SESSION Y HACEMOS UN ROLLBACK
			transaction.rollback();

			session.close();

			throw new Exception("Failed to connect to database " + e.getMessage());

		}

	}
}
