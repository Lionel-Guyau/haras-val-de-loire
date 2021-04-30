<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class AdminManager extends AbstractManager
{

    public const TABLE_NEWS = 'news';
    public const TABLE_ACTIVITY = 'activity';
    public const TABLE_EQUIPMENT = 'equipment';

    /**
     * Select last news in database
     */
    public function selectNews()
    {
        $query = "SELECT * FROM " . static::TABLE_NEWS . " ORDER BY news_date DESC";

        return $this->pdo->query($query)->fetchAll(PDO::FETCH_ASSOC);
    }


    /**
     * Insert news in database
     */
    public function insertNews(string $item)
    {
        $query = $this->pdo->prepare("
        INSERT INTO " . static::TABLE_NEWS . " (`description`,`news_date`) 
        VALUES (:description, NOW())");
        $query->bindValue(':description', $item);

        $query->execute();
    }

    /**
     * Delete news in database
     */
    public function deleteNews(int $id): void
    {
        $query = $this->pdo->prepare("DELETE FROM " . static::TABLE_NEWS . " WHERE news.id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);

        $query->execute();
    }

    /**
     * Update news in database
     */
    public function updateNews(int $id, string $description): void
    {
        $query = $this->pdo->prepare("UPDATE " . static::TABLE_NEWS . " SET description = :description, news_date = now() WHERE id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);
        $query->bindValue(':description', $description);
        $query->execute();
    }


    /**
     * Select Activity in database
     */
    public function selectActivity()
    {
        $query =
            "SELECT 
                    activity.type,
                    activity.capacity,
                    activity.price,
                    equipment.desciption
                FROM ((activity_equipment
                    INNER JOIN activity ON activity_equipment.activity_id = activity.id
                    INNER JOIN equipment ON activity_equipment.equipment_id = equipment.id))
                ORDER BY activity.type";

        return $this->pdo->query($query)->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Insert Activity in database
     */
    public function insertActivity(string $name)
    {
        $query = $this->pdo->prepare("
        INSERT INTO " . static::TABLE_ACTIVITY . " (`name`,`start_at`) 
        VALUES (:start_at, NOW())");
        $query->bindValue(':name', $name);

        $query->execute();
        $activities = $this->pdo->query("SELECT * FROM activity ORDER BY id DESC")->fetchAll();

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
        $query = "INSERT INTO " . static::TABLE_ACTIVITY . " (`type`,`capacity`,`price`) VALUES (:type, :capacity, :price)";

        // Cas d'un udpate car l'id de l'activité est présent
        if (!empty($activity['id'])) {
            $query = "UPDATE " . static::TABLE_ACTIVITY . " SET type = :type, capacity = :capacity, price = :price WHERE id = :id";
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
        foreach ($activity['equipments'] as $equipment) {
            $statement = $this->pdo->prepare("
                INSERT INTO activity_equipment(`activity_id`,`equipment_id`) VALUES (:activity_id, :equipment_id)
            ");

            $statement->bindValue(':activity_id', $newActivityId, PDO::PARAM_INT);
            $statement->bindValue(':equipment_id', $equipment, PDO::PARAM_INT);
            $statement->execute();
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
