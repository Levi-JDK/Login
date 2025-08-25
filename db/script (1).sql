DROP TABLE IF EXISTS tab_kardex;
DROP TABLE IF EXISTS tab_envios;
DROP TABLE IF EXISTS tab_det_fact;
DROP TABLE IF EXISTS tab_enc_fact;
DROP TABLE IF EXISTS tab_transito;
DROP TABLE IF EXISTS tab_formas_pago;
DROP TABLE IF EXISTS tab_transportadoras;
DROP TABLE IF EXISTS tab_producto_productor;
DROP TABLE IF EXISTS tab_productos;
DROP TABLE IF EXISTS tab_categorias;
DROP TABLE IF EXISTS tab_tipo_artesania;
DROP TABLE IF EXISTS tab_materia_prima;
DROP TABLE IF EXISTS tab_oficios;
DROP TABLE IF EXISTS tab_clientes;
DROP TABLE IF EXISTS tab_productores;
DROP TABLE IF EXISTS tab_regiones;
DROP TABLE IF EXISTS tab_grupos;
DROP TABLE IF EXISTS tab_ciudades;
DROP TABLE IF EXISTS tab_paises;
DROP TABLE IF EXISTS tab_color;
DROP TABLE IF EXISTS tab_bancos;
DROP TABLE IF EXISTS tab_menu_user;
DROP TABLE IF EXISTS tab_menu;
DROP TABLE IF EXISTS tab_users;
DROP TABLE IF EXISTS tab_pmtros;

-- Tabla de parámetros
CREATE TABLE IF NOT EXISTS tab_pmtros
(
    id_parametro     SMALLINT        NOT NULL DEFAULT 1, 
    nom_plataforma   VARCHAR         NOT NULL, -- Nombre comercial o institucional de la plataforma
    dir_contacto     VARCHAR         NOT NULL, -- Direccion fisica de contacto
    tel_contacto     VARCHAR(20)     NOT NULL, -- Telefono oficial
    correo_contacto  VARCHAR         NOT NULL, -- Correo institucional
    val_poriva       DECIMAL(4,2)    NOT NULL DEFAULT 19.00, -- % IVA por defecto
    val_inifact      DECIMAL(12,0)   NOT NULL, -- Rango inicial numeracion facturas
    val_finfact      DECIMAL(12,0)   NOT NULL CHECK(val_finfact >= val_inifact), -- Rango final numeracion facturas
    val_actfact      DECIMAL(12,0)   NOT NULL CHECK (val_actfact >= val_inifact AND val_actfact <= val_finfact), -- Numero actual
    id_ciudad        DECIMAL(4,0)    NOT NULL, -- Ciudad de contacto
    val_observa      TEXT                    , -- Observacion que se imprime en factura
    created_by       VARCHAR         NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                 , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_parametro)
);

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS tab_users (
    id_user             INTEGER                          NOT NULL, -- Llave primaria, identificador de usuario
    mail_user           VARCHAR                          NOT NULL, -- Telefono registrado con el usuario
    pass_user           VARCHAR                          NOT NULL, -- Clave asociada al usuario
    nom_user            VARCHAR                          NOT NULL, -- Nombre o razon social
    ape_user            VARCHAR                          NOT NULL, -- Apellido (si es natural)
    ult_fec_ingreso     TIMESTAMP WITHOUT TIME ZONE      NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Ultima fecha de ingreso del usuario
    created_by          VARCHAR                          NOT NULL, -- Usuario que creó
    created_at          TIMESTAMP WITHOUT TIME ZONE      NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by          VARCHAR                                  , -- Usuario que modificó
    updated_at          TIMESTAMP WITHOUT TIME ZONE              , -- Fecha de modificación
    is_deleted          BOOLEAN                          NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY (id_user)
);

-- Tabla de menu para usuarios
CREATE TABLE IF NOT EXISTS tab_menu
(
    id_menu            INTEGER        NOT NULL,-- Llave primaria, identificador del menu
    nom_menu           VARCHAR        NOT NULL,-- Nombre del menu
    created_by         VARCHAR        NOT NULL, -- Usuario que creó
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by         VARCHAR                , -- Usuario que modificó
    updated_at         TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted         BOOLEAN        NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_menu)
);

-- Tabla puente menu-usuarios
CREATE TABLE IF NOT EXISTS tab_menu_user
(
    id_user         INTEGER           NOT NULL,-- Identificador del usuario
    id_menu         INTEGER           NOT NULL,-- -Identificador del menu
    created_by      VARCHAR           NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                   , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN           NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_user,id_menu),
    FOREIGN KEY(id_user)              REFERENCES tab_users(id_user),
    FOREIGN KEY(id_menu)              REFERENCES tab_menu(id_menu)
);

-- Tabla de bancos
CREATE TABLE IF NOT EXISTS tab_bancos
(
    id_banco        VARCHAR         NOT NULL,-- Id del banco
    nom_banco       VARCHAR         NOT NULL,-- nombre del banco
    dir_banco       VARCHAR         NOT NULL,-- Direccion del banco
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_banco)
);

-- Tabla de colores
CREATE TABLE IF NOT EXISTS tab_color
(
    id_color            VARCHAR           NOT NULL,-- Valor Hexadecimal RGB
    nom_color           VARCHAR             NOT NULL,-- Nombre del color
    created_by          VARCHAR             NOT NULL, -- Usuario que creó
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by          VARCHAR                     , -- Usuario que modificó
    updated_at          TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted          BOOLEAN             NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_color)
);

-- Tabla de paises
CREATE TABLE IF NOT EXISTS tab_paises
(
    id_pais             DECIMAL         NOT NULL,           -- Id del pais
    cod_iso             DECIMAL(3,0)    NOT NULL,           -- Codigo del país segun el ISO  
    nom_pais            VARCHAR         NOT NULL,           -- Nombre del pais
    created_by          VARCHAR         NOT NULL, -- Usuario que creó
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by          VARCHAR                 , -- Usuario que modificó
    updated_at          TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted          BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_pais)
);

-- Tabla de ciudades
CREATE TABLE IF NOT EXISTS tab_ciudades
(
    id_ciudad       DECIMAL         NOT NULL,    -- Llave primaria tabla Ciudades
    nom_ciudad      VARCHAR         NOT NULL,    -- Nombre de la ciudad
    zip_ciudad      VARCHAR         NOT NULL,    -- Codigo postal de la ciudad
    id_pais         DECIMAL         NOT NULL,
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_ciudad,id_pais),
    FOREIGN KEY(id_pais)        REFERENCES tab_paises(id_pais)
);

-- Tabla para grupo poblacional al cual pertenece el productor
CREATE TABLE IF NOT EXISTS tab_grupos
(
    id_grupo        DECIMAL         NOT NULL, -- Id  del grupo poblacional
    nom_grupo       VARCHAR         NOT NULL, -- Nombre del grupo poblacional
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_grupo)
);

-- Tabla de regiones 
CREATE TABLE IF NOT EXISTS tab_regiones
(
    id_region       DECIMAL(1,0)    NOT NULL, -- Id de la region Colombiana perteneciente
    nom_region      VARCHAR         NOT NULL,  -- Nombre de la region(Caribe,Andina...)
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_region)
);

-- Tabla de productores (Personas naturales con actividad comercial)
CREATE TABLE IF NOT EXISTS tab_productores
(
    tipo_doc_productor      DECIMAL         NOT NULL, -- Tipo dee documento del productor
    id_productor            DECIMAL         NOT NULL, -- Numero de documento
    nom_prod                VARCHAR         NOT NULL, -- Nombre del  productor
    ape_prod                VARCHAR         NOT NULL, -- Apellido del productor
    id_user                 INTEGER         NOT NULL, -- Llave primaria, identificador de usuario
    dir_prod                VARCHAR         NOT NULL, -- Direccion del productor
    nom_emprend             VARCHAR         NOT NULL, -- Nombre del emprendimiento
    rut_prod                VARCHAR         NOT NULL, -- RUT, link
    cam_prod                VARCHAR         NOT NULL, -- Documentacion de Camara de Comercio
    img_prod                VARCHAR                 , -- Logo  o  imagen representativa(Opcional)
    id_pais                 DECIMAL         NOT NULL        DEFAULT 1, -- Pais (Colombia)
    id_ciudad               DECIMAL         NOT NULL, -- Ciudad en la que reside
    id_grupo                DECIMAL         NOT NULL, -- Grupo o etnia a la que pertenece
    id_region               DECIMAL(1,0)    NOT NULL, -- Region del pais
    id_banco                VARCHAR         NOT NULL, -- Banco del productor
    id_cuenta_prod          DECIMAL         NOT NULL, -- Numero  de cuenta
    created_by              VARCHAR         NOT NULL, -- Usuario que creó
    created_at              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by              VARCHAR                 , -- Usuario que modificó
    updated_at              TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted              BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_productor),
    FOREIGN KEY(id_user)                      REFERENCES tab_users(id_user),
    FOREIGN KEY(id_ciudad,id_pais)            REFERENCES tab_ciudades(id_ciudad,id_pais),
    FOREIGN KEY(id_grupo)                     REFERENCES tab_grupos(id_grupo),
    FOREIGN KEY(id_region)                    REFERENCES tab_regiones(id_region),
    FOREIGN KEY(id_banco)                     REFERENCES tab_bancos(id_banco)
);
-- Tabla de idiomas
CREATE TABLE IF NOT EXISTS tab_idiomas
(
    id_idioma       VARCHAR         NOT NULL, -- Código del idioma (ej: 'es', 'en', 'fr' según ISO 639-1)
    nom_idioma      VARCHAR         NOT NULL, -- Nombre del idioma (ej: 'Español', 'Inglés')
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_idioma)
);

-- Tabla de monedas
CREATE TABLE IF NOT EXISTS tab_monedas
(
    id_moneda       VARCHAR         NOT NULL, -- Código de la moneda (ej: 'COP', 'USD' según ISO 4217)
    nom_moneda      VARCHAR         NOT NULL, -- Nombre de la moneda (ej: 'Peso Colombiano', 'Dólar Estadounidense')
    simbolo         VARCHAR         NOT NULL, -- Símbolo de la moneda (ej: '$', 'US$')
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_moneda)
);
-- Tabla de clientes cliente
CREATE TABLE IF NOT EXISTS tab_clientes
(
    id_user            INTEGER         NOT NULL, -- Llave primaria, identificador de usuario 
    tipodoc_client     VARCHAR         NOT NULL, -- Tipo de documento (si aplica)
    id_client          VARCHAR         NOT NULL, -- Numero de documento
    id_pais            DECIMAL         NOT NULL, -- Pais del cliente
    id_ciudad          DECIMAL         NOT NULL, -- Ciudad (si aplica)
    id_idioma          VARCHAR         NOT NULL, -- Idioma para interfaz o comunicacion
    id_moneda          VARCHAR         NOT NULL, -- Ej: USD, EUR, COP
    status_client      BOOLEAN         NOT NULL DEFAULT TRUE, -- Activo/inactivo
    created_by         VARCHAR         NOT NULL, -- Usuario que creó
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by         VARCHAR                 , -- Usuario que modificó
    updated_at         TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted         BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_client),
    FOREIGN KEY(id_user)   			REFERENCES tab_users(id_user),
    FOREIGN KEY(id_pais)   			REFERENCES tab_paises(id_pais),
    FOREIGN KEY(id_ciudad,id_pais)  REFERENCES tab_ciudades(id_ciudad,id_pais),
	FOREIGN KEY(id_idioma)			REFERENCES tab_idiomas(id_idioma),
	FOREIGN KEY(id_moneda)			REFERENCES tab_monedas(id_moneda)
);
-- Tabla de oficios
CREATE TABLE IF NOT EXISTS tab_oficios
(
    id_oficio        DECIMAL         NOT NULL, -- ID del oficio artesanal
    nom_oficio       VARCHAR         NOT NULL, -- Nombre del oficio (ej: cesteria, orfebreria)
    created_by       VARCHAR         NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                 , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_oficio)
);

-- Tabla de materia prima
CREATE TABLE IF NOT EXISTS tab_materia_prima
(
    id_materia       DECIMAL         NOT NULL, -- ID de la materia prima
    nom_materia      VARCHAR         NOT NULL, -- Nombre del material (ej: fique, barro)
    created_by       VARCHAR         NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                 , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_materia)
);

-- Tabla de tipo de artesania
CREATE TABLE IF NOT EXISTS tab_tipo_artesania
(
    id_tipo_artesania    DECIMAL         NOT NULL, -- ID del tipo de artesania
    nom_tipo_artesania   VARCHAR         NOT NULL, -- Nombre del tipo (ej: contemporanea, tradicional)
    created_by           VARCHAR         NOT NULL, -- Usuario que creó
    created_at           TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by           VARCHAR                 , -- Usuario que modificó
    updated_at           TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted           BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_tipo_artesania)
);

-- Tabla de categorias
CREATE TABLE IF NOT EXISTS tab_categorias
(
	id_categoria		DECIMAL			NOT NULL,
	nom_categoria		VARCHAR			NOT NULL,
    created_by          VARCHAR         NOT NULL, -- Usuario que creó
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by          VARCHAR                 , -- Usuario que modificó
    updated_at          TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted          BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
	PRIMARY KEY(id_categoria)
);

-- Tabla de productos VARCHAR(15)
CREATE TABLE IF NOT EXISTS tab_productos
(
    id_producto        DECIMAL         NOT NULL, -- ID del producto
    nom_producto       VARCHAR         NOT NULL, -- Nombre del producto
    stock              DECIMAL         NOT NULL, -- Cantidad disponible
    id_categoria       DECIMAL         NOT NULL, -- Categoria del producto
    id_color           VARCHAR         NOT NULL, -- Color principal
    id_oficio          DECIMAL         NOT NULL, -- Oficio artesanal al que pertenece
    id_tipo_artesania  DECIMAL         NOT NULL, -- Tipo de artesania (utilitaria, decorativa...)
    id_materia         DECIMAL         NOT NULL, -- Tipo de materia prima utilizada
    created_by         VARCHAR         NOT NULL, -- Usuario que creó
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by         VARCHAR                 , -- Usuario que modificó
    updated_at         TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted         BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_producto),
    FOREIGN KEY(id_categoria)      REFERENCES tab_categorias(id_categoria),
    FOREIGN KEY(id_color)          REFERENCES tab_color(id_color),
    FOREIGN KEY(id_oficio)         REFERENCES tab_oficios(id_oficio),
    FOREIGN KEY(id_tipo_artesania) REFERENCES tab_tipo_artesania(id_tipo_artesania),
    FOREIGN KEY(id_materia)        REFERENCES tab_materia_prima(id_materia)
);

-- Tabla de producto_productor
CREATE TABLE IF NOT EXISTS tab_producto_productor
(
    id_producto        DECIMAL         NOT NULL, -- ID del producto
    id_productor       DECIMAL         NOT NULL, -- ID del productor
    precio_prod        DECIMAL(10,2)   NOT NULL, -- Precio de venta
    stock_prod         DECIMAL         NOT NULL, -- Stock disponible
    desc_prod_personal TEXT            NOT NULL, -- Descripcion personalizada
    img_personal       VARCHAR         NOT NULL, -- Imagen alternativa si aplica
    activo             BOOLEAN         NOT NULL DEFAULT TRUE,
    created_by         VARCHAR         NOT NULL, -- Usuario que creó
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by         VARCHAR                 , -- Usuario que modificó
    updated_at         TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted         BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_producto, id_productor),
    FOREIGN KEY(id_producto)  REFERENCES tab_productos(id_producto),
    FOREIGN KEY(id_productor) REFERENCES tab_productores(id_productor)
);

-- Tabla de transportadoras
CREATE TABLE IF NOT EXISTS tab_transportadoras
(
    id_transportador   VARCHAR         NOT NULL, -- ID o codigo de la transportadora (ej: DHL, INTER01)
    nom_transportador  VARCHAR         NOT NULL, -- Nombre completo de la transportadora
    tipo_transporte    VARCHAR         NOT NULL, -- Tipo: nacional, internacional, mixto
    tel_contacto       VARCHAR         NOT NULL, -- Telefono de contacto
    correo_contacto    VARCHAR         NOT NULL, -- Correo electronico
    sitio_web          VARCHAR         NOT NULL, -- Pagina oficial (opcional)
    activo             BOOLEAN         NOT NULL DEFAULT TRUE, -- Estado activo/inactivo
    created_by         VARCHAR         NOT NULL, -- Usuario que creó
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by         VARCHAR                 , -- Usuario que modificó
    updated_at         TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted         BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_transportador)
);

-- Tabla de formas de pago
CREATE TABLE IF NOT EXISTS tab_formas_pago
(
    id_pago       VARCHAR      NOT NULL, -- Ej: 'TRF', 'TDC', 'PAYPAL'
    nom_pago      VARCHAR      NOT NULL, -- Ej: 'Transferencia', 'Tarjeta crédito'
    created_by    VARCHAR      NOT NULL, -- Usuario que creó
    created_at    TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by    VARCHAR              , -- Usuario que modificó
    updated_at    TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted    BOOLEAN      NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_pago)
);

-- Tabla de transito
CREATE TABLE tab_transito
(
    id_entrada      DECIMAL(12)     NOT NULL,
    id_producto     DECIMAL(12)     NOT NULL,
    fec_entrada     TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    val_entrada     DECIMAL(4)      NOT NULL,
    created_by      VARCHAR         NOT NULL, -- Usuario que creó
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by      VARCHAR                 , -- Usuario que modificó
    updated_at      TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_entrada),
    FOREIGN KEY(id_producto) REFERENCES tab_productos(id_producto)
);

-- Tabla de enc_fact
CREATE TABLE IF NOT EXISTS tab_enc_fact
(
    id_factura       DECIMAL(7,0)     NOT NULL CHECK(id_factura >= 1), -- ID unico de la factura
    fec_factura      DATE             NOT NULL, -- Fecha de emision
    val_hora_fact    TIME WITHOUT TIME ZONE NOT NULL, -- Hora exacta de emision
    id_client       VARCHAR          NOT NULL, -- ID del cliente que compra
	id_pais			 DECIMAL	      NOT NULL,
    id_ciudad        DECIMAL(4)       NOT NULL, -- Ciudad destino
    val_tot_fact     DECIMAL(12,2)    NOT NULL, -- Valor total de la factura
    ind_estado       BOOLEAN          NOT NULL, -- TRUE = activa / FALSE = anulada
    id_pago          VARCHAR          NOT NULl, 
    created_by       VARCHAR          NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                  , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN          NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_factura),
    FOREIGN KEY(id_pago)    REFERENCES tab_formas_pago(id_pago),
    FOREIGN KEY(id_client) REFERENCES tab_clientes(id_client),
	FOREIGN KEY(id_pais)  REFERENCES tab_paises(id_pais),
    FOREIGN KEY(id_ciudad,id_pais)  REFERENCES tab_ciudades(id_ciudad,id_pais)
);

-- Tabla de det_fact
CREATE TABLE IF NOT EXISTS tab_det_fact
(
    id_factura     DECIMAL(7,0)     NOT NULL,
    id_producto    DECIMAL(12)      NOT NULL,
    id_productor    DECIMAL(12)      NOT NULL, 
    val_cantidad   DECIMAL(4)       NOT NULL CHECK(val_cantidad >=1),
    val_descuento  DECIMAL(8,2)     NOT NULL,
    val_iva        DECIMAL(8,2)     NOT NULL,
    val_bruto      DECIMAL(12,2)    NOT NULL,
    val_neto       DECIMAL(12,2)    NOT NULL,
    created_by     VARCHAR          NOT NULL, -- Usuario que creó
    created_at     TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by     VARCHAR                  , -- Usuario que modificó
    updated_at     TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted     BOOLEAN          NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_factura, id_producto),
    FOREIGN KEY(id_factura)   REFERENCES tab_enc_fact(id_factura),
    FOREIGN KEY(id_producto)  REFERENCES tab_productos(id_producto)
);

-- Tabla de envios
CREATE TABLE IF NOT EXISTS tab_envios
(
    id_envio         DECIMAL(12)     NOT NULL, -- ID unico del envio
    id_factura       DECIMAL(7,0)    NOT NULL, -- Relacion con la venta
    fecha_envio      DATE            NOT NULL,
    id_transportador VARCHAR         NOT NULL, -- Empresa de envio (ej: DHL, Interrapidisimo)
    num_guia         VARCHAR         NOT NULL, -- Numero de guia
    estado_envio     VARCHAR         NOT NULL, -- Estado: pendiente, en transito, entregado, devuelto
    direccion_dest   VARCHAR         NOT NULL, -- Direccion completa
    created_by       VARCHAR         NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                 , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_envio),
    FOREIGN KEY(id_factura)         REFERENCES tab_enc_fact(id_factura),
    FOREIGN KEY(id_transportador)   REFERENCES tab_transportadoras(id_transportador)
);

-- Tabla de kardex
CREATE TABLE IF NOT EXISTS tab_kardex
(
    id_kardex        DECIMAL(12)     NOT NULL, -- ID unico del movimiento
    id_producto      DECIMAL(12)     NOT NULL, -- Producto afectado
    id_productor     DECIMAL(12)     NOT NULL, -- ID del productor
    tipo_movim       BOOLEAN         NOT NULL, -- TRUE=Entrada / FALSE=Salida
    ind_tipomov      DECIMAL(1)      NOT NULL CHECK(ind_tipomov BETWEEN 1 AND 9), -- Motivo del movimiento
    cantidad         DECIMAL(4)      NOT NULL CHECK(cantidad >= 1 AND cantidad <= 9999),
    fecha_movim      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by       VARCHAR         NOT NULL, -- Usuario que creó
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación
    updated_by       VARCHAR                 , -- Usuario que modificó
    updated_at       TIMESTAMP WITHOUT TIME ZONE , -- Fecha de modificación
    is_deleted       BOOLEAN         NOT NULL DEFAULT FALSE, -- Para soft delete
    PRIMARY KEY(id_kardex),
    FOREIGN KEY(id_producto)        REFERENCES tab_productos(id_producto),
    FOREIGN KEY(id_productor)       REFERENCES tab_productores(id_productor)
);

-- Productos y sus relaciones
CREATE INDEX idx_producto_categoria ON tab_productos(id_categoria);
CREATE INDEX idx_producto_color ON tab_productos(id_color);
CREATE INDEX idx_producto_oficio ON tab_productos(id_oficio);
CREATE INDEX idx_producto_tipo_artesania ON tab_productos(id_tipo_artesania);
CREATE INDEX idx_producto_materia ON tab_productos(id_materia);

-- Facturas
CREATE INDEX idx_enc_fact_cliente ON tab_enc_fact(id_client);
CREATE INDEX idx_enc_fact_pago ON tab_enc_fact(id_pago);
CREATE INDEX idx_enc_fact_ciudad ON tab_enc_fact(id_ciudad, id_pais);

-- Detalle de factura
CREATE INDEX idx_det_fact_producto ON tab_det_fact(id_producto);
CREATE INDEX idx_det_fact_productor ON tab_det_fact(id_productor);

-- Kardex
CREATE INDEX idx_kardex_producto ON tab_kardex(id_producto);
CREATE INDEX idx_kardex_productor ON tab_kardex(id_productor);
CREATE INDEX idx_kardex_fecha ON tab_kardex(fecha_movim);

-- Clientes
CREATE INDEX idx_cliente_user ON tab_clientes(id_user);
CREATE INDEX idx_cliente_ciudad ON tab_clientes(id_ciudad, id_pais);

-- Productores
CREATE INDEX idx_productor_user ON tab_productores(id_user);

-- Transportadoras y envíos
CREATE INDEX idx_envios_factura ON tab_envios(id_factura);
CREATE INDEX idx_envios_transportador ON tab_envios(id_transportador);

-- Tránsito de inventario
CREATE INDEX idx_transito_producto ON tab_transito(id_producto);

-- Productos por productor
CREATE INDEX idx_producto_productor_activo ON tab_producto_productor(id_productor, activo);

-- Usuarios y menú
CREATE INDEX idx_menu_user_user ON tab_menu_user(id_user);
CREATE INDEX idx_menu_user_menu ON tab_menu_user(id_menu);
-- Idioma y moneda
CREATE INDEX idx_idiomas_nom ON tab_idiomas(nom_idioma);
CREATE INDEX idx_monedas_nom ON tab_monedas(nom_moneda);

-- INSERTS
-- Insert into tab_pmtros
INSERT INTO tab_pmtros (id_parametro, nom_plataforma, dir_contacto, tel_contacto, correo_contacto, val_poriva, val_inifact, val_finfact, val_actfact, id_ciudad, val_observa, created_by, created_at) VALUES
(1, 'Artesanías Viva', 'Calle 100 # 15-20, Bogotá', '+57 601 555 1234', 'contacto@artesaniasviva.com', 19.00, 1000, 999999, 1000, 2, 'Factura emitida por Artesanías Viva, gracias por su compra.', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_paises
INSERT INTO tab_paises (id_pais, cod_iso, nom_pais, created_by, created_at) VALUES
(1, 170, 'Colombia', 'admin', '2025-08-24 05:40:00'),
(2, 840, 'Estados Unidos', 'admin', '2025-08-24 05:40:00'),
(3, 826, 'Reino Unido', 'admin', '2025-08-24 05:40:00'),
(4, 250, 'Francia', 'admin', '2025-08-24 05:40:00'),
(5, 76, 'Brasil', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_ciudades
INSERT INTO tab_ciudades (id_ciudad, nom_ciudad, zip_ciudad, id_pais, created_by, created_at) VALUES
(1, 'Bucaramanga', '680001', 1, 'admin', '2025-08-24 05:40:00'),
(2, 'Bogotá', '110111', 1, 'admin', '2025-08-24 05:40:00'),
(3, 'Leticia', '910001', 1, 'admin', '2025-08-24 05:40:00'),
(4, 'Miami', '33101', 2, 'admin', '2025-08-24 05:40:00'),
(5, 'Londres', 'SW1A 1AA', 3, 'admin', '2025-08-24 05:40:00'),
(6, 'Medellín', '050001', 1, 'admin', '2025-08-24 05:40:00'),
(7, 'Cartagena', '130001', 1, 'admin', '2025-08-24 05:40:00'),
(8, 'São Paulo', '01000-000', 5, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_grupos
INSERT INTO tab_grupos (id_grupo, nom_grupo, created_by, created_at) VALUES
(1, 'Wayúu', 'admin', '2025-08-24 05:40:00'),
(2, 'Emberá', 'admin', '2025-08-24 05:40:00'),
(3, 'Arhuaco', 'admin', '2025-08-24 05:40:00'),
(4, 'Kankuama', 'admin', '2025-08-24 05:40:00'),
(5, 'Nasa', 'admin', '2025-08-24 05:40:00'),
(6, 'Ticuna', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_regiones
INSERT INTO tab_regiones (id_region, nom_region, created_by, created_at) VALUES
(1, 'Caribe', 'admin', '2025-08-24 05:40:00'),
(2, 'Andina', 'admin', '2025-08-24 05:40:00'),
(3, 'Amazonía', 'admin', '2025-08-24 05:40:00'),
(4, 'Orinoquía', 'admin', '2025-08-24 05:40:00'),
(5, 'Pacífico', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_bancos
INSERT INTO tab_bancos (id_banco, nom_banco, dir_banco, created_by, created_at) VALUES
('BANC01', 'Bancolombia', 'Calle 30 # 6-23, Bogotá', 'admin', '2025-08-24 05:40:00'),
('BANC02', 'Banco de Bogotá', 'Carrera 13 # 27-00, Bogotá', 'admin', '2025-08-24 05:40:00'),
('BANC03', 'Davivienda', 'Avenida El Dorado # 68C-61, Bogotá', 'admin', '2025-08-24 05:40:00'),
('BANC04', 'BBVA', 'Calle 72 # 10-34, Bogotá', 'admin', '2025-08-24 05:40:00'),
('BANC05', 'Itaú', 'Avenida Paulista 1234, São Paulo', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_color
INSERT INTO tab_color (id_color, nom_color, created_by, created_at) VALUES
('#FF0000', 'Rojo', 'admin', '2025-08-24 05:40:00'),
('#008000', 'Verde', 'admin', '2025-08-24 05:40:00'),
('#0000FF', 'Azul', 'admin', '2025-08-24 05:40:00'),
('#FFFF00', 'Amarillo', 'admin', '2025-08-24 05:40:00'),
('#800080', 'Púrpura', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_idiomas
INSERT INTO tab_idiomas (id_idioma, nom_idioma, created_by, created_at) VALUES
('es', 'Español', 'admin', '2025-08-24 05:40:00'),
('en', 'Inglés', 'admin', '2025-08-24 05:40:00'),
('fr', 'Francés', 'admin', '2025-08-24 05:40:00'),
('pt', 'Portugués', 'admin', '2025-08-24 05:40:00'),
('de', 'Alemán', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_monedas
INSERT INTO tab_monedas (id_moneda, nom_moneda, simbolo, created_by, created_at) VALUES
('COP', 'Peso Colombiano', '$', 'admin', '2025-08-24 05:40:00'),
('USD', 'Dólar Estadounidense', 'US$', 'admin', '2025-08-24 05:40:00'),
('GBP', 'Libra Esterlina', '£', 'admin', '2025-08-24 05:40:00'),
('EUR', 'Euro', '€', 'admin', '2025-08-24 05:40:00'),
('BRL', 'Real Brasileño', 'R$', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_users
INSERT INTO tab_users (id_user, mail_user, pass_user, nom_user, ape_user, ult_fec_ingreso, created_by, created_at) VALUES
(1, 'juan.perez@viva.com', 'hashed_pass123', 'Juan', 'Pérez', '2025-08-24 05:40:00', 'admin', '2025-08-24 05:40:00'),
(2, 'maria.lopez@viva.com', 'hashed_pass456', 'María', 'López', '2025-08-24 06:00:00', 'admin', '2025-08-24 05:40:00'),
(3, 'ana.gomez@viva.com', 'hashed_pass789', 'Ana', 'Gómez', '2025-08-24 07:00:00', 'admin', '2025-08-24 05:40:00'),
(4, 'luis.martinez@viva.com', 'hashed_pass101', 'Luis', 'Martínez', '2025-08-24 08:00:00', 'admin', '2025-08-24 05:40:00'),
(5, 'clara.sanchez@viva.com', 'hashed_pass102', 'Clara', 'Sánchez', '2025-08-24 09:00:00', 'admin', '2025-08-24 05:40:00'),
(6, 'pedro.ramirez@viva.com', 'hashed_pass103', 'Pedro', 'Ramírez', '2025-08-24 10:00:00', 'admin', '2025-08-24 05:40:00'),
(7, 'laura.mendez@viva.com', 'hashed_pass104', 'Laura', 'Méndez', '2025-08-24 11:00:00', 'admin', '2025-08-24 05:40:00'),
(8, 'diego.hernandez@viva.com', 'hashed_pass105', 'Diego', 'Hernández', '2025-08-24 12:00:00', 'admin', '2025-08-24 05:40:00'),
(9, 'sofia.torres@viva.com', 'hashed_pass106', 'Sofía', 'Torres', '2025-08-24 13:00:00', 'admin', '2025-08-24 05:40:00'),
(10, 'andres.garcia@viva.com', 'hashed_pass107', 'Andrés', 'García', '2025-08-24 14:00:00', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_menu
INSERT INTO tab_menu (id_menu, nom_menu, created_by, created_at) VALUES
(1, 'Gestión Productos', 'admin', '2025-08-24 05:40:00'),
(2, 'Gestión Facturas', 'admin', '2025-08-24 05:40:00'),
(3, 'Gestión Envíos', 'admin', '2025-08-24 05:40:00'),
(4, 'Gestión Usuarios', 'admin', '2025-08-24 05:40:00'),
(5, 'Reportes', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_menu_user
INSERT INTO tab_menu_user (id_user, id_menu, created_by, created_at) VALUES
(1, 1, 'admin', '2025-08-24 05:40:00'),
(1, 2, 'admin', '2025-08-24 05:40:00'),
(2, 3, 'admin', '2025-08-24 05:40:00'),
(3, 1, 'admin', '2025-08-24 05:40:00'),
(4, 4, 'admin', '2025-08-24 05:40:00'),
(5, 5, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_productores
INSERT INTO tab_productores (tipo_doc_productor, id_productor, nom_prod, ape_prod, id_user, dir_prod, nom_emprend, rut_prod, cam_prod, img_prod, id_pais, id_ciudad, id_grupo, id_region, id_banco, id_cuenta_prod, created_by, created_at) VALUES
(1, 123456789, 'Juan', 'Pérez', 1, 'Calle 5 # 10-20, Riohacha', 'Artesanías Wayúu', 'rut123.pdf', 'cam123.pdf', 'logo_wayuu.png', 1, 1, 1, 1, 'BANC01', 9876543210, 'admin', '2025-08-24 05:40:00'),
(2, 987654321, 'María', 'López', 2, 'Carrera 8 # 15-30, Leticia', 'Tejidos Emberá', 'rut456.pdf', 'cam456.pdf', 'logo_embera.png', 1, 3, 2, 3, 'BANC02', 1234567890, 'admin', '2025-08-24 05:40:00'),
(1, 456789123, 'Ana', 'Gómez', 3, 'Vereda Sierra Nevada, Santa Marta', 'Mochilas Arhuaco', 'rut789.pdf', 'cam789.pdf', 'logo_arhuaco.png', 1, 2, 3, 2, 'BANC03', 4561237890, 'admin', '2025-08-24 05:40:00'),
(1, 111222333, 'Luis', 'Martínez', 4, 'Calle 10 # 5-15, Medellín', 'Tejidos Nasa', 'rut111.pdf', 'cam111.pdf', 'logo_nasa.png', 1, 6, 5, 2, 'BANC04', 1112223334, 'admin', '2025-08-24 05:40:00'),
(2, 222333444, 'Clara', 'Sánchez', 5, 'Carrera 15 # 20-10, Cartagena', 'Joyas Caribe', 'rut222.pdf', 'cam222.pdf', 'logo_caribe.png', 1, 7, 1, 1, 'BANC01', 2223334445, 'admin', '2025-08-24 05:40:00'),
(1, 333444555, 'Pedro', 'Ramírez', 6, 'Vereda El Carmen, Bogotá', 'Cestería Arhuaco', 'rut333.pdf', 'cam333.pdf', 'logo_arhuaco2.png', 1, 2, 3, 2, 'BANC02', 3334445556, 'admin', '2025-08-24 05:40:00'),
(1, 444555666, 'Laura', 'Méndez', 7, 'Calle 3 # 8-25, Leticia', 'Artesanías Emberá', 'rut444.pdf', 'cam444.pdf', 'logo_embera2.png', 1, 3, 2, 3, 'BANC03', 4445556667, 'admin', '2025-08-24 05:40:00'),
(2, 555666777, 'Diego', 'Hernández', 8, 'Carrera 7 # 12-40, Bucaramanga', 'Mochilas Kankuama', 'rut555.pdf', 'cam555.pdf', 'logo_kankuama.png', 1, 1, 4, 2, 'BANC01', 5556667778, 'admin', '2025-08-24 05:40:00'),
(1, 666777888, 'Sofía', 'Torres', 9, 'Calle 20 # 10-30, Medellín', 'Tejidos Wayúu', 'rut666.pdf', 'cam666.pdf', 'logo_wayuu2.png', 1, 6, 1, 1, 'BANC04', 6667778889, 'admin', '2025-08-24 05:40:00'),
(1, 777888999, 'Andrés', 'García', 10, 'Vereda La Paz, Cartagena', 'Cerámica Nasa', 'rut777.pdf', 'cam777.pdf', 'logo_nasa2.png', 1, 7, 5, 1, 'BANC02', 7778889990, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_clientes (adjusted for id_idioma and id_moneda as VARCHAR)
INSERT INTO tab_clientes (id_user, tipodoc_client, id_client, id_pais, id_ciudad, id_idioma, id_moneda, status_client, created_by, created_at) VALUES
(1, 'CC', 'CLI001', 1, 1, 'es', 'COP', TRUE, 'admin', '2025-08-24 05:40:00'),
(2, 'PP', 'CLI002', 2, 4, 'en', 'USD', TRUE, 'admin', '2025-08-24 05:40:00'),
(3, 'NIE', 'CLI003', 3, 5, 'fr', 'GBP', TRUE, 'admin', '2025-08-24 05:40:00'),
(4, 'CC', 'CLI004', 1, 6, 'es', 'COP', TRUE, 'admin', '2025-08-24 05:40:00'),
(5, 'PP', 'CLI005', 2, 4, 'en', 'USD', TRUE, 'admin', '2025-08-24 05:40:00'),
(6, 'CC', 'CLI006', 1, 7, 'es', 'COP', TRUE, 'admin', '2025-08-24 05:40:00'),
(7, 'CPF', 'CLI007', 5, 8, 'pt', 'BRL', TRUE, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_oficios
INSERT INTO tab_oficios (id_oficio, nom_oficio, created_by, created_at) VALUES
(1, 'Cestería', 'admin', '2025-08-24 05:40:00'),
(2, 'Tejido', 'admin', '2025-08-24 05:40:00'),
(3, 'Orfebrería', 'admin', '2025-08-24 05:40:00'),
(4, 'Cerámica', 'admin', '2025-08-24 05:40:00'),
(5, 'Talla en Madera', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_materia_prima
INSERT INTO tab_materia_prima (id_materia, nom_materia, created_by, created_at) VALUES
(1, 'Fique', 'admin', '2025-08-24 05:40:00'),
(2, 'Lana', 'admin', '2025-08-24 05:40:00'),
(3, 'Plata', 'admin', '2025-08-24 05:40:00'),
(4, 'Barro', 'admin', '2025-08-24 05:40:00'),
(5, 'Madera', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_tipo_artesania
INSERT INTO tab_tipo_artesania (id_tipo_artesania, nom_tipo_artesania, created_by, created_at) VALUES
(1, 'Tradicional', 'admin', '2025-08-24 05:40:00'),
(2, 'Contemporánea', 'admin', '2025-08-24 05:40:00'),
(3, 'Utilitaria', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_categorias
INSERT INTO tab_categorias (id_categoria, nom_categoria, created_by, created_at) VALUES
(1, 'Accesorios', 'admin', '2025-08-24 05:40:00'),
(2, 'Decoración', 'admin', '2025-08-24 05:40:00'),
(3, 'Ropa', 'admin', '2025-08-24 05:40:00'),
(4, 'Hogar', 'admin', '2025-08-24 05:40:00'),
(5, 'Joyería', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_productos
INSERT INTO tab_productos (id_producto, nom_producto, stock, id_categoria, id_color, id_oficio, id_tipo_artesania, id_materia, created_by, created_at) VALUES
(1, 'Mochila Wayúu', 50, 1, '#FF0000', 2, 1, 1, 'admin', '2025-08-24 05:40:00'),
(2, 'Cesto Emberá', 30, 2, '#008000', 1, 1, 1, 'admin', '2025-08-24 05:40:00'),
(3, 'Aretes de Plata', 20, 5, '#0000FF', 3, 2, 3, 'admin', '2025-08-24 05:40:00'),
(4, 'Jarrón de Barro', 15, 4, '#800080', 4, 3, 4, 'admin', '2025-08-24 05:40:00'),
(5, 'Chal de Lana', 25, 3, '#FFFF00', 2, 1, 2, 'admin', '2025-08-24 05:40:00'),
(6, 'Escultura de Madera', 10, 2, '#800080', 5, 2, 5, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_producto_productor
INSERT INTO tab_producto_productor (id_producto, id_productor, precio_prod, stock_prod, desc_prod_personal, img_personal, activo, created_by, created_at) VALUES
(1, 123456789, 150000.00, 20, 'Mochila tejida a mano por artesanos Wayúu', 'mochila_wayuu.jpg', TRUE, 'admin', '2025-08-24 05:40:00'),
(2, 987654321, 80000.00, 15, 'Cesto tradicional Emberá con patrones únicos', 'cesto_embera.jpg', TRUE, 'admin', '2025-08-24 05:40:00'),
(3, 456789123, 120000.00, 10, 'Aretes de plata con diseño contemporáneo', 'aretes_plata.jpg', TRUE, 'admin', '2025-08-24 05:40:00'),
(4, 777888999, 95000.00, 12, 'Jarrón de barro con acabados tradicionales', 'jarron_barro.jpg', TRUE, 'admin', '2025-08-24 05:40:00'),
(5, 222333444, 180000.00, 18, 'Chal de lana tejido a mano', 'chal_lana.jpg', TRUE, 'admin', '2025-08-24 05:40:00'),
(6, 555666777, 200000.00, 8, 'Escultura tallada en madera de roble', 'escultura_madera.jpg', TRUE, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_transportadoras
INSERT INTO tab_transportadoras (id_transportador, nom_transportador, tipo_transporte, tel_contacto, correo_contacto, sitio_web, activo, created_by, created_at) VALUES
('TRANS01', 'Interrapidisimo', 'Nacional', '+57 601 555 1234', 'contacto@interrapidisimo.com', 'www.interrapidisimo.com', TRUE, 'admin', '2025-08-24 05:40:00'),
('TRANS02', 'DHL', 'Internacional', '+1 800 123 4567', 'contact@dhl.com', 'www.dhl.com', TRUE, 'admin', '2025-08-24 05:40:00'),
('TRANS03', 'Servientrega', 'Nacional', '+57 601 777 8888', 'info@servientrega.com', 'www.servientrega.com', TRUE, 'admin', '2025-08-24 05:40:00'),
('TRANS04', 'FedEx', 'Internacional', '+1 800 247 4747', 'support@fedex.com', 'www.fedex.com', TRUE, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_formas_pago
INSERT INTO tab_formas_pago (id_pago, nom_pago, created_by, created_at) VALUES
('TRF', 'Transferencia Bancaria', 'admin', '2025-08-24 05:40:00'),
('TDC', 'Tarjeta de Crédito', 'admin', '2025-08-24 05:40:00'),
('PAYPAL', 'PayPal', 'admin', '2025-08-24 05:40:00'),
('PSE', 'PSE', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_transito
INSERT INTO tab_transito (id_entrada, id_producto, fec_entrada, val_entrada, created_by, created_at) VALUES
(1, 1, '2025-08-24 10:00:00', 20, 'admin', '2025-08-24 05:40:00'),
(2, 2, '2025-08-24 11:00:00', 15, 'admin', '2025-08-24 05:40:00'),
(3, 3, '2025-08-24 12:00:00', 10, 'admin', '2025-08-24 05:40:00'),
(4, 4, '2025-08-24 13:00:00', 12, 'admin', '2025-08-24 05:40:00'),
(5, 5, '2025-08-24 14:00:00', 18, 'admin', '2025-08-24 05:40:00'),
(6, 6, '2025-08-24 15:00:00', 8, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_enc_fact
INSERT INTO tab_enc_fact (id_factura, fec_factura, val_hora_fact, id_client, id_pais, id_ciudad, val_tot_fact, ind_estado, id_pago, created_by, created_at) VALUES
(1, '2025-08-24', '14:30:00', 'CLI001', 1, 1, 178500.00, TRUE, 'TRF', 'admin', '2025-08-24 05:40:00'),
(2, '2025-08-24', '15:00:00', 'CLI002', 2, 4, 183500.00, TRUE, 'PAYPAL', 'admin', '2025-08-24 05:40:00'),
(3, '2025-08-24', '16:00:00', 'CLI003', 3, 5, 142800.00, TRUE, 'TDC', 'admin', '2025-08-24 05:40:00'),
(4, '2025-08-24', '17:00:00', 'CLI004', 1, 6, 113050.00, TRUE, 'PSE', 'admin', '2025-08-24 05:40:00'),
(5, '2025-08-24', '18:00:00', 'CLI005', 2, 4, 214200.00, TRUE, 'PAYPAL', 'admin', '2025-08-24 05:40:00'),
(6, '2025-08-24', '19:00:00', 'CLI006', 1, 7, 238000.00, TRUE, 'TRF', 'admin', '2025-08-24 05:40:00'),
(7, '2025-08-24', '20:00:00', 'CLI007', 5, 8, 200000.00, TRUE, 'TDC', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_det_fact
INSERT INTO tab_det_fact (id_factura, id_producto, id_productor, val_cantidad, val_descuento, val_iva, val_bruto, val_neto, created_by, created_at) VALUES
(1, 1, 123456789, 1, 0.00, 28500.00, 150000.00, 178500.00, 'admin', '2025-08-24 05:40:00'),
(2, 2, 987654321, 2, 5000.00, 28500.00, 160000.00, 183500.00, 'admin', '2025-08-24 05:40:00'),
(3, 3, 456789123, 1, 0.00, 22800.00, 120000.00, 142800.00, 'admin', '2025-08-24 05:40:00'),
(4, 4, 777888999, 1, 0.00, 18050.00, 95000.00, 113050.00, 'admin', '2025-08-24 05:40:00'),
(5, 5, 222333444, 1, 0.00, 34200.00, 180000.00, 214200.00, 'admin', '2025-08-24 05:40:00'),
(6, 6, 555666777, 1, 0.00, 38000.00, 200000.00, 238000.00, 'admin', '2025-08-24 05:40:00'),
(7, 6, 555666777, 1, 0.00, 38000.00, 200000.00, 238000.00, 'admin', '2025-08-24 05:40:00');

-- Insert into tab_envios
INSERT INTO tab_envios (id_envio, id_factura, fecha_envio, id_transportador, num_guia, estado_envio, direccion_dest, created_by, created_at) VALUES
(1, 1, '2025-08-25', 'TRANS01', 'GUIA123456', 'En tránsito', 'Calle 20 # 15-30, Bucaramanga', 'admin', '2025-08-24 05:40:00'),
(2, 2, '2025-08-25', 'TRANS02', 'DHL789012', 'Pendiente', '123 Main St, Miami, FL', 'admin', '2025-08-24 05:40:00'),
(3, 3, '2025-08-25', 'TRANS02', 'DHL345678', 'Pendiente', '10 Downing St, London', 'admin', '2025-08-24 05:40:00'),
(4, 4, '2025-08-25', 'TRANS03', 'SERV123456', 'En tránsito', 'Carrera 50 # 20-10, Medellín', 'admin', '2025-08-24 05:40:00'),
(5, 5, '2025-08-25', 'TRANS04', 'FEDEX789012', 'Pendiente', '456 Ocean Dr, Miami, FL', 'admin', '2025-08-24 05:40:00'),
(6, 6, '2025-08-25', 'TRANS01', 'GUIA789123', 'En tránsito', 'Calle 10 # 5-25, Cartagena', 'admin', '2025-08-24 05:40:00'),
(7, 7, '2025-08-25', 'TRANS04', 'FEDEX456789', 'Pendiente', 'Rua Augusta 123, São Paulo', 'admin', '2025-08-24 05:40:00');

-- Insert into tab_kardex
INSERT INTO tab_kardex (id_kardex, id_producto, id_productor, tipo_movim, ind_tipomov, cantidad, fecha_movim, created_by, created_at) VALUES
(1, 1, 123456789, TRUE, 1, 20, '2025-08-24 10:00:00', 'admin', '2025-08-24 05:40:00'),
(2, 2, 987654321, TRUE, 1, 15, '2025-08-24 11:00:00', 'admin', '2025-08-24 05:40:00'),
(3, 3, 456789123, FALSE, 2, 1, '2025-08-24 14:30:00', 'admin', '2025-08-24 05:40:00'),
(4, 4, 777888999, TRUE, 1, 12, '2025-08-24 13:00:00', 'admin', '2025-08-24 05:40:00'),
(5, 5, 222333444, FALSE, 2, 1, '2025-08-24 18:00:00', 'admin', '2025-08-24 05:40:00'),
(6, 6, 555666777, TRUE, 1, 8, '2025-08-24 15:00:00', 'admin', '2025-08-24 05:40:00'),
(7, 6, 555666777, FALSE, 2, 1, '2025-08-24 19:00:00', 'admin', '2025-08-24 05:40:00');