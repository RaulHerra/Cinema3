package com.jacaranda.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.util.BdUtil;
import com.jacaranda.model.Character;

import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;

public class CharacterRepository {

	/**
	 * Method that is in charge of inserting a new Character 
	 * to the "pelicula" database (if you have created the database 
	 * in PHPMyAdmin). 
	 * <br> <br>
	 * In "addCharacter.jsp" the input data of the 
	 * .jsp page is collected. If the inputs are not null, they are collected, 
	 * a new Character object is created, and this function is called with 
	 * the new Character in the input parameter.
	 * 
	 * @param c
	 * @return
	 * @throws IllegalStateException
	 * @throws SystemException
	 * @throws SecurityException
	 * @throws RollbackException
	 * @throws HeuristicMixedException
	 * @throws HeuristicRollbackException
	 */
	public static void addCharacter(Character c) 
			throws IllegalStateException, SystemException, SecurityException, RollbackException, 
			HeuristicMixedException, HeuristicRollbackException, Exception {
		
		Transaction transaction = null;
		
		
		if (c != null) {
			
			if (c.getCharacterName() != null) {
				
				Session session = BdUtil.getSessionFactory().openSession();
				transaction = session.beginTransaction();		
				
				try {
					
					session.persist(c);
					transaction.commit();
					
				}catch (Exception e) {
					transaction.rollback();
				}
				
				session.close();
			}
		
			
		}else {
			throw new Exception ("El personaje tiene de valor nulo.");
		}
		
	}
	
	
	/**
	 * This method recovers from the database 'pelicula' all the rows of 
	 * the table Character, inserts them in a List variable, and returns it.
	 * <br> <br>
	 * It's used to show the characters that are inserted in the database, and 
	 * the 'listCharacters.jsp' file uses it.
	 * 
	 * @return
	 */
	public static List<Character> getCharacters(){
		
		Session session = BdUtil.getSessionFactory().openSession();
		
		/* I go through the entire table to recover and insert all the characters in the list
		 * I'm using Hibernate, so the tables' names are the same as the Java classes*/
		List<Character> characters = (List<Character>) session.createSelectionQuery( "From Character" ).getResultList();
		
		session.close();
		
		
		return (characters);
	}
	
	
	
	/**
	 * Method that, using the method 'getCharacters()', returns a List variable 
	 * of all the characters' names. 
	 * <br> <br>
	 * It's used to decide whether to insert a character or not, because two characters
	 * with the same name can't be inserted in the database. 
	 * 
	 * @return
	 */
	public static List<String> getCharactersNames() {
		
		List<Character> characters = getCharacters();
		
		/*I go throught all the characters and I add to a new list all their names*/
		List<String> charactersNames = new ArrayList<String>();
		
		
		for(Character c : characters) {
			charactersNames.add(c.getCharacterName());
		}
		
		
		return (charactersNames);
	}
	
	
	/**
	 * Method that returns a Character from the database 
	 * that has the name of the String from the entry parameter.
	 * 
	 * @param characterName
	 * @return
	 */
	public static Character getCharacter(String characterName) {
		
		Character result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		
		/*Here I send a query to receive the character whose name is the same
		 * as the parameter variable*/
		SelectionQuery<Character> q =
			//I do the query
			session.createSelectionQuery("From Character where characterName = :characterName", Character.class);
				
		//I put the variable inside the query
		q.setParameter("characterName", characterName);
		
		//I put the results in this list
		List<Character> characters = q.getResultList();
				
		//I get the first result if the list with the character is not empty
		if (characters.size() != 0) {
			result = characters.get(0);
		}
				
		session.close();
		
		
		return (result);
	}
	
	
	
	
	/**
	 * Method that edits a Character. It is similar to the addCharacter() method,
	 * but here the changes are that here it is used "merge" to update, and there 
	 * "persist" is used.
	 * 
	 * @param c
	 */
	public static void editCharacter(Character c){
		
		Transaction transaction = null;
		Session session = BdUtil.getSessionFactory().openSession();
		transaction = session.beginTransaction();
		
		try {
			session.merge(c);
			transaction.commit();
		
		}catch (Exception e) {
			transaction.rollback();
		}
			
		session.close();
	}
	
	
	
	
	/**
	 * Method that deletes a Character with the name of the String from the entry parameter.
	 * It is similar to getCharacter(), but here it is used a "Transaction" because there is 
	 * going to be changes to the database.
	 * 
	 * @param characterName
	 */
	public static void deleteCharacter(String characterName) {
		
		Character result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		Transaction transaction = null;

		SelectionQuery<Character> q =
				session.createSelectionQuery("From Character where characterName = :characterName", Character.class);
		q.setParameter("characterName", characterName);
		List<Character> characters = q.getResultList();
		
		
		if(characters.size() != 0) {
					
			/*If the list is not empty*/
			transaction = session.beginTransaction(); //I initialize the Transaction
			result = characters.get(0); //I get the character I want to delete
			session.remove(result); //I delete it with the 'remove()' method
			transaction.commit(); //Here I do a commit to save the changes to the data base
		}
		
		session.close();
	}
}
