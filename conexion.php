<?php
class Database {
    // Propiedades privadas para la conexión
    private string $host = 'localhost';
    private string $port = '5432';
    private string $dbname = 'login';
    private string $user = 'postgres';
    private string $password = 'Gerson03#';
    
    private ?PDO $pdo = null; // Conexión PDO (nullable)
    
    // Método privado para establecer la conexión
    private function connect(): void {
        if ($this->pdo === null) {
            try
            {
                $this->pdo = new PDO("pgsql:host={$this->host};port={$this->port};dbname={$this->dbname}", $this->user, $this->password);
                $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                echo "Error al conectar a la base de datos: " . $e->getMessage();
            }
        }
    }
    public function getPdo(): PDO {
    $this->connect(); // Asegura que la conexión esté lista
    return $this->pdo; // Retorna el objeto PDO
}
}     
?>