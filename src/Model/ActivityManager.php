<?php

namespace App\Model;


class ActivityManager extends AbstractManager
{

    // public const LESSON_TABLE = 'lesson';
    // public const COURSE_TABLE = 'course';
    public const TABLE = 'lesson';

    /**
     * Ajouter les informations de contact issues du formulaire dans la base de données
     */

    public function selectLessons()
    {
        $query = "SELECT name, capacity, start_at FROM lesson";

        return $this->pdo->query($query)->fetchAll();
    }

    public function selectCourses()
    {
        $query = "SELECT name, capacity, start_at FROM course";

        return $this->pdo->query($query)->fetchAll();
    }
    
    public function selectLastEvents()
    {
        $query =
            "SELECT 'cours' AS type, 
                lesson.id, 
                lesson.name, 
                lesson.start_at, 
                COUNT(customer_lesson.lesson_id) AS nb_register, 
                lesson.capacity
            FROM (customer_lesson
            INNER JOIN lesson ON customer_lesson.lesson_id = lesson.id)
            WHERE lesson.is_active=1 AND customer_lesson.register=1 AND lesson.start_at >= now()
            GROUP BY customer_lesson.lesson_id 
        
        UNION 
        
            SELECT 'stage' AS type, 
                course.id, 
                course.name, 
                course.start_at, 
                COUNT(customer_course.course_id) AS nb_register, course.capacity
            FROM (customer_course
            INNER JOIN course ON customer_course.course_id = course.id)
            WHERE course.is_active=1 AND customer_course.register=1 AND course.start_at >= now()
            GROUP BY customer_course.course_id
        
        ORDER BY start_at ASC LIMIT 3";

        return $this->pdo->query($query)->fetchAll();
    }
}