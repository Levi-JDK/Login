CREATE OR REPLACE FUNCTION fun_reg_user(
    p_mail_user VARCHAR,
    p_pass_user VARCHAR,
    p_nom_cliente VARCHAR,
    p_ape_cliente VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
    w_mail_user tab_users.mail_user%TYPE;
BEGIN
    -- Verificar si el usuario ya existe
    SELECT mail_user INTO w_mail_user
    FROM tab_users
    WHERE w_mail_user = p_mail_user;

    IF FOUND THEN
        RETURN FALSE;
    END IF;

    -- Insertar el nuevo usuario
    INSERT INTO tab_users (id_user, pass_user, mail_user, nom_cliente, ape_cliente)
    VALUES ((SELECT MAX(id_user) FROM tab_users)+1, p_pass_user, p_mail_user, p_nom_cliente, p_ape_cliente);
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

--SELECT fun_reg_user('password1', 'mail1@gmail.com', 'Nombre1', 'Apellido1');
--SELECT * FROM tab_users;
