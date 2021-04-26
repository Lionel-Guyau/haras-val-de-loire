<?php

namespace App\Model;


class ActivityManager extends AbstractManager
{

    // public const LESSON_TABLE = 'lesson';
    // public const COURSE_TABLE = 'course';


    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */

    public function selectLessons()
    {
        $query = "SELECT lesson.name, lesson.capacity FROM lesson";

        return $this->pdo->query($query)->fetchAll();
    }

    public function selectCourses()
    {
        $query = "SELECT course.name FROM course";

        return $this->pdo->query($query)->fetchAll();
    }
}