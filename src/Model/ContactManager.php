<?php

namespace App\Model;

use App\Model\Connection;
use DateTime;
use PDO;


class ContactManager extends AbstractManager
{

    public const TABLE = 'contact';


    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */
    public function addContactInfo(array $contactInfos)
    {
        $now = (new DateTime("NOW"))->format('Y-m-d H:i:s');

        $query = "INSERT INTO contact (`firstname`, `lastname`, `email`, `number`, `subject`, `message`, `date`) 
                VALUES (:firstname, :lastname, :email, :number, :subject, :message, :date)";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':firstname', $contactInfos['firstname'], \PDO::PARAM_STR);
        $statement->bindValue(':lastname', $contactInfos['lastname'], \PDO::PARAM_STR);
        $statement->bindValue(':email', $contactInfos['email'], \PDO::PARAM_STR);
        $statement->bindValue(':number', $contactInfos['number'], \PDO::PARAM_INT);
        $statement->bindValue(':subject', $contactInfos['subject'], \PDO::PARAM_STR);
        $statement->bindValue(':message', $contactInfos['message'], \PDO::PARAM_STR);
        $statement->bindValue(':date', $now);

        return $statement->execute();
    }

    /**
     * Récupérer les infos de contact issues du formulaire
     */
    public function selectContact(): array
    {
        $query =
            "SELECT * FROM contact
            ORDER BY date DESC";

        return $this->pdo->query($query)->fetchAll();
    }
}
