import React,{ useState } from "react";
import './Card.css'

function Card({image,name,role,id,eth_address,home_address,join_date}) {

    return(
        <div className="Card">
            <div className="upper-container">
                <div className="image-container">
                    <img src= {image} alt = "profile_pic" height="100px" width="100px" />

                </div>
            </div>
            <div className="lower-container">
                <h3> { name } </h3>
                <h4> { role } </h4>
                <p> DNI/NIE:</p> 
                <p class="eth"> {id} </p>
                <p> Blockchain Address:</p>
                <p class="eth"> {eth_address} </p>
                <p> Home address:</p>
                <p class="eth"> {home_address} </p>
                <p> Join date: </p>
                <p class="eth"> {join_date} </p>
                <button>Records</button>
            </div>
        </div>
    )
}

export default Card