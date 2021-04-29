<?php

namespace App\Model;

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
    public function selectActivity(): array
    {
        $query =
                "SELECT activity.type, 
                        activity.capacity, 
                        planning.start_at 
                FROM activity
                    INNER JOIN planning ON activity.id = planning.activity_id";

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
}
