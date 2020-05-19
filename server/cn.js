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
    var cp
    function getJsonCN(v1, v2, v3, v4, v5, v6, v7, v8, v9){
        console.log("Creando carta natal...");
        //cp = spawn('/media/nextsigner/ZONA-A11/nsp/unik-dev-apps/zodiacserver/bin/zodiac_server', ['fileName', '1975', '6', '20', '22', '00', '-3', '-35.484462', '-69.5797495', __dirname+'/bios-files/data.json']);

    }

    newCN = function(req, res){
        let v1 = req.query.nom
        let v2 = req.query.a
        let v3 = req.query.m
        let v4 = req.query.d
        let v5 = req.query.h
        let v6 = req.query.min
        let v7 = '-3'
        let v8 = req.query.lat
        let v9 = req.query.lon
        let v10=req.query.loc
        let date=new Date(Date.now())
        let ms=date.getTime()
        let fn=__dirname+'/bios-files/'+ms+'_'+v1+'.json'
        console.log('Get new cn: '+v1+' '+v2+' '+v3+' '+v4+' '+v5+' '+v6+' '+v7+' '+v8+' '+v9+' '+v10+' '+fn+' '+ms)
        cp = spawn('/media/nextsigner/ZONA-A11/nsp/unik-dev-apps/zodiacserver/bin/zodiac_server', [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, fn, ms]);
        cp.stdout.on("data", function(data) {
            //console.log(data.toString().trim());
            if(data.toString().trim().indexOf('AppSettings: saved to')>=0){
                res.status(200).send({'file':''+ms+'_'+v1})
            }
        });
        cp.stderr.on("data", function(data) {
            //console.error(data.toString());
            if(data.toString().trim().indexOf('AppSettings: saved to')>=0){
                res.status(200).send({'file':''+ms+'_'+v1})
            }
        });
    }
    app.get('/cn/get', newCN);
}
