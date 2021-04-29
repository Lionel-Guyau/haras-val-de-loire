<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class LoginManager extends AbstractManager
{
    public const TABLE = 'admin';

    /**
     * Select Admin User
     */
    public function connectAdminUser(string $email)
    {
        $statement = $this->pdo->prepare("SELECT * FROM " . static::TABLE . " WHERE email = :email");
        $statement->bindValue(':email', $email);
        $statement->execute();

        return $statement->fetch();
    }
}
