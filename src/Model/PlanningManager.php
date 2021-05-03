<?php

namespace App\Model;

use PDO;

class PlanningManager extends AbstractManager
{
    public const TABLE = 'planning';

    /**
     * Renvoi la liste des créneau du planning pour une activité.
     */
    public function selectByActivity(int $id)
    {
        $statement = $this->pdo->prepare('SELECT * FROM ' . static::TABLE . ' WHERE activity_id = :activity_id');
        $statement->bindValue(':activity_id', $id, PDO::PARAM_INT);
        $statement->execute();

        return $statement->fetchAll();
    }

    public function registerToActivity(array $registerInfos)
    {
        $query = "INSERT INTO customer  ('firstname', 'lastname', 'email')
        VALUES (:firstname, :lastname, :email)";

        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':fistname', $registerInfos['firstname'], PDO::PARAM_STR);
        $statement->bindValue(':lastname', $registerInfos['lastname'], PDO::PARAM_STR);
        $statement->bindValue(':email', $registerInfos['email'], PDO::PARAM_STR);

        return $statement->execute();
    }

    /**
     * Select Planning in database
     */
    public function selectPlanning()
    {
        $activities = $this->pdo->query("SELECT planning.*, activity.type from planning INNER JOIN activity ON activity.id = planning.activity_id ORDER BY planning.start_at ASC")->fetchAll();

        return $activities;
    }
}
