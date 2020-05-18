module.exports=function(app, adminEmail, adminEmailPass){

//     var nodemailer = require('nodemailer');
//    var transporter = nodemailer.createTransport ({
//                                                      service: 'gmail',
//                                                      auth: {
//                                                          user: adminEmail,
//                                                          pass: adminEmailPass
//                                                      }
//                                                  });
//    function enviarCorreo(f,t,s,d){
//        const mailOptions = {
//            from: f,
//            to: t,
//            subject:s,
//            text: d
//        };
//        transporter.sendMail (mailOptions, function (err, info) {
//            if (err){
//                console.log (err)
//            }else{
//                console.log (info);
//            }
//        });
//    }
    //Probar Email (hay que tener exportado la variable de entorno EMAILPASS)
    //enviarCorreo('nextsigner@gmail.com','qtpizarro@gmail.com','probando EMAILPASS','Estoy probando');
    var spawn = require('child_process').spawn;
    function getJsonCN(){
        console.log("Creando carta natal...");
        cp = spawn('/media/nextsigner/ZONA-A11/nsp/unik-dev-apps/zodiacserver/bin/zodiac_server', ['fileName', '1975', '6', '20', '22', '00', '-3', '-35.484462', '-69.5797495', __dirname+'/bios-files/data.json']);
        cp.stdout.on("data", function(data) {
            console.log(data.toString().trim());
        });
        cp.stderr.on("data", function(data) {
            console.error(data.toString());
        });
    }

    newCN = function(req, res){
        console.log('Get new cn...')
        let v1 = req.query.d
        console.log('d: '+v1)
        getJsonCN()
        res.status(200).send({'user':''+v1})
    }

    app.get('/cn/get', newCN);
}
