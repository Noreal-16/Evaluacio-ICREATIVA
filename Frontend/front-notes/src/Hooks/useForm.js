import {useState} from "react";


export const UseForm =(initialValues={})=>{
    const [values, setValues]= useState(initialValues);
    const handleInputChange =({target})=>{
        const {name, value} = target;
        setValues({
            ...values,
            [name]:value
        })
    }
    return{...values, values, handleInputChange}
}