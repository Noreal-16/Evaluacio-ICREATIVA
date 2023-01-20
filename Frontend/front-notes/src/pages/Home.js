import React, {useEffect, useState} from "react";
import {Login} from "../components/Login";
import {Notes} from "../components/Notes";
import PrimarySearchAppBar from "../components/NavBar";
import Cookies from 'universal-cookie';
const cookie = new Cookies();
export const Home = () => {
    const [getLogin,setLogin] = useState(true);
    useEffect(()=>{
        if (cookie.get('token')){
            setLogin(false);
        }
    },[getLogin])
    return (
        <>

            {getLogin ? <Login/> :
                <>
                    <PrimarySearchAppBar/>
                    <Notes/>
                </>
            }
        </>
    )
}