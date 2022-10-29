# Òptica Cul d'Ampolla

Algunes consideracions a la base de dades.

## Adreces

"Adreça" considero que no és ben bé que sigui una entitat, però al ser una característica compartida tant pels clients com pels proveïdors, amb els mateixos camps, he pensat que podria tenir una taula pròpia.

- _Pis_ i _Porta_: He triat _TINYINT_ però tinc els meus dubtes, ja que no sé si podria ser porta A, porta B, o bé principal o entresol.

## Vidres

En realitat, amb més informació, potser hi podria haver una taula "Tipus_vidre" i crear una clau forana de la taula "Ulleres" -> "Tipus vidre" pels camps vidre_d i vidre_e. Similar pels colors.

Això, o bé, fer-lo del tipus __Enum__, però no he veig tant clar, ja que es poden crear nous tipus de vidre al futur o nou colors disponibles i caldria modificar les característiques de la taula.

Ja que menciono el color. El camp _color_ de les ulleres l'he posat _Null_ per defecte que seria el color transparent.

## Vendes

La taula vendes és la típica que podria tenir una clau primària composta de diversos camps, però un mateix empleat podria vendre les mateixes ulleres al mateix client, ja sigui el mateix dia o en dies diferents. A més, el camp client he considerat que sí que pot ser _Null_ ja que per protecció de dades o coses d'aquestes un client podria demanar que s'eliminessin les seves dades del sistema. Per empleats les condicions ja serien diferents i una empresa li interessa quins ex-empleats ha tingut.