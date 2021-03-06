<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Service\AuthService;
use App\Model\NewsManager;
use App\Model\EquipmentManager;
use App\Model\ActivityManager;
use App\Service\SecurityService;
use App\Model\PlanningManager;
use App\Model\ContactManager;

/**
 * Suppress all warnings from these two rules.
 *
 * @SuppressWarnings(PHPMD)
 */
class AdminController extends AbstractController
{
    private SecurityService $securityService;

    /**
     * Display home page
     *
     * On appelle le construct parent et on initialise la class AuthService et la méthode checkSession
     * checkSession : Si pas connecté, on redirige vers /login
     * Cela permet de sécuriser les méthodes afin d'éviter d'y accéder depuis l'URL
     */
    public function __construct()
    {
        parent::__construct();
        $this->securityService = new SecurityService();

        (new AuthService())->checkSession();
    }

    public function index()
    {
        $contacts = new ContactManager();
        $nbContacts = $contacts->selectContact();
        $nbMessage = count($nbContacts);

        return $this->twig->render('/Admin/admin.html.twig', [
            'nbMessage' => $nbMessage,
        ]);
    }

    public function news()
    {
        $newsManager = new NewsManager();
        $selectNews = $newsManager->selectNews();

        return $this->twig->render('/Admin/adminNews.html.twig', ['selectnews' => $selectNews]);
    }

    public function addNews()
    {
        $activity = $_POST;

        $newsManager = new NewsManager();

        if (!empty($activity)) {
            if ($this->securityService->controlData($_POST['description'])) {
                $description = $this->securityService->sanitizeInput($_POST['description']);

                if (strlen($description) < 50) {
                    $newsManager->insertNews($description);
                }
            }
            header('Location: /admin/news');
        }
    }

    public function delNews()
    {
        $activity = $_GET;

        $newsManager = new NewsManager();

        if (!empty($activity)) {
            if ($this->securityService->controlData($_GET['id'])) {
                $id = $this->securityService->sanitizeInput($_GET['id']);
                if (filter_var($id, FILTER_VALIDATE_INT)) {
                    $newsManager->deleteNews($id);
                }
            }
            header('Location: /admin/news');
        }
    }

    public function majNews()
    {
        $activity = $_POST;

        $newsManager = new NewsManager();

        if (!empty($activity)) {
            if (
                $this->securityService->controlData($_POST['description']) &&
                $this->securityService->controlData($_POST['id'])
            ) {
                $id = $this->securityService->sanitizeInput($_POST['id']);
                $description = $this->securityService->sanitizeInput($_POST['description']);

                if (strlen($description) < 50 && filter_var($id, FILTER_VALIDATE_INT)) {
                    $newsManager->updateNews($id, $description);
                }
                header('Location: /admin/news');
            }
        }
    }

    public function activity()
    {
        $adminManager = new ActivityManager();
        $activities = $adminManager->selectActivity();

        return $this->twig->render('/Admin/adminActivity.html.twig', [
            'activities' => $activities,
            'equipments' => (new EquipmentManager())->selectAll("description")
        ]);
    }

    public function saveActivity()
    {
        $activity = $_POST;

        $adminManager = new ActivityManager();

        if (!empty($activity)) {
            $adminManager->saveActivity($activity);
        }

        header('Location: /admin/activity');
    }

    public function delActivity()
    {
        $activity = $_GET;

        $adminManager = new ActivityManager();

        if (!empty($activity)) {
            if ($this->securityService->controlData($_GET['id'])) {
                $id = $this->securityService->sanitizeInput($_GET['id']);
                if (filter_var($id, FILTER_VALIDATE_INT)) {
                    $adminManager->deleteActivity($id);
                }
                header('Location: /admin/activity');
            }
        }
    }

    public function equipments()
    {
        $equipmentsManager = new EquipmentManager();
        $selectEquipments = $equipmentsManager->selectEquipments();

        return $this->twig->render('/Admin/adminEquipments.html.twig', ['equipments' => $selectEquipments]);
    }

    public function addEquip()
    {
        $equip = $_POST;

        $equipManager = new EquipmentManager();

        if (!empty($equip)) {
            if ($this->securityService->controlData($_POST['description'])) {
                $description = $this->securityService->sanitizeInput($_POST['description']);

                if (strlen($description) < 50) {
                    $equipManager->insertEquip($description);
                }
            }
            header('Location: /admin/equipments');
        }
    }

    public function delEquip()
    {
        $equip = $_GET;

        $equipManager = new EquipmentManager();

        if (!empty($equip)) {
            if ($this->securityService->controlData($_GET['id'])) {
                $id = $this->securityService->sanitizeInput($_GET['id']);
                if (filter_var($id, FILTER_VALIDATE_INT)) {
                    $equipManager->deleteEquip($id);
                }
            }
            header('Location: /admin/equipments');
        }
    }

    public function majEquip()
    {
        $equip = $_POST;

        $equipManager = new EquipmentManager();

        if (!empty($equip)) {
            if (
                $this->securityService->controlData($_POST['description']) &&
                $this->securityService->controlData($_POST['id'])
            ) {
                $id = $this->securityService->sanitizeInput($_POST['id']);
                $description = $this->securityService->sanitizeInput($_POST['description']);

                if (strlen($description) < 50 && filter_var($id, FILTER_VALIDATE_INT)) {
                    $equipManager->updateEquip($id, $description);
                }
                header('Location: /admin/equipments');
            }
        }
    }

    public function planning()
    {
        $planningManager = new PlanningManager();
        $planning = $planningManager->selectPlanning();
        $activityType = (new ActivityManager())->selectActivities();

        return $this->twig->render('/Admin/adminPlanning.html.twig', [
            'planning' => $planning,
            'activityType' => $activityType
        ]);
    }

    public function savePlanning()
    {
        $planning = $_POST;

        $adminManager = new PlanningManager();

        if (!empty($planning)) {
            $adminManager->savePlanning($planning);
        }

        header('Location: /admin/planning');
    }

    public function delPlanning()
    {
        $planning = $_GET;

        $adminManager = new PlanningManager();

        if (!empty($planning)) {
            if ($this->securityService->controlData($_GET['id'])) {
                $id = $this->securityService->sanitizeInput($_GET['id']);
                if (filter_var($id, FILTER_VALIDATE_INT)) {
                    $adminManager->deletePlanning($id);
                }
            }
        }
        header('Location: /admin/planning');
    }

    public function showContact()
    {
        $contactManager = new ContactManager();
        $contacts = $contactManager->selectContact();
        // $nbContacts = $contactManager->countContact();

        return $this->twig->render('/Admin/adminContact.html.twig', [
            'contacts' => $contacts,
            // 'nbContacts' => $nbContacts,
        ]);
    }


    public function delMessage()
    {
        $contact = $_GET;

        $delMessage = new ContactManager();

        if (!empty($contact)) {
            if ($this->securityService->controlData($_GET['id'])) {
                $id = $this->securityService->sanitizeInput($_GET['id']);
                if (filter_var($id, FILTER_VALIDATE_INT)) {
                    $delMessage->delMessage($id);
                }
            }
        }
        header('Location: /admin/showContact');
    }
}
