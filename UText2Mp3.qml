import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebView 1.1

Item{
    id: r
    width: 2500
    height: 2500
    anchors.top: parent.bottom
    property bool speaked: false

    property string text: 'Convertidor de Texto a Voz sin texto definido'
    property string html: ''
    
    property string activationMessage: 'Audio Activado.'
    property int indexLang: 0
    property var arrayLanguages: ["es-ES_EnriqueVoice", "es-ES_EnriqueV3Voice", "es-ES_LauraVoice", "es-ES_LauraV3Voice", "es-LA_SofiaVoice","es-LA_SofiaV3Voice","es-US_SofiaVoice","es-US_SofiaV3Voice" ]
    BotonUX{
        id: btnAudioActivation
        text: 'Activar Audio'
        anchors.bottom: r.top
        //enabled: false
        onClicked: {
            //speakMp3(r.activationMessage)
        }
    }
    WebView{
        id: wvtav
        width: parent.width
        height: parent.height
        opacity:0.0
        anchors.top: btnAudioActivation.top
        anchors.horizontalCenter: btnAudioActivation.horizontalCenter
        //anchors.topMargin: -300
        onLoadProgressChanged:{
            if(loadProgress===100){
            }
        }
    }
    Timer{
        id: tInit
        running: true
        repeat: true
        interval: 2000
        onTriggered: {
            speakMp3(r.activationMessage)
        }
    }

    Timer{
        id: tInit3
        running: true
        repeat: true
        interval: 500
        onTriggered: {
            running=false
            wvtav.runJavaScript('function aip(){var audio100=document.getElementById(\'audioElement1\');return audio100.duration > 0 && !audio100.paused}; aip();', function(result) {
                //console.log('RP: '+result)
                if(result===true){
                    tInit.stop()
                    btnAudioActivation.clicked()
                    stop()
                    //xStart.color='red'
                    btnAudioActivation.visible=false
                    wvtav.opacity=0.0
                    r.speaked=true
                    return
                }
                running=true
            });
        }
    }
    Component.onCompleted: {
        r.html='
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8"/>
    <title>Texto a voz | Lector de textos con voz Gratis Online | TTS Multilingüe (en español) para tu ordenador, tu teléfono y tu tablet.</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel=\'stylesheet prefetch\' href=\'https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900%7CRobotoDraft:400,100,300,500,700,900\'>
    <link rel=\'stylesheet prefetch\' href=\'https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css\'>
    <link rel="stylesheet" type="text/css" href="style2.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="icon" href="/favicon.ico" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="wot-verification" content="befca0a22902d48b96c1"/>
    <meta name="keywords" content="Texto a voz,gratis online,español,tts reader,tts chrome,tts natural,tts human,tts realistic,high quality,voices,speech synthesis,tts app,tts generator,tts convert,tts htc,tts android,multilingual,tts uk,tts us,Inglés, Alemán, Francés, texto a voz, ruso, portugués, italiano, japonés, holandés, Nederlands, indonesio, hindi, coreano, chino, Hong Kong, dispositivos, TTS pc, TTS iphone, TTS tableta, TTS ipad, TTS de teléfonos inteligentes, artículos, e-learning, e-books, libros de audio, TTS Samsung, Nokia TTS, TTS celular, teléfono TTS, móvil, ilimitado.">
    <meta name="description" content="TTS Robot Reader - Convertir texto a voz con voces que suenan naturales y comprensibles
(palabras dichas),basadas en grabaciones de voz humana,ilimitado. Idiomas: es-ES, fr-FR, it-IT, de-DE, ru-RU, pt-BR, nl-Nl, id-ID, hi-IN, ja-JP, ko-KR, Zh-CN, zh_HK.">



    <script src=\'https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js\'></script>


    <script data-ad-client="ca-pub-9116938576941055" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<style>
.tabset > input[type="radio"] {
  position: absolute;
  left: -200vw;
}

.tabset .tab-panel {
  display: none;
}

.tabset > input:first-child:checked ~ .tab-panels > .tab-panel:first-child,
.tabset > input:nth-child(3):checked ~ .tab-panels > .tab-panel:nth-child(2),
.tabset > input:nth-child(5):checked ~ .tab-panels > .tab-panel:nth-child(3),
.tabset > input:nth-child(7):checked ~ .tab-panels > .tab-panel:nth-child(4),
.tabset > input:nth-child(9):checked ~ .tab-panels > .tab-panel:nth-child(5),
.tabset > input:nth-child(11):checked ~ .tab-panels > .tab-panel:nth-child(6) {
  display: block;
}

/*
 Styling
*/

.tabset > label {
  position: relative;
  display: inline-block;
  padding: 15px 15px 25px;
  border: 1px solid transparent;
  border-bottom: 0;
  cursor: pointer;
  font-weight: 600;
}

.tabset > label::after {
  content: "";
  position: absolute;
  left: 15px;
  bottom: 10px;
  width: 22px;
  height: 4px;
  background: #ccc;
}

.tabset > label:hover,
.tabset > input:focus + label {
  color: #ed2553;
}

.tabset > label:hover::after,
.tabset > input:focus + label::after,
.tabset > input:checked + label::after {
  background: #ed2553;
}

.tabset > input:checked + label {
  border-color: #ed2553;
  border-bottom: 1px solid #fff;
  margin-bottom: -1px;
}

.tab-panel {
  padding: 30px 0;
  border-top: 1px solid #ccc;
}

/*
 Demo purposes only
*/
*,
*:before,
*:after {
  box-sizing: border-box;
}

.tabset {
  max-width: 65em;
}
hr.new3 {
  border-top: 1px dotted #F1F1F1;
}
hr.new2 {
  border-top: 1px dashed #F1F1F1;
}
input[type="range"] {
  -webkit-appearance: none;
  -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
  width: 77%;
  height: 5px;
  margin: 0;
  border: none;
  padding: 1px 2px;
  border-radius: 7px;
  background: #ed2553;
  box-shadow: inset 0 1px 0 0 #ed2553, inset 0 -1px 0 0 #ed2553;
  -webkit-box-shadow: inset 0 1px 0 0 #ed2553, inset 0 -1px 0 0 #ed2553;
  outline: none;
  /* no focus outline */
}



input[type="range"]::-ms-track {
  border: inherit;
  color: transparent;
  /* don\'t drawn vertical reference line */
  background: transparent;
}

a {
  color: #ed2553;
}

/* thumb */
input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 40px;
  height: 20px;
  border: none;
  border-radius: 2px;
  /* android <= 2.2 */
  /* older mobile safari and android > 2.2 */
  background-image: linear-gradient(to bottom, #ed2553 0, #ed2553 100%);
  /* W3C */
}

#area::selection {
  background: #ffff00;
  color:#000;
}
select {text-transform:capitalize}



#TextToSpeechImage {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
    display: block;
    margin-left: auto;
    margin-right: auto
}

#TextToSpeechImage:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
}

/* Caption of Modal Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation */
.modal-content, #caption {
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)}
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)}
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}

.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
    }
}
</style>








<script>

function clearContent()
{
    document.getElementById("textToSpeak").value=\'\';
}
</script>

<script>

function yourFunction(){
     document.getElementById(\'textToSpeak_lbm\').value = "";
};
</script>

</head>

<body>

<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v4.0"></script>


    <!-- TTS Multilingual -->

    <div class="pen-title">
        <h1>Lector de textos con voz Online</h1>
    </div>

    <div class="container">
<div style="text-align:center">
        <div class="card">
                <a href="https://texttospeechrobot.com/tts/us/text-to-speech-online/" class="ttsflags">TTS<br>en<br><img src="images/tts_us_english.png" alt="Text To Speech Us English"></a>
                <a href="https://texttospeechrobot.com/tts/es/texto-a-voz/" class="ttsflags">TTS<br>es<br><img src="images/tts_spanish.png" alt="Text To Speech Online Spanish"></a>
                <a href="https://texttospeechrobot.com/tts/fr/synthese-vocale-en-ligne/" class="ttsflags">TTS<br>fr<br><img src="images/tts_french.png" alt="Text To Speech Online French"></a>
                <a href="https://texttospeechrobot.com/tts/de/text-zu-sprache/" class="ttsflags">TTS<br>de<br><img src="images/tts_german.png" alt="Text To Speech Online Deutsch"></a>
                <a href="https://texttospeechrobot.com/tts/pt/leitor-de-texto/" class="ttsflags">TTS<br>pt<br><img src="images/tts_portuguese.png" alt="Text To Speech Online Portuguese"></a>
                <a href="https://texttospeechrobot.com/text-to-speech-online.htm" class="ttsflags">TTS<br>id<br><img src="images/tts_indonesian.png" alt="Text To Speech Online Bahasa Indonesia"></a>
                <a href="https://texttospeechrobot.com/tts/tr/konusma-sentezleyici-yaziyi-sese-cevirme/" class="ttsflags">TTS<br>tr<br><img src="images/tts_turkish.png" alt="Text To Speech Online Turkish Turkey"></a>
                <a href="https://texttospeechrobot.com/text-to-speech-online.htm" class="ttsflags">TTS<br>in<br><img src="images/tts_hindi-india.png" alt="Text To Speech Online Hindi India"></a>
                <a href="https://texttospeechrobot.com/tts/ru/sintezator-rechi-onlayn/" class="ttsflags">TTS<br>ru<br><img src="images/tts_russian.png" alt="Text To Speech Russian"></a>
                <a href="https://texttospeechrobot.com/tts/it/da-testo-a-voce/" class="ttsflags">TTS<br>it<br><img src="images/tts_italian.png" alt="Text To Speech Italiano"></a>
                <a href="https://texttospeechrobot.com/tts/pl/zamiana-tekstu-na-mowe/" class="ttsflags">TTS<br>pl<br><img src="images/tts_polish-pl.png" alt="Text To Speech Polish"></a>
                <a href="https://texttospeechrobot.com/tts/nl/tekst-naar-spraak/" class="ttsflags">TTS<br>nl<br><img src="images/tts_Dutch-nl.gif" alt="Text To Speech Dutch Nl Nederlands - Netherlands"></a>
                <a href="https://texttospeechrobot.com/text-to-speech-free-online.htm" class="ttsflags">TTS<br>ja<br><img src="images/tts_japanese.png" alt="Text To Speech Japanese"></a>
                <a href="https://texttospeechrobot.com/text-to-speech-free.htm" class="ttsflags">TTS<br>ko<br><img src="images/tts_korean.png" alt="Text To Speech Korean"></a>
                <a href="https://texttospeechrobot.com/text-to-speech-online-free.htm" class="ttsflags">TTS<br>zh<br><img src="images/tts_chinese.png" alt="Text To Speech Chinese"></a>


        </div>
        </div>
        <div class="card">
            <h2 class="title">Texto a voz Español Gratis.</h2>


            <div id="content">
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- texto-a-voz -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-9116938576941055"
     data-ad-slot="1055484039"
     data-ad-format="link"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>


<br>
<br>
<br>
<div class="tabset">
  <!-- Tab 1 -->
  <input type="radio" name="tabset" id="tab1" aria-controls="marzen" checked>
  <label for="tab1">Karaoke Version</label>
  <!-- Tab 2 -->
  <input type="radio" name="tabset" id="tab2" aria-controls="rauchbier">
  <label for="tab2">MP3 Versión 3.0</label>
  <!-- Tab 3 -->


  <div class="tab-panels">

   <section id="rauchbier" class="tab-panel">
<br>
      <p>


                <div id="buttons_row">
                    <!-- Page Content -->
                    <!-- Web Page content
                        <div id="download_mp3_button"></div>
                        -->
<div id="left_half_container">
    <div id="left_buttons">

        <a class="clear_button" id="clear_button" onclick="clearText();">Clear Text</a>
        <a class="reset_button" id="reset_button" onclick="goToBeginning()">rePlay</a>
    </div>
</div>
<div id="right_half_container">
    <div id="right_buttons">
        <select id="select_language" class="button" onchange="updateLanguage();">
            <option value="es-ES" selected="selected">Spanish</option>
            <option value="es-US">US Spanish</option>
            <option value="en-GB">UK English</option>
            <option value="en-US">US English</option>
            <option value="fr-FR">French</option>
            <option value="ru-RU">Russian</option>
            <option value="de-DE">German</option>
            <option value="pt-BR">Portuguese 1</option>
            <option value="pt-PT">Portuguese 2</option>
            <option value="it-IT">Italiano</option>
            <option value="nl-NL">Dutch NL</option>
            <option value="id-ID">Indonesian</option>
            <option value="ru-RU">Russian</option>
            <option value="hi-IN">Hindi</option>
            <option value="pl-PL">Polish</option>
            <option value="ja-JP">Japanese</option>
            <option value="ko-KR">Korean</option>
            <option value="zh-CN">Chinese</option>
            <option value="zh-HK">Chinese HK</option>
            <option value="ar-SA">iOS Arabic</option>
            <option value="en-AU">iOS Au English</option>
            <option value="el-GR">iOS Greek</option>
            <option value="pt-PT">iOS Portuguese</option>
            <option value="nb-NO">iOS Norwegian</option>
            <option value="fi-FI">iOS Finnish</option>
            <option value="sv-SE">iOS Swedish</option>
            <option value="da-DK">iOS Danish</option>
            <option value="ro-RO">iOS Romanian</option>
            <option value="hu-HU">iOS Hungarian</option>
            <option value="cs-CZ">iOS Czech</option>
            <option value="BOT-BOT">or Robotic</option>
        </select>

                        </div>
                    </div>
                    <div id="speak_button_container">
                        <br>

                            <div style="text-align:center" id="speak_button" onclick="startOrPause();" title="Play & Pause"></div>

                    </div>
                </div>

                <!-- Web Page Content -->
                <textarea id="text_box" placeholder=\'*Type ,Paste or Load File here.

Why weary your eyes on Phone, Pc, Tablet etc. reading texts, articles, e-books, textbooks when *Text To Speech Robot* can read out for you and all you need is:
Just type your Text here or paste any Text (example: copied text from news sites, sports sites, medical and health sites etc.) you would like our program to read out for you.

Select Language or Speed & Click the "Play" button and Voila, Enjoy listening your Text, just sit back, relax, close your eyes and listen to the stuff you needed to read.

* If you accidentally close the browser ,dont worry our Robot remembers the last word when paused,so you can come back to listening right where you previously left.
* To change reading start-point, move the pointer- mouse cursor to the desired of text part.
\'></textarea>
                <div class="zero_height_container">
                    <textarea id="text_box_mirror"></textarea>
                </div>


                               <br>
<p>
                    <input value="Load File" type="button">
                    <input id="file" onchange="setTimeout(\'loadfile(\'file\',\'text_box\')\',100);" type="file">
<br>

                            <select id="select_speed" class="button" onchange="updateSpeed();">
                                <option value=0.9>Default Speed</option>
                                <option value=0.1>0.1</option>
                                <option value=0.2>0.2</option>
                                <option value=0.3>0.3</option>
                                <option value=0.4>0.4</option>
                                <option value=0.5>0.5</option>
                                <option value=0.6>0.6</option>
                                <option value=0.7>0.7</option>
                                <option value=0.8>0.8</option>
                                <option value=0.9>Default Speed</option>
                                <option value=1.0>1.0</option>
                                <option value=1.1>1.1</option>
                                <option value=1.2>1.2</option>
                                <option value=1.3>1.3</option>
                                <option value=1.4>1.4</option>
                                <option value=1.5>1.5</option>
                                <option value=1.6>1.6</option>
                                <option value=1.7>1.7</option>
                                <option value=1.8>1.8</option>
                                <option value=1.9>1.9</option>
                                <option value=2.0>2.0</option>

                            </select><br><br>
                            <select id="select_pitch" class="button" onchange="updatePitch();">
                                <option value=1.0>Default Pitch</option>
                                <option value=0.1>0.1</option>
                                <option value=0.2>0.2</option>
                                <option value=0.3>0.3</option>
                                <option value=0.4>0.4</option>
                                <option value=0.5>0.5</option>
                                <option value=0.6>0.6</option>
                                <option value=0.7>0.7</option>
                                <option value=0.8>0.8</option>
                                <option value=0.9>0.9</option>
                                <option value=1.0>Default Pitch</option>
                                <option value=1.1>1.1</option>
                                <option value=1.2>1.2</option>
                                <option value=1.3>1.3</option>
                                <option value=1.4>1.4</option>
                                <option value=1.5>1.5</option>
                                <option value=1.6>1.6</option>
                                <option value=1.7>1.7</option>
                                <option value=1.8>1.8</option>
                                <option value=1.9>1.9</option>
                                <option value=2.0>2.0</option>
                                <option value=3.0>3.0</option>
                            </select>
                </p>


    </section>











    <section id="marzen" class="tab-panel">



<div class="row option">
<div class="col-md-3">
<label for="selectlang_lbm">Select Language.</label>
</div>
<div class="col-md-9">
<select id="selectlang_lbm">
<option value="es-ES_EnriqueVoice" selected="selected">Castilian Spanish (es-ES): Enrique [IBM-Male]</option>
<option value="es-ES_EnriqueV3Voice">Castilian Spanish (es-ES): EnriqueV3 (male, enhanced dnn)</option>
<option value="es-ES_LauraVoice" >Castilian Spanish (es-ES): Laura [IBM-Female]</option>
<option value="es-ES_LauraV3Voice" >Castilian Spanish (es-ES): LauraV3 [IBM-Female, enhanced dnn]</option>
<option value="es-LA_SofiaVoice" >Latin American Spanish (es-LA): Sofia [IBM-Female]</option>
<option value="es-LA_SofiaV3Voice" >Latin American Spanish (es-LA): SofiaV3 [IBM-Female, enhanced dnn]</option>
<option value="es-US_SofiaVoice" >North American Spanish (es-US): Sofia [IBM-Female]</option>
<option value="es-US_SofiaV3Voice" >North American Spanish (es-US): SofiaV3 [IBM-Female, enhanced dnn]</option>
<option value="en-US_AllisonVoice" >American English (en-US): Allison (IBMfemale, expressive, transformable)</option>
<option value="en-US_AllisonV3Voice" >American English (en-US): AllisonV3 [IBM-Female, enhanced dnn]</option>
<option value="en-US_LisaVoice" >American English (en-US): Lisa (female, transformable)</option>
<option value="en-US_LisaV3Voice" >American English (en-US): LisaV3 [IBM-Female, enhanced dnn]</option>
<option value="en-US_MichaelVoice" >American English (en-US): Michael (male, transformable)</option>
<option value="en-US_MichaelV3Voice" >American English (en-US): MichaelV3 (male, enhanced dnn)</option>
<option value="ar-AR_OmarVoice" >Arabic (ar-AR): Omar [IBM-Male]</option>
<option value="pt-BR_IsabelaVoice" >Brazilian Portuguese (pt-BR): Isabela [IBM-Female]</option>
<option value="pt-BR_IsabelaV3Voice" >Brazilian Portuguese (pt-BR): IsabelaV3 [IBM-Female, enhanced dnn]</option>
<option value="en-GB_KateVoice" >British English (en-GB): Kate [IBM-Female]</option>
<option value="en-GB_KateV3Voice" >British English (en-GB): KateV3 [IBM-Female, enhanced dnn]</option>
<option value="fr-FR_ReneeVoice" >French (fr-FR): Renee [IBM-Female]</option>
<option value="fr-FR_ReneeV3Voice" >French (fr-FR): ReneeV3 [IBM-Female, enhanced dnn]</option>
<option value="de-DE_BirgitVoice" >German (de-DE): Birgit [IBM-Female]</option>
<option value="de-DE_BirgitV3Voice" >German (de-DE): BirgitV3 [IBM-Female, enhanced dnn]</option>
<option value="de-DE_DieterVoice" >German (de-DE): Dieter [IBM-Male]</option>
<option value="de-DE_DieterV3Voice" >German (de-DE): DieterV3 (male, enhanced dnn)</option>
<option value="it-IT_FrancescaVoice" >Italian (it-IT): Francesca [IBM-Female]</option>
<option value="it-IT_FrancescaV3Voice" >Italian (it-IT): FrancescaV3 [IBM-Female, enhanced dnn]</option>
<option value="nl-NL_EmmaVoice" >Dutch (nl-NL): Emma [IBM-Female]</option>
<option value="nl-NL_LiamVoice" >Dutch (nl-NL): Liam [IBM-Male]</option>
<option value="ja-JP_EmiVoice" >Japanese (ja-JP): Emi [IBM-Female]</option>
<option value="ja-JP_EmiV3Voice" >Japanese (ja-JP): EmiV3 [IBM-Female, enhanced dnn]</option>
<option value="zh-CN_LiNaVoice" >Chinese, Mandarin (zh-CN): LiNa [IBM-Female]</option>
<option value="zh-CN_WangWeiVoice" >Chinese, Mandarin (zh-CN): WangWei [IBM-Male]</option>
<option value="zh-CN_ZhangJingVoice" >Chinese, Mandarin (zh-CN): ZhangJing [IBM-Female]</option>
</select>
</div>
</div>
<div class="row option">
<div class="col-md-12">


<textarea placeholder="Enter or paste your text here." class="text-box" name="textToSpeak_lbm" id="textToSpeak_lbm" maxlength="5000"></textarea>

        </div>
</div>



        <button class="btn btn-skin" onClick="yourFunction();">Delete Text</button>
        <button class="btn btn-skin" onclick=\'submitTranslation1()\'>Convert</button>

<br><br>
<label>Play or Download & Rename Audio File To .mp3</label><br/>

    <div id="audioBlock1">
        <audio id="audioElement1" class="fullWidth" controls="controls">
Your browser does not support the audio element.</audio>
        <span id="debugText1"></span>
    </div>

<br>
<br>


<img src="texttospeechrenamemp3.jpg" alt="TTS Download & Rename file .mp3">

<br>
<br>

  </section>
<br>
<br>
<br>
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- texttospeechES -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-9116938576941055"
     data-ad-slot="9153368151"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>


  </div>

</div>






                <!-- Webdescription Page Content -->


                    <!--
                        <div id="text_box" contenteditable="true" onclick="removePlaceholder();">
                                <p id="placeholder">*Type ,Paste or Load File here.<br><br>Why weary your eyes on Phone, Pc, Tablet etc. reading texts, articles, e-books, textbooks when *Text To Speech Robot* can read out for you and all you need is:<br>
Just type your Text here or paste any Text (example: copied text from news sites, sports sites, medical and health sites etc.) you would like our program to read out for you.<br>

Select Language or Speed &amp; Click the "Play" button and Voila, Enjoy listening your Text, just sit back, relax, close your eyes and listen to the stuff you needed to read.<br>

*-If you accidentally close the browser don t worry our Robot remembers the last word when paused,so you can come back to listening right where you previously left.<br>
*-To change reading start-point, move the pointer- mouse cursor to the desired of text part.
                                </p>
                        </div>
                        -->

            </div>
        </div>
        <!--
                        <div id="text_box" contenteditable="true" onclick="removePlaceholder();">
                                <p id="placeholder">Type ,Paste or Load File here.
                                        <br>Why weary your eyes on Phone, Pc, Tablet etc. reading texts, articles, e-books, textbooks when *Text To Speech Robot* can read out for you and all you need is:
                                        <br>Just type your Text here or paste any Text (example: copied text from news sites, sports sites, medical and health sites etc.) you would like our program to read out for you.
                                        <br>Select Language or Speed &amp; Click the "Play" button and Voila, Enjoy listening your Text, just sit back, relax, close your eyes and listen to the stuff you needed to read.
                                        <br>If you accidentally close the browser ,dont worry our Robot remembers the last word when paused,so you can come back to listening right where you previously left.
                                        <br>To change reading start-point, move the pointer- mouse cursor to the desired of text part.
                                </p>
                        </div>
                        -->
        <!-- Service Description Bar -->



      <br>


        <div class="card">
            <h2 class="title">Convertidor de texto a voz.<br><br>Versión 2.0</h2>

<br>

            <div id="content1">

<br>

<div id="up">



          <label>Select Language.</label>

<br>

            <select v-model="voiceindex">
            <option v-for="voice in voiceselect" :value="voice.value">{{voice.text}}</option>
            </select>

<br>
<br>

<label>Introducir un texto:</label>

<br>

<textarea id="area" ref="area" v-model="area" class="text-box"></textarea>

<br>

<button type="button" @click="SpeechForm.resetform()" class="btn btn-skin">Borrar</button>

            <button type="button" v-on:click="SpeechForm.stopbtn()" class="btn btn-skin">Stop</button>

            <button type="button" v-on:click="SpeechForm.playbtn()" class="btn btn-skin">Play & Pause</button>



<br>
<br>
<br>
Rate:<span><output name="amountR" id="amountR" for="rate">0.9 </output></span>

<label><input type="range" id="rate" name="rate" min="0" max="2" step="0.01" value="0.9" oninput="amountR.value=rate.value"></label>
<br>
Pitch:<span><output name="amountP" id="amountP" for="pitch">1.0 </output></span>

<label><input type="range" id="pitch" name="pitch" min="0.1" step="0.1" max="2" value="1.0" oninput="amountP.value=pitch.value"></label>

<br>
<br>
<br>
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- texttospeech -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-9116938576941055"
     data-ad-slot="2921411126"
     data-ad-format="auto"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
<br>
<br>
<br>

Para obtener más opciones de Read Aloud de voces masculinas y femeninas (basadas en el género), incluidos discursos con acento regional y dialectos étnicos, haga clic en
<a href="https://TextToSpeechRobot.com" target="_parent">Texto a Voz</a>.<br> Todas las voces de computadora, teléfono y tableta instaladas en su sistema están disponibles para nuestro Text To Speech Robot Versión 2.0.*(Traductor de Google).
<br>
<br>

                <p class="description_page_content">TextToSpeechRobot.com El mejor servicio gratuito basado en web para Texto a Voz.
                    <br>TTS Robot leerá cualquier texto de la forma más realista y natural de sonido humano en una variedad de idiomas.
                    Convertir texto a voz con voces que suenan naturales y comprensibles,ilimitado(sin límites).
                    <br> Completamente libre de costo No hay instalación y No se requiere registro para su uso. *(Traductor de Google).</p>



</div>

</div>
</div>
</div>


        <div class="container2">
            <div class="card2">
            <div id="content3">


<div class="fb-like" data-href="https://facebook.com/texttospeechrobot" data-width="" data-layout="button_count" data-action="like" data-size="large" data-show-faces="true" data-share="true"></div>

<br>

</div>
</div>
</div>





<p><img id="TextToSpeechImage" src="images/texto-a-voz-online-gratis-espanol.png" alt="Texto A Voz - Lector de textos con voz Online." width="210" height="200"></p>

<!-- The Modal -->
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" alt="TEXTO A VOZ" id="img01">
  <div id="caption"></div>
</div>
    <!-- js script -->

    <script>
        \'use strict\';

        $(document).ready(function() {
            function showError(msg) {
                console.error(\'Error: \', msg);
                var errorAlert = $(\'.error-row\');
                errorAlert.css(\'visibility\', \'hidden\');
                errorAlert.css(\'background-color\', \'#d74108\');
                errorAlert.css(\'color\', \'white\');
                var errorMessage = $(\'#errorMessage\');
                errorMessage.text(msg);
                errorAlert.css(\'visibility\', \'\');
                $(\'body\').css(\'cursor\', \'default\');
                $(\'.speak-button\').css(\'cursor\', \'pointer\');

                $(\'#errorClose\').click(function(e) {
                    e.preventDefault();
                    errorAlert.css(\'visibility\', \'hidden\');
                    return false;
                });
            }

            function onCanplaythrough() {
                console.log(\'onCanplaythrough\');
                var audio = $(\'.audio\').get(0);
                audio.removeEventListener(\'canplaythrough\', onCanplaythrough);
                try {
                    audio.currentTime = 0;
                } catch (ex) {
                    // ignore. Firefox just freaks out here for no apparent reason.
                }
                audio.controls = true;
                audio.muted = false;
                $(\'.result\').show();
                $(\'.error-row\').css(\'visibility\', \'hidden\');
                $(\'html, body\').animate({
                    scrollTop: $(\'.audio\').offset().top
                }, 500);
                $(\'body\').css(\'cursor\', \'default\');
                $(\'.speak-button\').css(\'cursor\', \'pointer\');
            }

            function synthesizeRequest(options, audio) {
                var sessionPermissions = JSON.parse(localStorage.getItem(\'sessionPermissions\')) ? 0 : 1;
                var downloadURL = \'/api/synthesize\' +
                    \'?voice=\' + options.voice +
                    \'&text=\' + encodeURIComponent(options.text) +
                    \'&X-WDC-PL-OPT-OUT=\' + sessionPermissions;

                if (options.download) {
                    downloadURL += \'&download=true\';
                    window.location.href = downloadURL;
                    return true;
                }
                audio.pause();
                audio.src = downloadURL;
                enableButtons(true);
                audio.addEventListener(\'canplaythrough\', onCanplaythrough);
                audio.muted = true;
                audio.play();
                $(\'body\').css(\'cursor\', \'wait\');
                $(\'.speak-button\').css(\'cursor\', \'wait\');
                return true;
            }

            // Global comes from file constants.js
            var voices = SPEECH_SYNTHESIS_VOICES.voices;
            showVoices(voices);

            var voice = \'en-US_AllisonVoice\';

            function isSSMLSupported() {
                //if($(\'#ssmlArea\').val() == japaneseSSML) {
                //  return false;
                //}
                // currently all voices support SSML input
                return true;
            }

            function isVoiceTransformationSSMLSupported() {
                if (voice != \'en-US_AllisonVoice\') {
                    return false;
                }
                return true;
            }

            function disableButtons() {
                $(\'.download-button\').prop(\'disabled\', true);
                $(\'.speak-button\').prop(\'disabled\', true);
            }

            function enableButtons() {
                $(\'.download-button\').prop(\'disabled\', false);
                $(\'.speak-button\').prop(\'disabled\', false);
            }

            function showVoices(voices) {

                var currentTab = \'Text\';

                // Show tabs
                $(\'#nav-tabs a\').click(function(e) {
                    e.preventDefault();
                    $(this).tab(\'show\');
                });

                $(\'a[data-toggle="tab"]\').on(\'shown.bs.tab\', function(e) {
                    currentTab = $(e.target).text();
                    audio.src = \'\';
                    audio.controls = false;
                    if (currentTab === \'SSML\' && isSSMLSupported() === false) {
                        disableButtons();
                    }
                    if (currentTab === \'Voice Transformation SSML\' && isVoiceTransformationSSMLSupported() === false) {
                        console.log("going to disable!")
                        disableButtons();
                    } else {
                        console.log("going to enable! \'" + currentTab + "\'")

                        enableButtons();
                    }
                });

                var LANGUAGE_TABLE = {
                    \'en-US\': \'US English (en-US)\',
                    \'en-GB\': \'UK English (en-GB)\',
                    \'es-ES\': \'Spanish (es-ES)\'
                    \'fr-FR\': \'French (fr-FR)\',
                    \'ru-RU\': \'Russian (ru-RU)\',
                    \'de-DE\': \'German (de-DE)\',
                    \'pt-BR\': \'Portuguese (de-DE)\',
                    \'it-IT\': \'Italiano (it-IT)\',
                    \'ko-KR\': \'Korean (ko-KR)\',
                    \'ja-JP\': \'Nederlands (nl-Nl)\',
                    \'pl-PL\': \'Polish (pl-PL)\'
                    \'id-ID\': \'Indonesian (id-ID)\',
                    \'in-IN\': \'Indndia (in-IN)\',
                    \'zh-CN\': \'Chinese Hong Kong(zh-HK)\'
                    \'ja-JP\': \'Japanese (ja-JP)\',
                    \'zh-CN\': \'Chinese (zh-CN)\'
                    \'ro-BOT\': \'Robotic (ro-BOT)\',
                };

                $.each(voices, function(idx, voice) {
                    var voiceName = voice.name.substring(6, voice.name.length - 5);
                    var optionText = LANGUAGE_TABLE[voice.language] + \': \' + voiceName + \' (\' + voice.gender + \')\';
                    $(\'#dropdownMenuList\').append(
                        $(\'<li>\')
                        .attr(\'role\', \'presentation\')
                        .append(
                            $(\'<a>\').attr(\'role\', \'menu-item\')
                            .attr(\'href\', \'/\')
                            .attr(\'data-voice\', voice.name)
                            .append(optionText)
                        )
                    );
                });

                var audio = $(\'.audio\').get(0),
                    textArea = $(\'#textArea\');

                //var textChanged = false;

                $(\'#textArea\').val(englishExpressiveText);
                $(\'#ssmlArea\').val(englishExpresiveSSML);
                $(\'#ssmlVoiceTransformationArea\').val(usEnglishVoiceTransformationSSML);

                // $(\'#textArea\').change(function(){
                //   textChanged = true;
                // });

                // eslint-disable-next-line complexity
                $(\'#dropdownMenuList\').click(function(evt) {
                    evt.preventDefault();
                    evt.stopPropagation();
                    var newVoiceDescription = $(evt.target).text();
                    voice = $(evt.target).data(\'voice\');
                    $(\'#dropdownMenuDefault\').empty().text(newVoiceDescription);
                    $(\'#dropdownMenu1\').dropdown(\'toggle\');
                    $(\'#ssml_caption\').text(\'SSML\');
                    audio.src = \'\'; // to stop currently playing audio
                    audio.controls = false; // to hide the player
                    enableButtons();

                    var lang = voice.substring(0, 2);
                    switch (lang) {
                        case \'es\':
                            $(\'#textArea\').val(spanishText);
                            $(\'#ssmlArea\').val(spanishSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(spanishVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'fr\':
                            $(\'#textArea\').val(frenchText);
                            $(\'#ssmlArea\').val(frenchSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(frenchVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'de\':
                            $(\'#textArea\').val(germanText);
                            $(\'#ssmlArea\').val(germanSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(germanVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'it\':
                            $(\'#textArea\').val(italianText);
                            $(\'#ssmlArea\').val(italianSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(italianVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'ja\':
                            $(\'#textArea\').val(japaneseText);
                            $(\'#ssmlArea\').val(japaneseSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(japaneseVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'pt\':
                            $(\'#textArea\').val(brazilianPortugueseText);
                            $(\'#ssmlArea\').val(brazilianPortugueseSSML);
                            $(\'#ssmlVoiceTransformationArea\').val(brazilianPortugueseVoiceTransformationSSML);
                            if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            break;
                        case \'en\':
                            if (voice === \'en-US_AllisonVoice\') {
                                $(\'#ssml_caption\').text(\'Expressive SSML\');
                                $(\'#textArea\').val(englishExpressiveText);
                                $(\'#ssmlArea\').val(englishExpresiveSSML);
                                $(\'#ssmlVoiceTransformationArea\').val(usEnglishVoiceTransformationSSML);
                            } else {
                                $(\'#textArea\').val(englishText);
                                var en_accent = voice.substring(0, 5);
                                if (en_accent === \'en-US\') {
                                    $(\'#ssmlArea\').val(usEnglishSSML);
                                    $(\'#ssmlVoiceTransformationArea\').val(voiceTransformationUnsupported);
                                } else if (en_accent === \'en-GB\') {
                                    $(\'#ssmlArea\').val(ukEnglishSSML);
                                    $(\'#ssmlVoiceTransformationArea\').val(voiceTransformationUnsupported);
                                }
                                if (currentTab === \'Voice Transformation SSML\') disableButtons();
                            }
                            break;
                    }
                });

                // IE and Safari not supported disabled Speak button
                if ($(\'body\').hasClass(\'ie\') || $(\'body\').hasClass(\'safari\')) {
                    $(\'.speak-button\').prop(\'disabled\', true);
                }

                if ($(\'.speak-button\').prop(\'disabled\')) {
                    $(\'.ie-speak .arrow-box\').show();
                }

                $(\'.audio\').on(\'error\', function( /*err*/ ) {
                    if (this.src === this.baseURI) {
                        console.log(\'audio.src was reset\');
                        return;
                    }
                    $.get(\'/api/synthesize?text=test\').always(function(response) {
                        showError(response.responseText || \'Error processing the request\');
                    });
                });

                $(\'.download-button\').click(function() {
                    textArea.focus();
                    var text;
                    if (currentTab === \'SSML\' || currentTab === \'Expressive SSML\')
                        text = $(\'#ssmlArea\').val();
                    else if (currentTab === \'Voice Transformation SSML\')
                        text = $(\'#ssmlVoiceTransformationArea\').val()
                    else
                        text = $(\'#textArea\').val()
                    if (validText(voice, textArea.val())) {
                        var utteranceDownloadOptions = {
                            //text: currentTab === \'SSML\' || currentTab === \'Expressive SSML\' ? $(\'#ssmlArea\').val(): $(\'#textArea\').val(),
                            text: text,
                            voice: voice,
                            download: true
                        };
                        synthesizeRequest(utteranceDownloadOptions);
                    }
                });

                $(\'.speak-button\').click(function(evt) {
                    evt.stopPropagation();
                    evt.preventDefault();
                    $(\'.result\').hide();

                    $(\'#textArea\').focus();
                    var text;
                    if (currentTab === \'SSML\' || currentTab === \'Expressive SSML\')
                        text = $(\'#ssmlArea\').val();
                    else if (currentTab === \'Voice Transformation SSML\')
                        text = $(\'#ssmlVoiceTransformationArea\').val()
                    else
                        text = $(\'#textArea\').val()
                        //var text = currentTab === \'SSML\' || currentTab === \'Expressive SSML\' ? $(\'#ssmlArea\').val() : $(\'#textArea\').val();
                    if (validText(voice, text)) {
                        var utteranceOptions = {
                            text: text,
                            voice: voice,
                            sessionPermissions: JSON.parse(localStorage.getItem(\'sessionPermissions\')) ? 0 : 1
                        };

                        synthesizeRequest(utteranceOptions, audio);
                    }
                    return false;
                });

                /**
                 * Check that the text contains Japanese characters only
                 * @return true if the string contains only Japanese characters
                 */
                // function containsAllJapanese(str) {
                //    return str.match(/^[\u3000-\u303f\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\u4e00-\u9faf\u3400-\u4dbf]+$/);
                // }

                function validText(voice, text) {
                    $(\'.error-row\').css(\'visibility\', \'hidden\');
                    $(\'.errorMsg\').text(\'\');
                    $(\'.latin\').hide();

                    if ($.trim(text).length === 0) { // empty text
                        showError(\'Please enter the text you would like to synthesize in the text window.\');
                        return false;
                    }

                    return true;
                }
            }

            (function() {
                // Radio buttons for session permissions
                localStorage.setItem(\'sessionPermissions\', true);
                var sessionPermissionsRadio = $(\'#sessionPermissionsRadioGroup input[type="radio"]\');
                sessionPermissionsRadio.click(function() {
                    var checkedValue = sessionPermissionsRadio.filter(\':checked\').val();
                    localStorage.setItem(\'sessionPermissions\', checkedValue);
                });
            }());

        });
    </script>

    <script>
        var voiceTransformationUnsupported = "Voice Transformation not currently supported for this language"
        var spanishVoiceTransformationSSML = voiceTransformationUnsupported,
            frenchVoiceTransformationSSML = voiceTransformationUnsupported,
            usEnglishVoiceTransformationSSML = "Hello! I\'m Allison but you can change my voice however you wish. <voice-transformation type=\"Custom\" glottal_tension=\"-80%\"> For example, you can make my voice a bit softer, </voice-transformation> <voice-transformation type=\"Custom\" glottal_tension=\"40%\" breathiness=\"40%\"> or a bit strained. </voice-transformation><voice-transformation type=\"Custom\" timbre=\"Breeze\" timbre_extent=\"60%\"> You can alter my voice timbre making me sound like this person, </voice-transformation> <voice-transformation type=\"Custom\" timbre=\"Sunrise\"> or like another person in your different applications. </voice-transformation><voice-transformation type=\"Custom\" breathiness=\"90%\"> You can make my voice more breathy than it is normally. </voice-transformation><voice-transformation type=\"Young\" strength=\"80%\"> I can speak like a young girl. </voice-transformation><voice-transformation type=\"Custom\" pitch=\"-30%\" pitch_range=\"80%\" rate=\"60%\" glottal_tension=\"-80%\" timbre=\"Sunrise\"> And you can combine all this with modifications of my speech rate and my tone. </voice-transformation>",
            ukEnglishVoiceTransformationSSML = voiceTransformationUnsupported,
            germanVoiceTransformationSSML = voiceTransformationUnsupported,
            italianVoiceTransformationSSML = voiceTransformationUnsupported,
            japaneseVoiceTransformationSSML = voiceTransformationUnsupported,
            brazilianPortugueseVoiceTransformationSSML = voiceTransformationUnsupported;

        window.SPEECH_SYNTHESIS_VOICES = {
            voices: [{
                "name": "en-US_AllisonVoice",
                "language": "en-US",
                "customizable": true,
                "gender": "female, expressive, transformable",
                "url": "en-US_AllisonVoice",
                "description": "Allison: American English female voice."
            }, {
                "name": "en-US_MichaelVoice",
                "language": "en-US",
                "customizable": true,
                "gender": "male",
                "url": "en-US_MichaelVoice",
                "description": "Michael: American English male voice."
            }, {
                "name": "en-US_LisaVoice",
                "language": "en-US",
                "customizable": true,
                "gender": "female",
                "url": "en-US_LisaVoice",
                "description": "Lisa: American English female voice."
            }, {
                "name": "en-GB_KateVoice",
                "language": "en-GB",
                "customizable": false,
                "gender": "female",
                "url": "en-GB_KateVoice",
                "description": "Kate: British English female voice."
            }, {
                "name": "fr-FR_ReneeVoice",
                "language": "fr-FR",
                "customizable": false,
                "gender": "female",
                "url": "fr-FR_ReneeVoice",
                "description": "Renee: French (frane7ais) female voice."
            }, {
                "name": "de-DE_BirgitVoice",
                "language": "de-DE",
                "customizable": false,
                "gender": "female",
                "url": "de-DE_BirgitVoice",
                "description": "Birgit: Standard German of Germany (Standarddeutsch) female voice."
            }, {
                "name": "de-DE_DieterVoice",
                "language": "de-DE",
                "customizable": false,
                "gender": "male",
                "url": "de-DE_DieterVoice",
                "description": "Dieter: Standard German of Germany (Standarddeutsch) male voice."
            }, {
                "name": "it-IT_FrancescaVoice",
                "language": "it-IT",
                "customizable": false,
                "gender": "female",
                "url": "it-IT_FrancescaVoice",
                "description": "Francesca: Italian (italiano) female voice."
            }, {
                "name": "ja-JP_EmiVoice",
                "language": "ja-JP",
                "customizable": false,
                "gender": "female",
                "url": "ja-JP_EmiVoice",
                "description": "Emi: Japanese (???) female voice."
            }, {
                "name": "pt-BR_IsabelaVoice",
                "language": "pt-BR",
                "customizable": false,
                "gender": "female",
                "url": "pt-BR_IsabelaVoice",
                "description": "Isabela: Brazilian Portuguese (portugueas brasileiro) female voice."
            }, {
                "name": "es-ES_EnriqueVoice",
                "language": "es-ES",
                "customizable": false,
                "gender": "male",
                "url": "es-ES_EnriqueVoice",
                "description": "Enrique: Castilian Spanish (espaf1ol castellano) male voice."
            }, {
                "name": "es-ES_LauraVoice",
                "language": "es-ES",
                "customizable": false,
                "gender": "female",
                "url": "es-ES_LauraVoice",
                "description": "Laura: Castilian Spanish (espaf1ol castellano) female voice."
            }, {
                "name": "es-US_SofiaVoice",
                "language": "es-US",
                "customizable": false,
                "gender": "female",
                "url": "es-US_SofiaVoice",
                "description": "Sofia: North American Spanish (espaf1ol norteamericano) female voice."
            }]
        }
    </script>

    <script>
        function loadfile(fileid, loadid) {
            document.getElementById(loadid).value = \'Loading...\';
            setTimeout(function() {
                loadfile2(fileid, loadid)
            }, 1000);
        }

        function loadfile2(fileid, loadid) {
            if (!window.FileReader) {
                document.getElementById(loadid).value = \'Your browser does not support HTML5 "FileReader" function required to open a file.\';
            } else {
                fileis = document.getElementById(fileid).files[0];
                var fileredr = new FileReader();
                fileredr.onload = function(fle) {
                    var filecont = fle.target.result;
                    document.getElementById(loadid).value = filecont;
                }
                fileredr.readAsText(fileis);
            }
        }
    </script>
    <script src=\'https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js\'></script>
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/js/scripttexttovoice.js"></script>
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/js/index.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/js/tts_img.js"></script>
    <!-- Newsletter and scrollToTop-->



    <!-- Newsletter-->
<div style="text-align:center;"><object data="texttospeechnewsletter.html"
        type="text/html" width="315" height="75"></object></div>


    <!-- Portfolio-->
    <div class="pen-title">
        <span>Copyright 2016 <img src="css/ico5.png" alt="logo"><a href=\'https://texttospeechrobot.com/\'>TTS roBOT</a></span>
    </div>
    <!-- Start of ScrollTop Code -->
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/scr0llT0T0p.js"></script>
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/scrollTop.js"></script><script>

        $(document).ready(function() {
            $(window).scroll(function() {
                if ($(this).scrollTop() > 400) {
                    $(\'.scrollup\').fadeIn();
                } else {
                    $(\'.scrollup\').fadeOut();
                }
            });
            $(\'.scrollup\').click(function() {
                $("html, body").animate({
                    scrollTop: 0
                }, 700);
                return false;
            });
        });
    </script>

     <script>
        document.getElementById(\'input-file\')
  .addEventListener(\'change\', getFile)

function getFile(event) {
        const input = event.target
  if (\'files\' in input && input.files.length > 0) {
          placeFileContent(
      document.getElementById(\'speech-msg\'),
      input.files[0])
  }
}

function placeFileContent(target, file) {
        readFileContent(file).then(content => {
        target.value = content
  }).catch(error => console.log(error))
}

function readFileContent(file) {
        const reader = new FileReader()
  return new Promise((resolve, reject) => {
    reader.onload = event => resolve(event.target.result)
    reader.onerror = error => reject(error)
    reader.readAsText(file)
  })
}

    </script>
   <!-- End of ScrollTop Code -->

    <a href="#" class="scrollup"><i class="fa fa-caret-square-o-up fa-2x"></i></a>


    <!-- Start of StatCounter Code for Default Guide -->
    <script src=\'https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.11/vue.min.js\'></script>
    <script src="http://texttospeechrobot.com/tts/es/texto-a-voz/up.js"></script>
    <script>
        var sc_project = 11159252;
        var sc_invisible = 1;
        var sc_security = "822cbf91";
        var scJsHost = (("https:" == document.location.protocol) ?
            "https://secure." : "http://www.");
        document.write("<sc" + "ript type=\'text/javascript\' src=\'" +
            scJsHost +
            "statcounter.com/counter/counter.js\'></" + "script>");
    </script>
    <noscript>
        <div class="statcounter">
            <a title="shopify
analytics ecommerce" href="https://statcounter.com/shopify/" target="_blank"><img class="statcounter" src="//c.statcounter.com/11159252/0/822cbf91/1/" alt="shopify analytics ecommerce">
            </a>
        </div>
    </noscript>



</body>
</html>
'
        wvtav.loadHtml(r.html)
    }
    function speak(text){
        speakMp3(text)
    }
    
    function speakMp3(text){
        //console.log("Convirtiendo a MP3: "+text)
        if(r.indexLang===-1){
            r.indexLang=0
        }
        let nText=(''+text).replace(/\n/g, '')
        console.log("Convirtiendo a MP3: "+text)
        wvtav.runJavaScript('document.getElementById(\'selectlang_lbm\').value="'+r.arrayLanguages[r.indexLang]+'";', function(resultSelectLanguage) {
            wvtav.runJavaScript('document.getElementsByTagName("TEXTAREA").length', function(result) {
                console.log('Resultado 1: '+result)
                wvtav.runJavaScript('var ta=document.getElementsByTagName("TEXTAREA")[3]; ta.value="'+nText+'"; ta.autofocus=true; ta.focus();', function(result2) {
                    console.log('Resultado 2: '+result2)
                    wvtav.runJavaScript('document.getElementsByTagName("BUTTON").length', function(result3) {
                        console.log('Resultado 3: '+result3)
                        wvtav.runJavaScript('document.getElementsByTagName("BUTTON")[2].click()', function(result4) {
                            console.log('Resultado 4: '+result4)
                        });
                    });
                });
            });
        });
    }
    function play(){
        wvtav.runJavaScript('document.getElementsByTagName("BUTTON")[2].click()', function(result4) {
            console.log('Resultado 4: '+result4)
        });
    }
    function stop(){
        wvtav.runJavaScript('document.getElementById(\'audioElement1\').stop()', function(result) {
            if(result){
                lm.remove(0)
            }
        });
    }
}
