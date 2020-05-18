module.exports=function(app, adminEmail, adminEmailPass){

    const User = require('./models/User')

    var nodemailer = require('nodemailer');
    var transporter = nodemailer.createTransport ({
    service: 'gmail',
    auth: {
            user: adminEmail,
            pass: adminEmailPass
        }
    });
    function enviarCorreo(f,t,s,d){
        const mailOptions = {
          from: f,
          to: t,
          subject:s,
          text: d
        };
        transporter.sendMail (mailOptions, function (err, info) {
           if (err){
            console.log (err)
           }else{
            console.log (info);
           }
        });
    }
    //Probar Email (hay que tener exportado la variable de entorno EMAILPASS)
    //enviarCorreo('nextsigner@gmail.com','qtpizarro@gmail.com','probando EMAILPASS','Estoy probando');   

    newUserId = function(req, res){
        console.log('Get new user id...')
        let user = new User()
        user.nombre = 'undefined'
        user.fechaRegistro = new Date(Date.now()).toString()
        user.save(function(err, userRegistered){
            if(err){
                res.status(500).send(`Error when user register: ${err}`)
                return
            }
            res.status(200).send({'user':userRegistered})
        })
    }

    setChatUser = function(req, res){
        let userId = req.query.userId
        let update = req.body
        User.findByIdAndUpdate(userId, update, function(err, userUpdated){
            if(err) res.status(500).send(`Error when user register: ${err}`)
            console.log('setChatUser: '+userUpdated)
            res.status(200).send({'user':userUpdated})
        })
    }

    getChatUser = function(req, res){
        console.log('Receiving get '+req.query.userId)
        let userid= req.query.userId
        User.findById(userid, function(err, user){
            if(err){
                res.status(500).send({user: `Error al buscar usuario: ${err}`})
                return
            }
            if(!user){
                res.status(200).send({'user': false})
                return
            }
            res.status(200).send({'user': user})
        })
    }

    app.get('/chat/get/newuserid', newUserId);
    app.get('/chat/set/user', setChatUser);
    app.get('/chat/get/user', getChatUser);
}
