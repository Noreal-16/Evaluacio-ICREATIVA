import React, {useEffect} from "react";
import API from "../Utils/API_REST";
import Cookies from 'universal-cookie';
import Axios from "axios";

const cookie = new Cookies();

export const ListNotes = () => {

    const getDataNotes = async () => {
        const token = cookie.get('token');
        Axios({
            method: 'GET',
            withCredentials: true,
            url: `${API}/notes`,
            headers: {'Bearer': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IlNhbnRpYWdvIiwiaWF0IjoxNjc0MjI2MjQ2LCJleHAiOjE2NzQyNjIyNDZ9.kET59Fdkt0P4ltqy6HtMhjxLlC35heaAbHYysf5FiKE',
            'Authorization': `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IlNhbnRpYWdvIiwiaWF0IjoxNjc0MjI2MjQ2LCJleHAiOjE2NzQyNjIyNDZ9.kET59Fdkt0P4ltqy6HtMhjxLlC35heaAbHYysf5FiKE`}
        }).then((response) => {
            console.log(response)
        }).catch((error) => {
            console.log(error)
        })
    }

    useEffect(() => {
        getDataNotes()
    }, []);

    return (
        <table className="table">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Descripción</th>
                <th scope="col">Completado</th>
                <th scope="col">Estado</th>
                <th scope="col">Funciones</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    )
}