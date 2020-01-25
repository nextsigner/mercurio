#!/bin/bash
DATOS=$(curl -sL https://elcomercio.pe/redes-sociales/facebook/horoscopo-2019-test-facebook-signo-zodiaco-compatible-amor-signos-zodiaco-horoscopo-chino-2019-viral-fb-redes-sociales-examen-quiz-peru-mexico-espana-argentina-nnda-nnlt-noticia-545243 | /home/nextsigner/go-ws/bin/pup body div ul li) && echo $DATOS | cut -d'|' -f2  | cut -d'<' -f1 > lilith.txt
