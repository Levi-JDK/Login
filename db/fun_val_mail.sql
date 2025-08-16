CREATE OR REPLACE FUNCTION fun_val_mail(p_mail VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
    w_mail tab_users.mail_user%TYPE;
BEGIN
    -- Verificar si el correo electrónico ya está registrado
    SELECT mail_user INTO w_mail
    FROM tab_users
    WHERE mail_user = w_mail;

    IF FOUND THEN
        RETURN FALSE; -- El correo ya está en uso
    END IF;

    RETURN TRUE; -- El correo es válido y no está en uso
END;
$$
LANGUAGE plpgsql;
