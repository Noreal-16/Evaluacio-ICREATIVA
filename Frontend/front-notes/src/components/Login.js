import React from "react";
import logo from '../assets/icons/Login';
import '../assets/css/index.css';
import {UseForm} from "../Hooks/useForm";
import API from "../Utils/API_REST";
import Axios from "axios";
import swal from 'sweetalert2';
import Cookies from 'universal-cookie';
const cookie = new Cookies();

export const Login = () => {
    const {handleInputChange, email, password} = UseForm({
        email: '',
        password: ''
    });
    const handleLogin = (e) => {
        e.preventDefault();
        const URL_API = `${API}/auth/login`;
        Axios({
            method: 'POST',
            data: {email, password},
            withCredentials: true,
            url: URL_API
        }).then((response) => {
            if (response) return response
        }).then((result) => {
           cookie.set('token', result.data.token, {path: '/'});
            swal.fire({
                title: 'Bienvenido',
                text: `Acceso Correcto`,
                icon: "success",
                timer: 1000
            }).then(() => {
                window.location.href = '/';
            })
        }).catch((error) => {
            swal.fire({
                title: 'Error al iniciar sesión',
                text: `${error.code}`,
                icon: "info",
                timer: 2000
            })
        })
    }
    return (
        <div className="container-login">
            <img alt='' className='img-fluid img-logo' src={logo}/>
            <div className='container-form'>
                <h1>Login Usuarios</h1>
                <div className='login-user'>
                    <form onSubmit={handleLogin}>
                        <div className="mb-3">
                            <label htmlFor="exampleInputEmail1" className="form-label">Correo</label>
                            <input type="email" name='email' value={email} onChange={handleInputChange}
                                   className="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp"
                                   placeholder='correo@correo.com'/>
                        </div>
                        <div className="mb-3">
                            <label htmlFor="exampleInputPassword1" className="form-label">Contraseña</label>
                            <input type="password" name='password' value={password} onChange={handleInputChange}
                                   className="form-control" id="exampleInputPassword1"
                                   placeholder='***************'/>
                        </div>
                        <div className='group-button'>
                            <button type="submit" className="btn btn-primary">Ingreso</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    )
}