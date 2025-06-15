<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur serveur - ConstructionXpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-screen flex items-center justify-center">
    <div class="text-center">
        <div class="mb-8">
            <i class="fas fa-server text-red-500 text-6xl mb-4"></i>
            <h1 class="text-6xl font-bold text-gray-800 mb-4">500</h1>
            <h2 class="text-2xl font-semibold text-gray-600 mb-4">Erreur serveur</h2>
            <p class="text-gray-500 mb-8">Une erreur inattendue s'est produite. Nos équipes techniques ont été notifiées.</p>
        </div>
        <div>
            <a href="/" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-300 ease-in-out inline-flex items-center">
                <i class="fas fa-home mr-2"></i>
                Retour à l'accueil
            </a>
        </div>
    </div>
</body>
</html>