package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Projection;
import com.jacaranda.util.BdUtil;

public class ProjectionRepository extends DbRepository {

	public static List<Projection> findAllInActualDate() throws Exception {
		Session session;
		List<Projection> result = null;

		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}

		try {
			session = BdUtil.getSessionFactory().openSession();
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Projection> query = (SelectionQuery<Projection>)

					session.createNativeQuery("select * from Proyeccion where fecha_estreno+dias_estreno >= CURDATE()+0;",Projection.class);
			result = (ArrayList<Projection>) query.getResultList();
			session.close();
 		}catch (Exception e) {
 			session.close();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		
		session.close();
		return result;
	}
}
