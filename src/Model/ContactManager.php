<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class ContactManager extends AbstractManager
{

    public const TABLE = 'contact';


    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */
    public function addContactInfo(array $contactInfos)
    {
        $query = "INSERT INTO contact (`firstname`, `lastname`, `email`, `subject`, `message`) 
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
