SELECT SUM(comanda_producte.quantitat) AS 'Begudes Venudes'
FROM comanda_producte JOIN producte ON comanda_producte.producte=producteID
    JOIN comanda ON comanda_producte.comanda=comandaID
WHERE producte.tipus='beguda' AND
    comanda.botiga=1;

SELECT comanda.botiga AS 'ID de la Botiga', SUM(comanda_producte.quantitat) AS 'Begudes Venudes'
FROM comanda_producte JOIN producte ON comanda_producte.producte=producteID
    JOIN comanda ON comanda_producte.comanda=comandaID
WHERE producte.tipus='beguda'
GROUP BY comanda.botiga;

SELECT COUNT(comandaID) AS 'Comandes Repartides'
FROM comanda JOIN empleat ON comanda.repartidor=empleatID
WHERE empleatID=2;

SELECT empleatID AS 'ID del repartidor', nom, cognoms, COUNT(comandaID) AS 'Comandes Repartides'
FROM comanda JOIN empleat ON comanda.repartidor=empleatID
GROUP BY empleatID;