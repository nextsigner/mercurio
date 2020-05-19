import QtQuick 2.0

Item {
    signal httpResponse(string r)
    signal httpResponseError
    function setHttpResponse(r){
        httpResponse(r)
    }
    function getHttp(url){
        console.log('Get http '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    setHttpResponse(req.responseText)
                }else{
                    httpResponseError()
                }
            }
        };
        req.send(null);
    }
}
