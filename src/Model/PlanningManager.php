<?php

namespace App\Model;

use PDO;

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
}
