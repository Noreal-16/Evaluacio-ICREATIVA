import * as React from "react";
import {FormNotes} from "./FormNotes";
import {ListNotes} from "./ListNotes";


export const Notes = () => {

    return (
        <div className='container-form-R'>
            <h1>Tareas ( TODO )</h1>
            <FormNotes/>
            <div className='separador1'></div>
            <ListNotes/>
        </div>
    )
}