<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class AdminManager extends AbstractManager
{

    public const TABLE = 'news';


    /**
     * Select last news in database
     */
    public function selectNews()
    {
        $query = "SELECT * FROM " . static::TABLE . " ORDER BY news_date DESC";

        return $this->pdo->query($query)->fetchAll(PDO::FETCH_ASSOC);
    }


    /**
     * Insert news in database
     */
    public function insertNews(string $item)
    {
        $query = $this->pdo->prepare("
        INSERT INTO " . static::TABLE . " (`description`,`news_date`) 
        VALUES (:description, NOW())");
        $query->bindValue(':description', $item);

        $query->execute();
    }

    /**
     * Delete news in database
     */
    public function deleteNews(int $id): void
    {
        $query = $this->pdo->prepare("DELETE FROM " . static::TABLE . " WHERE id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);

        $query->execute();
    }

    /**
     * Update news in database
     */
    public function updateNews(int $id, string $description): void
    {
        $query = $this->pdo->prepare("UPDATE " . static::TABLE . " SET description = :description, news_date = now() WHERE id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);
        $query->bindValue(':description', $description);
        $query->execute();
    }
}
