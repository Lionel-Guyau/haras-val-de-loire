<?php

namespace App\Model;

use App\Model\Connection;
use DateTime;

class ContactManager extends AbstractManager
{

    public const TABLE = 'contact';


    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */
    public function addContactInfo(array $contactInfos)
    {
        $query = "INSERT INTO contact (`firstname`, `lastname`, `email`, `number`, `subject`, `message`, `date`) 
                VALUES (:firstname, :lastname, :email, :number, :subject, :message, :date)";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':firstname', $contactInfos['firstname'], \PDO::PARAM_STR);
        $statement->bindValue(':lastname', $contactInfos['lastname'], \PDO::PARAM_STR);
        $statement->bindValue(':email', $contactInfos['email'], \PDO::PARAM_STR);
        $statement->bindValue(':number', "0000000000", \PDO::PARAM_STR);
        $statement->bindValue(':subject', $contactInfos['subject'], \PDO::PARAM_STR);
        $statement->bindValue(':message', $contactInfos['message'], \PDO::PARAM_STR);
        $statement->bindValue(':date', (new DateTime('NOW'))->format('Y-m-d H:i:s'), \PDO::PARAM_STR);

        return $statement->execute();
    }
}
