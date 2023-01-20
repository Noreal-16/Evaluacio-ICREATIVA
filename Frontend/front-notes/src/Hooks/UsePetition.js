import Axios from 'axios';
import API from '../Utils/API_REST';
export const usePetition = (formState) => {
    const URL_API = `${API}/auth/login`;
    Axios({
        method: 'POST',
        data: formState,
        withCredentials: true,
        url: URL_API
    }).then((response) => {
        if (response.status) {
            return response.data
        }
    }).then((result) => {
        console.log("La Data es " + result)
    })
        .catch((error) => {
           console.log("Error en la consulta ", error)
        })
}