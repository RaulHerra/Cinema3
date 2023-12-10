const pass = document.getElementById("password");
const formButton = document.getElementById("formButton");
document.addEventListener('DOMContentLoaded', () => {

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
    
    pass.addEventListener("change", () => {
        if(isPasswordValid(pass.value)){
            showSuccess(pass); 
        }else{
            showError(pass,"The password must meet minimum security requirements, such as minimum length (6 characters) and the inclusion of special characters (*?¿!), numbers (at least 1) and letters (at least 1)");
        }
    });
    
    formButton.addEventListener("click", () => {
		if(!(isPasswordValid(pass.value)) || pass.value.trim()!=""){
			event.preventDefault();
		}
	});
});