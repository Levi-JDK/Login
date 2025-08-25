CREATE OR REPLACE FUNCTION set_created()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.created_by IS NULL THEN
        NEW.created_by := COALESCE(current_user, 'user');
    END IF;
    NEW.created_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    table_name text;
    tables text[] := ARRAY[
        'tab_pmtros', 'tab_paises', 'tab_ciudades', 'tab_grupos', 'tab_regiones',
        'tab_bancos', 'tab_color', 'tab_idiomas', 'tab_monedas', 'tab_users',
        'tab_menu', 'tab_menu_user', 'tab_productores', 'tab_clientes', 'tab_oficios',
        'tab_materia_prima', 'tab_tipo_artesania', 'tab_categorias', 'tab_productos',
        'tab_producto_productor', 'tab_transportadoras', 'tab_formas_pago', 'tab_transito',
        'tab_enc_fact', 'tab_det_fact', 'tab_envios', 'tab_kardex'
    ];
BEGIN
    FOREACH table_name IN ARRAY tables
    LOOP
        EXECUTE format('
            CREATE OR REPLACE TRIGGER trigger_set_created_%s
            BEFORE INSERT ON %I
            FOR EACH ROW
            EXECUTE FUNCTION set_created();
        ', table_name, table_name);
    END LOOP;
END $$;
