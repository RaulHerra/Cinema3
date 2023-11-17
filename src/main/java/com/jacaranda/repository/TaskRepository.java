package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Task;
import com.jacaranda.util.BdUtil;

public class TaskRepository {
	
	//Método para añadir Tarea a la base de datos
	public static Task addTask(Task t) {
		Transaction transaction = null;
		Task result=null;
		Session session = BdUtil.getSessionFactory().openSession();//Creamos la session para poder interactuar con la bd
	
		transaction = session.beginTransaction();
		try {
			session.save(t);//Guardamos la nueva tarea
			transaction.commit();
		} catch (IllegalStateException e) {
			e.printStackTrace();
			transaction.rollback();//En caso de que nos de un error podemos volver con rollback
		}
		
		session.close();//Importante cerrar la session
		return result;
	}
	
	//Método para recuperar todas las tareas
	public static List<Task> getTasks(){
		Session session = BdUtil.getSessionFactory().openSession();

		List <Task> r = (List<Task>) session .createSelectionQuery( "From Task" ).getResultList();
		return r;
	}
	
	//Método para editar las Tareas 
	public static Task editTask(Task task) {
		Transaction transaction = null;
		Task result=null;
		Session session = BdUtil.getSessionFactory().openSession();
	
		transaction = session.beginTransaction();
		try {
			session.merge(task);//Método igual que añadir pero solo cambia en la session el merge
			transaction.commit();
		} catch (IllegalStateException e) {
			e.printStackTrace();
			transaction.rollback();			
		}
		
		session.close();
		return result;
	}
	
	//Método me da las tareas con la PK pasada por parametros 
	public static Task lookTask(String task) {
		Task result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		//Creamos la consulta para sacar la tarea con el mismo PK
		SelectionQuery<Task> q =session.createSelectionQuery("From Task where task = :task",Task.class);
		q.setParameter("task", task);
		List<Task> cines= q.getResultList();//Guarda los datos de la consulta en una lista para que posteriormente se pueda ver si se tiene la tarea requeridad
		if(cines.size()!=0) result=cines.get(0);
		return result;
	}
	
	//Método para borrar la tarea 
	public static void deleteTask(String task) {
		Transaction transaction = null;
		Task result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		
		SelectionQuery<Task> q =session.createSelectionQuery("From Task where task = :task",Task.class);//Creamos la consulta para sacar la tarea con el mismo PK
		q.setParameter("task", task);
		List<Task> tasks= q.getResultList();
		if(tasks.size()!=0) { result=tasks.get(0);transaction = session.beginTransaction();}//Guardamos el resultado de la consulta
		session.remove(result);//Se borra la tarea con remove.
		transaction.commit();
	}
	
	//Método para dar todas la claves PK de la tabla Tarea
	public static List<String> getPrimaryKey(){
		List<Task> tasks = getTasks();
		//Recorro todas las tareas y las añados en la lista de tareas que devuelvo
		List<String> pkTasks = new ArrayList<String>();
		for(Task f : tasks) {
			pkTasks.add(f.getTask());
		}
		return pkTasks;
	}
}
