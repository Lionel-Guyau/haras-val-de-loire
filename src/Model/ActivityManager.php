<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class ActivityManager extends AbstractManager
{

    public const TABLE = 'activity';

    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */

    /**
     * Récupère les activités avec leurs dates
     * @return array
     */
    public function selectPlannedActivity(): array
    {
        $query =
            "SELECT *, COUNT(customer_planning.customer_id) AS nb_register
                FROM activity
                    INNER JOIN planning ON activity.id = planning.activity_id
                    INNER JOIN customer_planning ON planning.id = customer_planning.planning_id
                WHERE customer_planning.register=1 AND planning.start_at >= now()
                GROUP BY planning.id
                ORDER BY activity.type, planning.start_at ASC";

        return $this->pdo->query($query)->fetchAll();
    }

    /**
     * Recupère chaque type d'activités
     */
    public function selectActivities(): array
    {
        $query =
            "SELECT * FROM activity";

        return $this->pdo->query($query)->fetchAll();
    }

    /**
     * Renvoi les 3 prochaines activités
     * @return array
     */
    public function selectLastEvents(): array
    {
        $query =
            "SELECT activity.id AS id,
                planning.description AS description, 
                activity.type AS type,
                planning.start_at AS startingDate,
                COUNT(customer_planning.customer_id) AS nb_register,
                activity.capacity AS capacity
            FROM (planning
                INNER JOIN activity ON planning.activity_id = activity.id
                INNER JOIN customer_planning ON planning.id = customer_planning.planning_id)
            WHERE customer_planning.register=1 AND planning.start_at >= now()
            GROUP BY planning.id
            ORDER BY startingDate ASC LIMIT 3";

        return $this->pdo->query($query)->fetchAll();
    }


    /**
     * Select Activity in database
     */
    public function selectActivity()
    {
        $activities = $this->pdo->query("SELECT * FROM activity ORDER BY type ASC")->fetchAll();

        $statement = $this->pdo->prepare("
            SELECT e.* FROM activity_equipment ae 
            LEFT JOIN equipment e ON ae.equipment_id = e.id 
            WHERE ae.activity_id = :activityId 
            ORDER BY e.description ASC
        ");

        foreach ($activities as $key => $activity) {
            $statement->bindValue(':activityId', $activity['id'], PDO::PARAM_INT);
            $statement->execute();

            $activities[$key]['equipments'] = $statement->fetchAll();
        }

        return $activities;
    }



    /**
     * Insert/Update Activity in database
     */
    public function saveActivity(array $activity)
    {
        $query = "INSERT INTO " . static::TABLE . " (`type`,`capacity`,`price`) 
        VALUES (:type, :capacity, :price)";

        // Cas d'un udpate car l'id de l'activité est présent
        if (!empty($activity['id'])) {
            $query = "UPDATE " . static::TABLE . " SET type = :type, capacity = :capacity, price = :price 
            WHERE id = :id";
        }
        $statement = $this->pdo->prepare($query);

        // Cas d'un udpate car l'id de l'activité est présent
        if (!empty($activity['id'])) {
            $statement->bindValue(':id', $activity['id'], PDO::PARAM_INT);
        }

        $statement->bindValue(':type', $activity['type']);
        $statement->bindValue(':capacity', $activity['capacity'], PDO::PARAM_INT);
        $statement->bindValue(':price', $activity['price'], PDO::PARAM_INT);
        $statement->execute();

        // On récupère l'id de l'activité (si update on l'a déjà, si insert on le récupère via lastInsertId())
        $newActivityId = empty($activity['id']) ? $this->pdo->lastInsertId() : $activity['id'];

        // On supprime tous équipements associés à l'activité
        $statement = $this->pdo->prepare("DELETE FROM activity_equipment WHERE activity_id = :id");
        $statement->bindValue(':id', $newActivityId, PDO::PARAM_INT);
        $statement->execute();

        // Ajout des équipements à l'activité
        if (!empty($activity['equipments'])) {
            foreach ($activity['equipments'] as $equipment) {
                $statement = $this->pdo->prepare("
                INSERT INTO activity_equipment(`activity_id`,`equipment_id`) VALUES (:activity_id, :equipment_id)
                 ");

                $statement->bindValue(':activity_id', $newActivityId, PDO::PARAM_INT);
                $statement->bindValue(':equipment_id', $equipment, PDO::PARAM_INT);
                $statement->execute();
            }
        }
    }

    /**
     * Delete Activity in database
     */
    public function deleteActivity(int $id): void
    {
        $statement = $this->pdo->prepare("
        DELETE  
        FROM activity
        WHERE activity.id = :id");
        $statement->bindValue(':id', $id, PDO::PARAM_INT);
        $statement->execute();
    }
}
