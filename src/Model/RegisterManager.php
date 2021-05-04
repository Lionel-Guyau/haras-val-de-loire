<?php

namespace App\Model;

class RegisterManager extends AbstractManager
{

    public const TABLE = 'customer';

    public function addCustomer(array $customerInfo)
    {
        $query = "INSERT INTO customer (`firstname`, `lastname`, `email`) 
                VALUES (:firstname, :lastname, :email)
        ";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':firstname', $customerInfo['firstname'], \PDO::PARAM_STR);
        $statement->bindValue(':lastname', $customerInfo['lastname'], \PDO::PARAM_STR);
        $statement->bindValue(':email', $customerInfo['email'], \PDO::PARAM_STR);

        return $statement->execute();
    }

    public function getCustomer(array $customerInfo)
    {
        $firstname = $customerInfo['firstname'];
        $lastname = $customerInfo['lastname'];
        $email = $customerInfo['email'];
        $query =
                "SELECT *
                FROM customer
                WHERE firstname = '$firstname' AND lastname = '$lastname' AND email = '$email'
        ";
        return $this->pdo->query($query)->fetch();
    }

    public function addCustomerPlanning(int $customerId, int $planningId)
    {
        $query = "INSERT INTO customer_planning (`customer_id`, `planning_id`, `register`) 
                VALUES (:customerId, :planningId, 1)
        ";
        $statement = $this->pdo->prepare($query);

        $statement->bindValue(':customerId', $customerId, \PDO::PARAM_INT);
        $statement->bindValue(':planningId', $planningId, \PDO::PARAM_INT);

        return $statement->execute();
    }

    public function getCustomerPlanning(int $customerId, int $planningId)
    {
        $query =
                "SELECT customer_id,
                        planning_id
                FROM customer_planning
                WHERE customer_id = '$customerId' AND planning_id = '$planningId'
        ";
        return $this->pdo->query($query)->fetch();
    }
}
