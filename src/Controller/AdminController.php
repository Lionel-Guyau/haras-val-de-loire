<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\AdminManager;
use App\Service\AuthService;
use App\Model\NewsManager;
use App\Model\EquipmentManager;
use App\Model\ActivityManager;

class AdminController extends AbstractController
{
    /**
     * Display home page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */

    // On appelle le construct parent et on initialise la class AuthService et la méthode checkSession
    // checkSession : Si pas connecté, on redirige vers /login
    // Cela permet de sécuriser les méthodes afin d'éviter d'y accéder depuis l'URL
    public function __construct()
    {
        parent::__construct();
        (new AuthService())->checkSession();
    }

    public function index()
    {
        return $this->twig->render('/Admin/admin.html.twig');
    }

    public function controlData($input): bool
    {
        if (($_SERVER["REQUEST_METHOD"] === 'POST') || ($_SERVER["REQUEST_METHOD"] === 'GET')) {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }


    public function sanitizeInput($data)
    {
        $data = trim($data);
        return $data;
    }

    public function news()
    {
        $newsManager = new NewsManager();
        $selectNews = $newsManager->selectNews();

        return $this->twig->render('/Admin/adminNews.html.twig', ['selectnews' => $selectNews]);
    }

    public function addNews()
    {
        $newsManager = new NewsManager();

        if ($this->controlData($_POST['description'])) {
            $description = $this->sanitizeInput($_POST['description']);

            if (strlen($description) < 50) {
                $newsManager->insertNews($description);
            }
        }
        header('Location: /admin/news');
    }

    public function delNews()
    {
        $newsManager = new NewsManager();

        if ($this->controlData($_GET['id'])) {
            $id = $this->sanitizeInput($_GET['id']);
            if (filter_var($id, FILTER_VALIDATE_INT)) {
                $newsManager->deleteNews($id);
            }
            header('Location: /admin/news');
        }
    }

    public function majNews()
    {
        $newsManager = new NewsManager();

        if ($this->controlData($_POST['description']) && $this->controlData($_POST['id'])) {
            $id = $this->sanitizeInput($_POST['id']);
            $description = $this->sanitizeInput($_POST['description']);

            if (strlen($description) < 50 && filter_var($id, FILTER_VALIDATE_INT)) {
                $newsManager->updateNews($id, $description);
            }
        }
        header('Location: /admin/news');
    }

    public function activity()
    {
        $activityManager = new ActivityManager();
        $activities = $activityManager->selectActivity();

        return $this->twig->render('/Admin/adminActivity.html.twig', [
            'activities' => $activities,
            'equipments' => (new EquipmentManager())->selectAll("description")
        ]);
    }

    public function saveActivity()
    {
        $activity = $_POST;

        $activities = new ActivityManager();
        $activities->saveActivity($activity);

        header('Location: /admin/activity');
    }


    public function delActivity()
    {
        $activityManager = new ActivityManager();

        if ($this->controlData($_GET['id'])) {
            $id = $this->sanitizeInput($_GET['id']);
            if (filter_var($id, FILTER_VALIDATE_INT)) {
                $activityManager->deleteActivity($id);
            }
            header('Location: /admin/activity');
        }
    }
}
