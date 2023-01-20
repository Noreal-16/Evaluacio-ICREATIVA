import React from "react";
export const FormNotes =()=>{
    return(
        <form>
            <div className="mb-3">
                <label htmlFor="inputTextureClass" className="form-label">Descripción</label>
                <input type="text" name='textureClass' className="form-control" id="inputTextureClass"
                       placeholder='Descripción de la Tarea'/>

            </div>
        </form>
    )
}