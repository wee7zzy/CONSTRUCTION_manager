<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - ConstructionXpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full space-y-8">
            <!-- Logo et Titre -->
            <div>
                <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                    <i class="fas fa-hard-hat text-blue-600 text-4xl mb-4"></i>
                    <span class="block">ConstructionXpert</span>
                </h2>
                <p class="mt-2 text-center text-sm text-gray-600">
                    Connectez-vous à votre espace administrateur
                </p>
            </div>

            <!-- Message d'erreur -->
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline">${error}</span>
                </div>
            </c:if>

            <!-- Formulaire de connexion -->
            <form class="mt-8 space-y-6" action="${pageContext.request.contextPath}/login" method="POST">
                <input type="hidden" name="remember" value="true">
                <div class="rounded-md shadow-sm -space-y-px">
                    <!-- Nom d'utilisateur -->
                    <div>
                        <label for="username" class="sr-only">Nom d'utilisateur</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input id="username" name="username" type="text" required 
                                class="appearance-none rounded-none relative block w-full px-3 py-2 pl-10 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm" 
                                placeholder="Nom d'utilisateur">
                        </div>
                    </div>
                    <!-- Mot de passe -->
                    <div>
                        <label for="password" class="sr-only">Mot de passe</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <input id="password" name="password" type="password" required 
                                class="appearance-none rounded-none relative block w-full px-3 py-2 pl-10 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm" 
                                placeholder="Mot de passe">
                        </div>
                    </div>
                </div>

                <!-- Options de connexion -->
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <input id="remember-me" name="remember-me" type="checkbox" 
                            class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                        <label for="remember-me" class="ml-2 block text-sm text-gray-900">
                            Se souvenir de moi
                        </label>
                    </div>
                </div>

                <!-- Bouton de connexion -->
                <div>
                    <button type="submit" 
                        class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <span class="absolute left-0 inset-y-0 flex items-center pl-3">
                            <i class="fas fa-sign-in-alt text-blue-500 group-hover:text-blue-400"></i>
                        </span>
                        Se connecter
                    </button>
                </div>
            </form>

            <!-- Lien de retour -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/" class="text-sm text-blue-600 hover:text-blue-500">
                    <i class="fas fa-arrow-left mr-2"></i>Retour à l'accueil
                </a>
            </div>
        </div>
    </div>
</body>
</html>