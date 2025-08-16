CREATE OR REPLACE FUNCTION fun_val_log(p_mail tab_users.mail_user%TYPE) RETURNS VARCHAR AS $$
DECLARE
    w_pass tab_users.mail_user%TYPE;
    w_mail tab_users.mail_user%TYPE;
    
BEGIN
    IF SELECT fun_val_mail(p_mail) IS FALSE THEN
        RETURN 'Correo no existe'; -- Correo no válido
    ELSE
    -- Verificar si el correo electrónico ya está registrado
    SELECT pass_user INTO w_pass
    FROM tab_users
    WHERE mail_user = p_mail;

    IF FOUND THEN
            RETURN w_pass;
    END IF;
	END IF;
END;
$$
LANGUAGE plpgsql;
--select fun_val_log('admin123');
-- SELECT * FROM tab_users;
