<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class ContactManager extends AbstractManager
{

    public const TABLE = 'contact';


    /**
     * Select old news in database
     */
    public function addContactInfo(array $contactInfos)
    {
        $query = "
            INSERT INTO " . static::TABLE . " ('firstname', 'lastname', 'email', 'subject', 'message') 
            VALUES (:firstname, :lastname, :email, :subject, :message)";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':firstname', $contactInfos['firstname'], \PDO::PARAM_STR);
        $statement->bindValue(':lastname', $contactInfos['lastname'], \PDO::PARAM_STR);
        $statement->bindValue(':email', $contactInfos['email'], \PDO::PARAM_STR);
        $statement->bindValue(':subject', $contactInfos['subject'], \PDO::PARAM_STR);
        $statement->bindValue(':message', $contactInfos['message'], \PDO::PARAM_STR);

        return $statement->execute();
    }
}
