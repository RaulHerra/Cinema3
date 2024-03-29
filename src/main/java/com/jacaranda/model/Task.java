package com.jacaranda.model;


import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import com.jacaranda.exception.TaskException;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table (name ="Tarea")
public class Task {
	
	private static final int LONGITUD_MAX = 30;
	private static final int LONGITUD_MIN = 0;
	private final static List<String> CHARACTER_SEX_VALID_CHARACTERS = Arrays.asList("H","M","O");

	
	@Id
	@Column(name="tarea")
	private String task;
	
	@Column(name="sexo_tarea")
	private String sex;
	
	@OneToMany(mappedBy="task")
	private List<Work>works;
	
	//Constructores
	public Task(String task, String sex) throws TaskException {
		super();
		validateTask(task);//Validación de tarea
		validateSex(sex);//Validación de sexo
		this.task = task;
		this.sex = sex;
	}

	public Task() {
		super();
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public List<Work> getWorks() {
		return works;
	}

	public void setWorks(List<Work> works) {
		this.works = works;
	}

	@Override
	public int hashCode() {
		return Objects.hash(task);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Task other = (Task) obj;
		return Objects.equals(task, other.task);
	}
	
	//Validación de sexo para que solo sea permitido H-O-M.
	private void validateSex(String taskSex) throws TaskException {
		if(!CHARACTER_SEX_VALID_CHARACTERS.contains(taskSex.toUpperCase())) throw new TaskException("Invalid sex. Valid sex: H-M-O");
		
	}
	
	//Validación de tarea para que solo sea permitidas las tareas con longitud 30 debido a que esta en la base de datos.
	private void validateTask(String t) throws TaskException {
		if(t.length()<LONGITUD_MIN || t.length()>LONGITUD_MAX) throw new TaskException("Invalid task. Character length: 0-30");
	}

	@Override
	public String toString() {
		return "Task [task=" + task + ", sex=" + sex + ", tasks=" + works.toString() + "]";
	}

	
	
}
	

