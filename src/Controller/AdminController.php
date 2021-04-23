<?php

/**
 * Created by PhpStorm.
 * User: aurelwcs
 * Date: 08/04/19
 * Time: 18:40
 */

namespace App\Controller;

use App\Model\AdminManager;

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
}
