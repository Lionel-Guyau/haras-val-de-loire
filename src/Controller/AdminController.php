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
use App\Model\EquipmentManager;

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

    public function controlDataPost($input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'POST') {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }

    public function controlDataGet(string $input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'GET') {
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
        $adminManager = new AdminManager();
        $selectNews = $adminManager->selectNews();

        return $this->twig->render('/Admin/adminNews.html.twig', ['selectnews' => $selectNews]);
    }

    public function addNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataPost($_POST['description'])) {
            $description = $this->sanitizeInput($_POST['description']);

            if (strlen($description) < 50) {
                $adminManager->insertNews($description);
            }
        }
        header('Location: /admin/news');
    }

    public function delNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataGet($_GET['id'])) {
            $id = $this->sanitizeInput($_GET['id']);
            if (filter_var($id, FILTER_VALIDATE_INT)) {
                $adminManager->deleteNews($id);
            }
            header('Location: /admin/news');
        }
    }

    public function majNews()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataPost($_POST['description']) && $this->controlDataPost($_POST['id'])) {
            $id = $this->sanitizeInput($_POST['id']);
            $description = $this->sanitizeInput($_POST['description']);

            if (strlen($description) < 50 && filter_var($id, FILTER_VALIDATE_INT)) {
                $adminManager->updateNews($id, $description);
            }
        }
        header('Location: /admin/news');
    }

    public function activity()
    {
        $adminManager = new AdminManager();
        $selectActivity = $adminManager->selectActivity();

        return $this->twig->render('/Admin/adminActivity.html.twig', ['selectactivity' => $selectActivity]);
    }

    public function addActivity()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataPost($_POST['name'])) {
            $name = $this->sanitizeInput($_POST['name']);

            if (strlen($name) < 50) {
                $adminManager->insertActivity($name);
            }
        }
        header('Location: /admin/activity');
        $activities = $adminManager->selectActivity();

        return $this->twig->render('/Admin/adminActivity.html.twig', [
            'activities' => $activities,
            'equipments' => (new EquipmentManager())->selectAll("description")
        ]);
    }

    public function saveActivity()
    {
        $activity = $_POST;

        // if ($this->controlDataPost($activity)) {
        //     $activities = $this->sanitizeInput($activity);

        // if (strlen($activities) < 50) {
        $adminManager = (new AdminManager())->saveActivity($activity);
        // }

        header('Location: /admin/activity');
        // }
    }

    public function delActivity()
    {
        $adminManager = new AdminManager();

        if ($this->controlDataGet($_GET['id'])) {
            $id = $this->sanitizeInput($_GET['id']);
            if (filter_var($id, FILTER_VALIDATE_INT)) {
                $adminManager->deleteActivity($id);
            }
            header('Location: /admin/activity');
        }
    }
}
