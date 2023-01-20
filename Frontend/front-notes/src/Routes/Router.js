import React from "react";
import {BrowserRouter, Routes, Route} from "react-router-dom";
import {NotFoud} from "../components/NotFoud";
import {Home} from "../pages/Home";

export const Router = () => {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Home/>}/>
                <Route path="*" element={<NotFoud/>}/>
            </Routes>
        </BrowserRouter>
    )
}