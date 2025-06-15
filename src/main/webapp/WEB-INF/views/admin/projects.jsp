<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Projets - ConstructionXpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex">
        <!-- Sidebar (même que dashboard.jsp) -->
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
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-tachometer-alt"></i>
                            <span class="ml-3">Tableau de Bord</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/projects" 
                           class="flex items-center px-4 py-2 text-white bg-blue-900 rounded-lg">
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
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Projets</h1>
                    <button onclick="openNewProjectModal()" 
                            class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        Nouveau Projet
                    </button>
                </div>
            </header>

            <!-- Contenu -->
            <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
                <!-- Filtres -->
                <div class="bg-white shadow rounded-lg mb-6">
                    <div class="p-4">
                        <form class="grid grid-cols-1 gap-4 md:grid-cols-4" id="filterForm">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Rechercher</label>
                                <input type="text" name="search" placeholder="Nom du projet..." 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Date début</label>
                                <input type="date" name="startDate" 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Date fin</label>
                                <input type="date" name="endDate" 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div class="flex items-end">
                                <button type="submit" 
                                        class="w-full bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-lg">
                                    <i class="fas fa-search mr-2"></i>Filtrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Liste des projets -->
                <div class="bg-white shadow rounded-lg">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Début</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Fin</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Budget</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach items="${projects}" var="project">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${project.name}</td>
                                        <td class="px-6 py-4 text-sm text-gray-500">
                                            <div class="truncate max-w-xs">${project.description}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.startDate}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.endDate}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${project.budget} €</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                ${project.status eq 'EN_COURS' ? 'bg-green-100 text-green-800' : 
                                                  project.status eq 'EN_ATTENTE' ? 'bg-yellow-100 text-yellow-800' : 
                                                  'bg-red-100 text-red-800'}">
                                                ${project.status}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-3">
                                                <a href="${pageContext.request.contextPath}/admin/projects/${project.id}" 
                                                   class="text-blue-600 hover:text-blue-900">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <button onclick="openEditProjectModal(${project.id})" 
                                                        class="text-yellow-600 hover:text-yellow-900">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button onclick="confirmDeleteProject(${project.id})" 
                                                        class="text-red-600 hover:text-red-900">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal Nouveau Projet -->
    <div id="newProjectModal" class="hidden fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
            </div>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <form id="newProjectForm" action="${pageContext.request.contextPath}/admin/projects/create" method="POST">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">Nouveau Projet</h3>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Nom</label>
                                <input type="text" name="name" required 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Description</label>
                                <textarea name="description" rows="3" required 
                                          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"></textarea>
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Date début</label>
                                    <input type="date" name="startDate" required 
                                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700">Date fin</label>
                                    <input type="date" name="endDate" required 
                                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Budget</label>
                                <input type="number" name="budget" required min="0" step="0.01" 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Statut</label>
                                <select name="status" required 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="EN_ATTENTE">En attente</option>
                                    <option value="EN_COURS">En cours</option>
                                    <option value="TERMINE">Terminé</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                        <button type="submit" 
                                class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm">
                            Créer
                        </button>
                        <button type="button" onclick="closeNewProjectModal()" 
                                class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Annuler
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openNewProjectModal() {
            document.getElementById('newProjectModal').classList.remove('hidden');
        }

        function closeNewProjectModal() {
            document.getElementById('newProjectModal').classList.add('hidden');
        }

        function openEditProjectModal(projectId) {
            // Implémenter la logique d'édition
            window.location.href = `${pageContext.request.contextPath}/admin/projects/${projectId}/edit`;
        }

        function confirmDeleteProject(projectId) {
            if (confirm('Êtes-vous sûr de vouloir supprimer ce projet ?')) {
                // Implémenter la logique de suppression
                window.location.href = `${pageContext.request.contextPath}/admin/projects/${projectId}/delete`;
            }
        }

        // Fermer le modal si l'utilisateur clique en dehors
        window.onclick = function(event) {
            const modal = document.getElementById('newProjectModal');
            if (event.target == modal) {
                closeNewProjectModal();
            }
        }
    </script>
</body>
</html>