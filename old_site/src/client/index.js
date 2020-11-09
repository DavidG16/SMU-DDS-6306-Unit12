import "./styles/styles.scss";
import {addHandleHome} from './js/handleHome'
import {updateWorksUI} from "./js/beerWorkUI"
import {rKnit} from "./js/rknit"


document.getElementById("nav-logo-id").addEventListener('click', addHandleHome)
document.addEventListener('click', function(e) {
    //e.stopPropagation();
    //e.preventDefault();
	if(e.target && e.target.id == "work-card-container-id") {
        updateWorksUI()
	}
});

document.addEventListener('click', function(e) {
    //e.stopPropagation();
    //e.preventDefault();
	if(e.target && e.target.id == "r-knit") {
        rKnit()
	}
});




export {
    addHandleHome,
    updateWorksUI


}