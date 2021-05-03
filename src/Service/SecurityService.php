<?php

namespace App\Service;

class SecurityService
{
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
        return trim($data);
    }
}
