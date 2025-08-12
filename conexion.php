<?php
/*
==============================================================================
Este archivo se encarga de conectar a la base de datos y traer un objeto PDO
============================================================================== */
$contraseña         = "Gerson03#";
$usuario            = "postgres";
$nombreBaseDeDatos  = "db_viva";
$server = "localhost";
$puerto = "5432";
try
{
    $conn = new PDO("pgsql:host=$server;port=$puerto;dbname=$nombreBaseDeDatos", $usuario, $contraseña);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
   echo "Me Conecté\n";
}

catch (Exception $e)
{
    echo "Ocurrió un error con la base de datos: " . $e->getMessage();
}