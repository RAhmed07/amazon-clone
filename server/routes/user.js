const express = require('express');
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require('../models/product');
const User = require('../models/user');

//Add to the cart
userRouter.post('/api/add-to-cart', auth,  async (req, res)=>{

    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.cart.length == 0){
            user.cart.push({product, quantity: 1});
        }else{
            let productFound = false;
            for(let i =0; i< user.cart.length; i++){
                if(user.cart[i].product._id.equals(product._id)){
                    productFound = true;
                }
            }

            if(productFound){
                let producttt = user.cart.find((productt)=>
                    productt.product._id.equals(product._id)
                );
                producttt.quantity += 1;
            }else{
                user.cart.push({product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);

    }catch(err){
        res.status(500).json({error: err.message});
    }

});


//Remove From the cart
userRouter.delete('/api/remove-from-cart/:id', auth,  async (req, res)=>{

    try{
        const {id} = req.params; // you can use also (req.params.id)
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

       
            
            for(let i =0; i< user.cart.length; i++){
                if(user.cart[i].product._id.equals(product._id)){
                   
                    if(user.cart[i].quantity == 1){
                        user.cart.splice(i,1);
                    }else{
                        user.cart[i].quantity -= 1;
                    }
                }
            }

            user = await user.save();
            res.json(user);
        }
        

    catch(err){
        res.status(500).json({error: err.message});
    }

});
module.exports = userRouter;