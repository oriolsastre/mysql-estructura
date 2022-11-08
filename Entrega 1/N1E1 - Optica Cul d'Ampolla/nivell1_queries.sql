USE `optica`;
SELECT marca.nom AS Marca, venda.data AS 'Data de venda'
FROM venda JOIN ulleres ON venda.ulleres = ulleres.id
    JOIN marca ON ulleres.marca = marca.id
    JOIN client ON venda.client = client.id
WHERE client.id = 1;

SELECT empleat.nom AS Venedor, marca.nom AS Marca, ulleres.preu AS Preu, YEAR(venda.data) AS Any
FROM venda JOIN ulleres ON venda.ulleres = ulleres.id
    JOIN marca ON ulleres.marca = marca.id
    JOIN empleat ON venda.empleat = empleat.id
WHERE empleat.id=2 AND YEAR(venda.data)=2020;

SELECT COUNT(venda.id) AS Vendes, proveidor.nom AS Proveidor
FROM venda JOIN ulleres ON venda.ulleres=ulleres.id
    JOIN marca ON ulleres.marca=marca.id
    JOIN proveidor ON marca.proveidor=proveidor.id
GROUP BY Proveidor
ORDER BY Vendes DESC;