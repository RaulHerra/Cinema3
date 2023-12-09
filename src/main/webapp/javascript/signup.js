const username = document.getElementById("username");

const email = document.getElementById("email");

const name = document.getElementById("name");
const surname = document.getElementById("surname");

const pass = document.getElementById("password");
const repass = document.getElementById("repassword");

const formButton = document.getElementById("formButton");

document.addEventListener('DOMContentLoaded', () => {
    
    //This function evaluate username, name, and surname
    function isNameValid(data){
        const re = /^[A-Z]{1}/
        return re.test(data);
    }

	const isEmailValid = (email) => {
	    const re = /^(([^<>()\].,;:\s@"]+(\.[()\[\\.,;:\s@"]+)*)|(".+"))@(([0-9]1,3\.[0-9]1,3\.[0-9]1,3\.[0-9]1,3)|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(email);
	};

    function isPasswordValid(data){
        const re = /^(?=.*[A-z])(?=.*[0-9])(?=.*[¿?¡!@\_\-#\$%\^&*])(?=.{6,})/;
        return re.test(data);
    }

    function showError(input, message){
        // Obtener el elemento form-field
        const formField = input.parentElement;
        // Agregar la clase de error
        input.classList.remove('success');
        input.classList.add('error');
        // Mostrar el mensaje de error
        const error = formField.querySelector('small');
        error.textContent = message;
    };
    
    function showSuccess(input){
        // Obtener el elemento form-field
        const formField = input.parentElement;
        // Eliminar la clase de error
        input.classList.remove('error');
        input.classList.add('success');
        // Ocultar el mensaje de error
        const error = formField.querySelector('small');
        error.textContent = '';
    };
    
    function isFormValid(){
		return isNameValid(username.value) 
		&& isNameValid(name.value)
		&& isNameValid(surname.value)
		&& isEmailValid(email.value)
		&& isPasswordValid(pass.value)
		&& isPasswordValid(repass.value)
		&& pass.value==repass.value;
	}
    
    username.addEventListener("change", () => {
				console.log("funcar funca")
        if(isNameValid(username.value)){
            showSuccess(username);
        }else{
            showError(username,"Username must start with capital letter");
        }
    });
    
    email.addEventListener("change", () => {

		if(isEmailValid(email.value)){
			showSuccess(email);
		}else{
			showError(email,"Email format not valid")
		}
	})
    
    name.addEventListener("change", () => {
        if(isNameValid(name.value)){
            showSuccess(name);
        }else{
            showError(name,"Name must start with capital letter");
        }
    });
    
    surname.addEventListener("change", () => {
        if(isNameValid(surname.value)){
            showSuccess(surname);
        }else{
            showError(surname,"Name must start with capital letter");
        }
    });
    
    pass.addEventListener("change", () => {
        if(isPasswordValid(pass.value)){
            showSuccess(pass); 
        }else{
            showError(pass,"The password must meet minimum security requirements, such as minimum length (6 characters) and the inclusion of special characters (*?¿!), numbers (at least 1) and letters (at least 1)");
        }
    });
    
    repass.addEventListener("change", () => {
        if(isPasswordValid(repass.value) && repass.value==pass.value){
            showSuccess(repass); 
        }else{
            showError(repass,"The password must meet minimum security requirements, such as minimum length (6 characters) and the inclusion of special characters (*?¿!), numbers (at least 1) and letters (at least 1) and must be equal to the previous one");
        }
    });
    
    formButton.addEventListener("click", () => {
		if(!isFormValid()){
			event.preventDefault();
		}
	});
});