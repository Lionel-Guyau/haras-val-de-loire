<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\ActivityManager;
use App\Model\PlanningManager;
use App\Model\RegisterManager;

class ActivityController extends AbstractController
{
    /**
     * Display activity page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */


    public function index()
    {
        return $this->twig->render('/Activity/activity.html.twig');
    }

    public function register(array $errors = null)
    {
        $activity = new ActivityManager();
        $activityType = $activity->selectActivity();
        $plannedActivity = $activity->selectPlannedActivity();
        $plannedActivityOrdered = $this->orderingActivitiesByType($plannedActivity);
        $planning = isset($_GET['activity']) ? (new PlanningManager())->selectByActivity($_GET['activity']) : [];

        $errors = [];
        
        // Vérification de l'existence de la request en methode POST
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            // Validation des données
            $errors = $this->validateForm();

            // Insertion des données dans la DB si pas d'erreurs
            if (empty($errors)) {
                $register = new RegisterManager();
                
                $customer = $register->getCustomer($_POST);
                if (empty($customer))
                {
                    $register-> addCustomer($_POST);
                    $customer = $register->getCustomer($_POST);
                }
                $customerId = $customer['id'];
                $planningId = $_POST['datetime'];
                $customerPlanning = $register->getCustomerPlanning($customerId , $planningId);
                if (empty($customerPlanning))
                {
                    $register-> addCustomerPlanning($customerId , $planningId);

                } else {

                    // A faire : Alert si déjà enregistré et retour sur /activity
                }

                //A faire : Alert si l'enregistrement a bien été effectué
                
                header('Location: /activity');
            }
        }

        return $this->twig->render('/Activity/register.html.twig', [
            'activityType' => $activityType,
            'plannedActivityOrdered' => $plannedActivityOrdered,
            'selectedActivity' => isset($_GET['activity']) ? $_GET['activity'] : null,
            'planning' => $planning,
            'errors' => $errors
        ]);


    }

    public function validateForm(): array
    {
        $errors = [];

        //tester si les valeurs sont vides
        if (empty($_POST)) {
            $errors[] = 'Veuillez renseigner les champs pour l\'inscription';
        } else {
            foreach ($_POST as $key => $value) {
                if (empty($value)) {
                    $errors[] = 'Veuillez remplir TOUS les champs pour l\'inscription';
                }
                $_POST[$key] = htmlspecialchars(trim($value));
                
            }
            if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                if (empty($errors)) {
                    $errors[] = 'Veuillez renseigner une adresse mail valide';
                }
            }
        }

        return $errors;
    }

    public function showActivity()
    {
        $activityManager = new ActivityManager();
        $activities = $activityManager->selectActivity();

        return $this->twig->render('/Activity/activity.html.twig', [
            'activities' => $activities,
        ]);
    }


    public function orderingActivitiesByType(array $plannedActivity): array
    {
        $typedActivity = [];


        //ajoute les tableau dans $typedActivity selon une indéxation par une clé
        foreach ($plannedActivity as $activity) {

            //défini la clé qui va servir à indexer
            $type = $activity['type'];
            $date = explode(' ', $activity['start_at'])[0];

            // $activity = $this->orderingActivitiesByDate($activity);

            // vérifie qu'il existe déjà ou non une indéxation avec la clé sélectionnée, sinon créé cette indéxation
            if (!isset($typedActivity[$type][$date])) {

                //créer l'indéxation et ajout le tableau à l'intérieur
                $typedActivity[$type][$date] = [$activity];
            } else {

                //ajoute le tableau à l'intérieur
                $typedActivity[$type][$date][] = $activity;
                // array_push($typedActivity[$type][$date], $activity);
            }
        }

        return $typedActivity;
    }
}
