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

class AdminController extends AbstractController
{
    // On appelle le construct parent et on initialise la class AuthService et la méthode checkSession
    // checkSession : Si pas connecté, on redirige vers /login
    // Cela permet de sécuriser les méthodes afin d'éviter d'y accéder depuis l'URL

    public function __construct()
    {
        parent::__construct();
        (new AuthService())->checkSession();
    }

    /**
     * Display home page
     */
    public function index()
    {
        return $this->twig->render('/Admin/admin.html.twig');
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
        }

        header('Location: /admin/news');
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

    private function controlDataPost($input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'POST') {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }

    private function controlDataGet(string $input): bool
    {
        if ($_SERVER["REQUEST_METHOD"] === 'GET') {
            if (!empty($input)) {
                return true;
            }
        }
        return false;
    }

    private function sanitizeInput($data)
    {
        $data = trim($data);
        return $data;
    }
}
