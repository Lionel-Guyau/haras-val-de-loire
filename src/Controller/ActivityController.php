<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Controller\Calendar\Calendar;
use App\Controller\Activity\ActivityDescription;
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

    /**
     * Page par défault lors de l'arrivée sur xxx/activity
     */
    public function index()
    {
        $calendar = new Calendar();
        $calendarInfo = $calendar->getCalendarInfo();

        $start = $calendarInfo['firstDay'];
        $end = (clone $start)->modify("+" . ($calendarInfo['weeks'] * 7 - 1) . " days");

        $eventsByDays = $calendar->getEventsBetweenByDay($start, $end);

        $activity = new ActivityManager();
        $activityType = $activity->selectActivities();

        return $this->twig->render(
            '/Activity/activity.html.twig',
            [
                'calendarInfo' => $calendarInfo,
                'eventsByDays' => $eventsByDays,
                'activityType' => $activityType
            ]
        );
    }

    public function register(array $errors = null)
    {
        $activity = new ActivityManager();
        $activityType = $activity->selectPlannedActivity();
        $planning = isset($_GET['activity']) ? (new PlanningManager())->selectByActivity($_GET['activity']) : [];
        $description = (new ActivityDescription())->getDescription();
        $errors = [];
        $hasRegistered = false;

        // Vérification de l'existence de la request en methode POST
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Validation des données
            $errors = $this->validateForm();

            // Insertion des données dans la DB si pas d'erreurs
            if (empty($errors)) {
                $register = new RegisterManager();
                $customer = $register->getCustomer($_POST);

                if (empty($customer)) {
                    $register->addCustomer($_POST);
                    $customer = $register->getCustomer($_POST);
                }

                $customerId = $customer['id'];
                $planningId = $_POST['datetime'];
                $customerPlanning = $register->getCustomerPlanning($customerId, $planningId);

                if (empty($customerPlanning)) {
                    $register->addCustomerPlanning($customerId, $planningId);
                    $hasRegistered = true;
                } else {
                    $errors[] = 'Vous avez déjà souscrit à cette activité';
                }
            }
        }

        return $this->twig->render('/Activity/register.html.twig', [
            'activityType' => $activityType,
            'selectedActivity' => isset($_GET['activity']) ? $_GET['activity'] : null,
            'planning' => $planning,
            'errors' => $errors,
            'hasRegistered' => $hasRegistered,
            'description' => $description
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
        $activities = $activityManager->selectActivities();

        return $this->twig->render('/Activity/activity.html.twig', [
            'activities' => $activities,
        ]);
    }
}
