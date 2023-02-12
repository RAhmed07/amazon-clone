
//IMPORT FROM PACKAGES
const express = require("express");
const mongoose =require('mongoose');
const adminRouter = require("./routes/admin");

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

//INIT

const PORT = 3000;
const app = express();
const DB = "mongodb+srv://salvi:salviahmed420@cluster0.cz74lkh.mongodb.net/?retryWrites=true&w=majority";

//middlewere
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Connections

mongoose.connect(DB).then(()=>{
    console.log("connection successful")
}).catch((e)=>{
    console.log(e);
})



app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`Connected at Port ${PORT}`);
});