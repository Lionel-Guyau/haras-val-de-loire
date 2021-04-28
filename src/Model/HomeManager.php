<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class HomeManager extends AbstractManager
{

    public const TABLE = 'news';


    /**
     * Select old news in database
     */
    public function selectLastNews()
    {
        $query = "SELECT description FROM " . static::TABLE . " ORDER BY news_date ASC LIMIT 3";

        return $this->pdo->query($query)->fetchAll();
    }

    public function selectLastEvents()
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
