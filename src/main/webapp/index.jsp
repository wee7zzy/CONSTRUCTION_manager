<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert Services</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-blue-600 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex">
                    <div class="flex-shrink-0 flex items-center">
                        <span class="text-white text-xl font-bold">ConstructionXpert</span>
                    </div>
                </div>
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/login" class="text-white hover:bg-blue-700 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-sign-in-alt mr-2"></i>Connexion
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="relative bg-white overflow-hidden">
        <div class="max-w-7xl mx-auto">
            <div class="relative z-10 pb-8 bg-white sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32">
                <main class="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
                    <div class="sm:text-center lg:text-left">
                        <h1 class="text-4xl tracking-tight font-extrabold text-gray-900 sm:text-5xl md:text-6xl">
                            <span class="block">Gestion de Projets</span>
                            <span class="block text-blue-600">de Construction</span>
                        </h1>
                        <p class="mt-3 text-base text-gray-500 sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
                            Solution complète pour la gestion de vos projets de construction. Planifiez, organisez et suivez vos projets efficacement.
                        </p>
                    </div>
                </main>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="py-12 bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    Nos Fonctionnalités
                </h2>
            </div>
            <div class="mt-10">
                <div class="grid grid-cols-1 gap-10 sm:grid-cols-2 lg:grid-cols-3">
                    <!-- Gestion des Projets -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <div class="text-center">
                                <i class="fas fa-project-diagram text-4xl text-blue-500"></i>
                                <h3 class="mt-2 text-lg font-medium text-gray-900">Gestion des Projets</h3>
                                <p class="mt-1 text-sm text-gray-500">Créez et gérez vos projets avec tous les détails nécessaires</p>
                            </div>
                        </div>
                    </div>
                    <!-- Gestion des Tâches -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <div class="text-center">
                                <i class="fas fa-tasks text-4xl text-blue-500"></i>
                                <h3 class="mt-2 text-lg font-medium text-gray-900">Gestion des Tâches</h3>
                                <p class="mt-1 text-sm text-gray-500">Organisez et suivez les tâches de chaque projet</p>
                            </div>
                        </div>
                    </div>
                    <!-- Gestion des Ressources -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <div class="text-center">
                                <i class="fas fa-boxes text-4xl text-blue-500"></i>
                                <h3 class="mt-2 text-lg font-medium text-gray-900">Gestion des Ressources</h3>
                                <p class="mt-1 text-sm text-gray-500">Gérez efficacement vos ressources et fournisseurs</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800">
        <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <p class="text-base text-gray-400">&copy; 2024 ConstructionXpert Services. Tous droits réservés.</p>
            </div>
        </div>
    </footer>
</body>
</html>