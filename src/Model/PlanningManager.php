<?php

namespace App\Model;

use PDO;
use PhpParser\Node\Expr\Print_;

class PlanningManager extends AbstractManager
{
    public const TABLE = 'planning';

    /**
     * Renvoi la liste des créneau du planning pour une activité
     */
    public function selectByActivity(int $id)
    {
        $query = "SELECT activity.capacity, planning.start_at,  
                        COUNT(customer_planning.customer_id) AS nb_register
                FROM planning
                INNER JOIN customer_planning ON customer_planning.planning_id = planning.id
                INNER JOIN activity ON activity.id = planning.activity_id
                WHERE planning.activity_id = :activity_id AND planning.start_at >= now()
                GROUP BY customer_planning.planning_id
                HAVING activity.capacity > nb_register;";
        $statement = $this->pdo->prepare($query);
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
        $activities = $this->pdo->query("SELECT planning.*,activity.id AS id2, activity.type 
                FROM planning 
                INNER JOIN activity ON activity.id = planning.activity_id 
                ORDER BY planning.start_at ASC")->fetchAll();

        return $activities;
    }

    /**
     * Insert / Update planning in database
     */
    public function savePlanning(array $planning)
    {
        $startAt = $planning['start_at-date'] . " " . $planning['start_at-time'] . ":00";
        $endAt = $planning['end_at-date'] . " " . $planning['end_at-time'] . ":00";

        // Cas d'un udpate car l'id de l'activité est présent
        if (!empty($planning['id'])) {
            $query = "UPDATE " . static::TABLE . " 
                            SET description = :description,
                                activity_id = :activity_id,
                                start_at = :start_at,
                                end_at = :end_at
                            WHERE id = :id";
            $statement = $this->pdo->prepare($query);
            $statement->bindValue(':id', $planning['id'], PDO::PARAM_INT);
        } else {
            $query = "INSERT INTO " . static::TABLE . " (`description`, `activity_id`, `start_at`,`end_at`) 
                VALUES (:description, :activity_id, :start_at, :end_at)";
            $statement = $this->pdo->prepare($query);
        }

        $statement->bindValue(':description', $planning['description']);
        $statement->bindValue(':activity_id', $planning['type'], PDO::PARAM_INT);
        $statement->bindValue(':start_at', $startAt);
        $statement->bindValue(':end_at', $endAt);
        $statement->execute();
    }

    /**
     * Delete planning in database
     */
    public function deletePlanning(int $id)
    {
        $query = "DELETE FROM " . static::TABLE . " WHERE id = :id";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':id', $id, PDO::PARAM_INT);
        $statement->execute();
    }
}
