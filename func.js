function capital_letter(str){
    str = str.split(" ");

    for (let i = 0, x = str.length; i < x; i++) {
        str[i] = str[i][0].toUpperCase() + str[i].substr(1);
    }

    return str.join(" ");
}
function speak(text){
    let s = ''+text.replace(/<br \/>/g, '')
    unik.speak(s)
}

function getHttpToItem(url, item){
    var req = new XMLHttpRequest();
    let d = new Date(Date.now())
    req.open('GET', 'https://www.astro.com/h/awt/ppos2_s.htm?code=f0aa269af58bda9dbf95d64c2a4e8a07&r='+d.getTime(), true);
    req.onreadystatechange = function (aEvt) {
        if (req.readyState === 4) {
            if(req.status === 200){
                let m0= req.responseText.split('<tr>')
                for(let i=0;i<12;i++){
                    let d0 = (''+m0[i+2])
                    let m1= d0.split('<td')

                    //img
                    //let d = 'm1[1]'

                    //Nombre Planeta
                    //let d = 'm1[2]'

                    //Grados
                    let g0=m1[3].split('>')
                    let g1=g0[1].split('<')
                    //logView.showLog('XXX'+g1[0]+'XXX')
                    if(i===1){
                        r.cGradoLuna=parseInt(g1[0])

                    //repTrans.arrayGrados.push(' está a °'+g1[0]+ ' de ')

                    //Signo
                    let s0=m1[4].split('alt=\"')
                    let s1=s0[1].split('\"')
                    let s2=''+s1[0]

                    cNumSigno=parseInt(app.signos.indexOf(s2) + 1)
                  }
                }
            }else{
                logView.showLog("Error loading page\n");
            }
        }
    };
    req.send(null);
}

/*


Puede ser muy extremo y funcionar de manera muy opuesta al mismo tiempo.

Podemos intimidar a la gente o mal vistos.
Percibido como cargado de malas intenciones.
Es posible que la gente nos vea como algo temible.

La gente nos puede ver como alguien indestructible.
Nos van a pedir ayuda.
Por ser capaces de apoyar a otros dependerán más de nosotros.

*/
