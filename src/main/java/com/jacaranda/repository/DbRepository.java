package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.util.BdUtil;

public class DbRepository {

	public static <T> T find(Class<T> c, String id) throws Exception {
		Session session;
		T result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> List<T> findAll(Class<T> c) throws Exception {
		Session session;
		List<T> resultList = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			resultList = ((List<T>) session.createSelectionQuery("From " + c.getName()).getResultList());
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return resultList;
	}
	
	public static <T> void addEntity(T t){
		Transaction transaction = null; 
		Session session = BdUtil.getSessionFactory().openSession();

		transaction = session.beginTransaction();
		try {
			session.persist(t);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
	
	public static <T> void editEntity(T t){
		Transaction transaction = null; 
		Session session = BdUtil.getSessionFactory().openSession();

		transaction = session.beginTransaction();
		try {
			session.merge(t);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
	
	public static <T> void deleteEntity(T entity){
		Transaction transaction = null;
		Session session = BdUtil.getSessionFactory().openSession();
		
		transaction = session.beginTransaction();
		try {
			session.remove(entity);
			transaction.commit();			
		}catch (Exception e) {
			transaction.rollback();
		}

		session.close();
	}
	
	
	public static <T> T find(Class<T> objectClass, Object id) throws Exception {
		Session session;
		T result;
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}

		try {
			result = session.find(objectClass, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");

		}
		return result;
	}

}
