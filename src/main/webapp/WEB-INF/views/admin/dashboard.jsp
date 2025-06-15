<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - ConstructionXpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex">
        <!-- Sidebar -->
        <nav class="bg-blue-800 w-64 flex-shrink-0">
            <div class="h-16 flex items-center justify-center">
                <span class="text-white text-xl font-bold">ConstructionXpert</span>
            </div>
            <div class="mt-6">
                <div class="px-4 py-2">
                    <div class="flex items-center">
                        <i class="fas fa-user-circle text-white text-2xl"></i>
                        <span class="ml-2 text-white font-medium">${admin.fullName}</span>
                    </div>
                </div>
                <ul class="mt-6">
                    <li class="px-2">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="flex items-center px-4 py-2 text-white bg-blue-900 rounded-lg">
                            <i class="fas fa-tachometer-alt"></i>
                            <span class="ml-3">Tableau de Bord</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/projects" 
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-project-diagram"></i>
                            <span class="ml-3">Projets</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/tasks" 
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-tasks"></i>
                            <span class="ml-3">Tâches</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/resources" 
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-boxes"></i>
                            <span class="ml-3">Ressources</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/suppliers" 
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-truck"></i>
                            <span class="ml-3">Fournisseurs</span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- Déconnexion -->
            <div class="absolute bottom-0 w-64 mb-8">
                <a href="${pageContext.request.contextPath}/logout" 
                   class="flex items-center px-6 py-2 text-white hover:bg-blue-900">
                    <i class="fas fa-sign-out-alt"></i>
                    <span class="ml-3">Déconnexion</span>
                </a>
            </div>
        </nav>

        <!-- Contenu principal -->
        <div class="flex-1">
            <!-- Header -->
            <header class="bg-white shadow">
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                    <h1 class="text-3xl font-bold text-gray-900">Tableau de Bord</h1>
                </div>
            </header>

            <!-- Contenu -->
            <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
                <!-- Statistiques -->
                <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
                    <!-- Projets -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="p-5">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 bg-blue-500 rounded-md p-3">
                                    <i class="fas fa-project-diagram text-white text-2xl"></i>
                                </div>
                                <div class="ml-5 w-0 flex-1">
                                    <dl>
                                        <dt class="text-sm font-medium text-gray-500 truncate">Total Projets</dt>
                                        <dd class="text-3xl font-semibold text-gray-900">${totalProjects}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tâches -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="p-5">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 bg-green-500 rounded-md p-3">
                                    <i class="fas fa-tasks text-white text-2xl"></i>
                                </div>
                                <div class="ml-5 w-0 flex-1">
                                    <dl>
                                        <dt class="text-sm font-medium text-gray-500 truncate">Total Tâches</dt>
                                        <dd class="text-3xl font-semibold text-gray-900">${totalTasks}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Ressources -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="p-5">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 bg-yellow-500 rounded-md p-3">
                                    <i class="fas fa-boxes text-white text-2xl"></i>
                                </div>
                                <div class="ml-5 w-0 flex-1">
                                    <dl>
                                        <dt class="text-sm font-medium text-gray-500 truncate">Total Ressources</dt>
                                        <dd class="text-3xl font-semibold text-gray-900">${totalResources}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Fournisseurs -->
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="p-5">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 bg-purple-500 rounded-md p-3">
                                    <i class="fas fa-truck text-white text-2xl"></i>
                                </div>
                                <div class="ml-5 w-0 flex-1">
                                    <dl>
                                        <dt class="text-sm font-medium text-gray-500 truncate">Total Fournisseurs</dt>
                                        <dd class="text-3xl font-semibold text-gray-900">${totalSuppliers}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Projets Récents -->
                <div class="mt-8">
                    <div class="bg-white shadow rounded-lg">
                        <div class="px-4 py-5 border-b border-gray-200 sm:px-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900">Projets Récents</h3>
                        </div>
                        <div class="px-4 py-5 sm:p-6">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Début</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Fin</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Budget</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <c:forEach items="${recentProjects}" var="project">
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${project.name}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.startDate}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.endDate}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.budget} €</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <a href="${pageContext.request.contextPath}/admin/projects/${project.id}" class="text-blue-600 hover:text-blue-900">Voir détails</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>