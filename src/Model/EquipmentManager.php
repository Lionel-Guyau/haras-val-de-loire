<?php

namespace App\Model;

use App\Model\Connection;
use PDO;

class EquipmentManager extends AbstractManager
{
    public const TABLE = 'equipment';

    /**
     * Select last news in database
     */
    public function selectEquipments()
    {
        $query = "SELECT * FROM " . static::TABLE . " ORDER BY description DESC";

        return $this->pdo->query($query)->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Insert equip in database
     */
    public function insertEquip(string $item)
    {
        $query = $this->pdo->prepare("
        INSERT INTO " . static::TABLE . " (`description`) 
        VALUES (:description)");
        $query->bindValue(':description', $item);

        $query->execute();
    }

    /**
     * Delete equip in database
     */
    public function deleteEquip(int $id): void
    {
        $query = $this->pdo->prepare("DELETE FROM " . static::TABLE . " WHERE equipment.id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);

        $query->execute();
    }

    /**
     * Update equip in database
     */
    public function updateEquip(int $id, string $description): void
    {
        $query = $this->pdo->prepare("UPDATE " . static::TABLE . " 
        SET description = :description WHERE id = :id");
        $query->bindValue(':id', $id, \PDO::PARAM_INT);
        $query->bindValue(':description', $description);
        $query->execute();
    }

}