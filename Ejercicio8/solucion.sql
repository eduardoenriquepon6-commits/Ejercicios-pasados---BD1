--1. Mostrar todos los usuarios que no han creado ningún tablero, para dichos usuarios mostrar el
--nombre completo y correo, utilizar producto cartesiano con el operador (+).
SELECT * 
FROM TBL_USUARIOS;

SELECT * 
FROM TBL_TABLERO;

SELECT *
FROM TBL_USUARIOS_X_TABLERO;

SELECT  A.NOMBRE || ' ' || A.APELLIDO AS NOMBRE_COMPLETO,
        A.CORREO
FROM TBL_USUARIOS A,
TBL_TABLERO B
WHERE A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA(+) AND B.CODIGO_TABLERO IS NULL; 


--2. Mostrar la cantidad de usuarios que se han registrado por cada red social, mostrar inclusive la
--cantidad de usuarios que no están registrados con redes sociales.

SELECT * 
FROM TBL_REDES_SOCIALES;

SELECT *
FROM TBL_USUARIOS;

SELECT  B.CODIGO_RED_SOCIAL,
        B.NOMBRE_RED_SOCIAL,
        COUNT(A.CODIGO_USUARIO) AS USUARIOS_REGISTRADOS
FROM TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL
GROUP BY B.CODIGO_RED_SOCIAL, B.NOMBRE_RED_SOCIAL;


--3. Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para
--este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de
--tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar
--count(distinct campo))

SELECT CODIGO_USUARIO, COUNT(*) AS CANTIDAD_COMENTARIOS
FROM TBL_COMENTARIOS
GROUP BY CODIGO_USUARIO;

WITH COMENTARIOS AS (
    SELECT  A.NOMBRE || ' ' || A.APELLIDO AS NOMBRE_COMPLETO,
            A.CORREO,
            COUNT(B.CODIGO_COMENTARIO) AS CANTIDAD_COMENTARIOS,
            COUNT(DISTINCT B.CODIGO_TARJETA) AS TARJETAS
    FROM TBL_USUARIOS A
    INNER JOIN TBL_COMENTARIOS B
    ON A.CODIGO_USUARIO = B.CODIGO_USUARIO
    GROUP BY A.NOMBRE || ' ' || A.APELLIDO, A.CORREO
)
SELECT *
FROM COMENTARIOS
WHERE CANTIDAD_COMENTARIOS = (SELECT MAX(CANTIDAD_COMENTARIOS) FROM COMENTARIOS);

COMMIT;

--4. Mostrar TODOS los usuarios con plan FREE, de dichos usuarios mostrar la siguiente información:
--• Nombre completo
--• Correo
--• Red social (En caso de estar registrado con una)
--• Cantidad de organizaciones que ha creado, mostrar 0 si no ha creado ninguna.



--5. Mostrar los usuarios que han creado más de 5 tarjetas, para estos usuarios mostrar:
--Nombre completo, correo, cantidad de tarjetas creadas
--6. Un usuario puede estar suscrito a tableros, listas y tarjetas, de tal forma que si hay algún cambio
--se le notifica en su teléfono o por teléfono, sabiendo esto, se necesita mostrar los nombres de
--todos los usuarios con la cantidad de suscripciones de cada tipo, en la consulta se debe mostrar:
--• Nombre completo del usuario
--• Cantidad de tableros a los cuales está suscrito
--• Cantidad de listas a las cuales está suscrito
--• Cantidad de tarjetas a las cuales está suscrito
--7. Consultar todas las organizaciones con los siguientes datos:
--Nombre de la organización
--Cantidad de usuarios registrados en cada organización
--Cantidad de Tableros por cada organización
--Cantidad de Listas asociadas a cada organización
--Cantidad de Tarjetas asociadas a cada organización

--8. Crear una vista materializada con la información de facturación, los campos a incluir son los
--siguientes:
--• Código factura
--• Nombre del plan a facturar
--• Nombre completo del usuario
--• Fecha de pago (Utilizar fecha inicio, mostrarla en formato Día-Mes-Año)
--• Año y Mes de pago (basado en la fecha inicio)
--• Monto de la factura
--• Descuento
--• Total neto