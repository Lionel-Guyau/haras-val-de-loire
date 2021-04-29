<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class AdminManager extends AbstractManager
{

    public const TABLE_NEWS = 'news';
    public const TABLE_ACTIVITY = 'activity';

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
        $query = $this->pdo->prepare("UPDATE " . static::TABLE_NEWS . " 
                SET description = :description, news_date = now() WHERE id = :id");
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
    }
}
