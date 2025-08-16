CREATE TABLE IF NOT EXISTS tab_users
(
    id_user            INTEGER        NOT NULL, -- Llave primaria, identificador de usuario
    pass_user          VARCHAR        NOT NULL, -- Clave asociada al usuario
    mail_user          VARCHAR        NOT NULL, -- Telefono registrado con el usuario
	nom_cliente        VARCHAR        NOT NULL, -- Nombre o razon social
    ape_cliente        VARCHAR        NOT NULL, -- Apellido (si es natural)
    ult_fec_ingreso    TIMESTAMP WITHOUT TIME ZONE  NOT NULL    DEFAULT CURRENT_TIMESTAMP, -- Ultima fecha de ingreso del usuario
    PRIMARY KEY(id_user)
);
INSERT INTO tab_users (id_user, pass_user, mail_user, nom_cliente, ape_cliente) VALUES
('admin', 'admin123', 'admin@gmail.com', 'Administrador', 'Sistema');