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
}
