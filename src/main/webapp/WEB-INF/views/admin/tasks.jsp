<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tâches - ConstructionXpert</title>
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
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-project-diagram"></i>
                            <span class="ml-3">Projets</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/tasks" 
                           class="flex items-center px-4 py-2 text-white bg-blue-900 rounded-lg">
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
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Tâches</h1>
                    <button onclick="openNewTaskModal()" 
                            class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        Nouvelle Tâche
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
                                <label class="block text-sm font-medium text-gray-700">Projet</label>
                                <select name="projectId" 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="">Tous les projets</option>
                                    <c:forEach items="${projects}" var="project">
                                        <option value="${project.id}">${project.name}</option>
                                    </c:forEach>
                                </select>
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

                <!-- Liste des tâches -->
                <div class="bg-white shadow rounded-lg">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Projet</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Début</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date Fin</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ressources</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach items="${tasks}" var="task">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${task.project.name}</td>
                                        <td class="px-6 py-4 text-sm text-gray-500">
                                            <div class="truncate max-w-xs">${task.description}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${task.startDate}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${task.endDate}</td>
                                        <td class="px-6 py-4 text-sm text-gray-500">
                                            <div class="flex flex-wrap gap-1">
                                                <c:forEach items="${task.resources}" var="resource" varStatus="status">
                                                    <c:if test="${status.index lt 3}">
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                        ${resource.name}
                                                    </span>
                                                </c:if>
                                                <c:if test="${task.resources.size() gt 3 && status.index eq 3}">
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                        +${task.resources.size() - 3}
                                                    </span>
                                                </c:if>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-3">
                                                <button onclick="openTaskDetailsModal(${task.id})" 
                                                        class="text-blue-600 hover:text-blue-900">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button onclick="openEditTaskModal(${task.id})" 
                                                        class="text-yellow-600 hover:text-yellow-900">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button onclick="confirmDeleteTask(${task.id})" 
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

    <!-- Modal Nouvelle Tâche -->
    <div id="newTaskModal" class="hidden fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
            </div>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <form id="newTaskForm" action="${pageContext.request.contextPath}/admin/tasks/create" method="POST">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">Nouvelle Tâche</h3>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Projet</label>
                                <select name="projectId" required 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <c:forEach items="${projects}" var="project">
                                        <option value="${project.id}">${project.name}</option>
                                    </c:forEach>
                                </select>
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
                                <label class="block text-sm font-medium text-gray-700">Ressources</label>
                                <select name="resourceIds" multiple required 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <c:forEach items="${resources}" var="resource">
                                        <option value="${resource.id}">${resource.name} (${resource.type})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                        <button type="submit" 
                                class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm">
                            Créer
                        </button>
                        <button type="button" onclick="closeNewTaskModal()" 
                                class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Annuler
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openNewTaskModal() {
            document.getElementById('newTaskModal').classList.remove('hidden');
        }

        function closeNewTaskModal() {
            document.getElementById('newTaskModal').classList.add('hidden');
        }

        function openTaskDetailsModal(taskId) {
            window.location.href = `${pageContext.request.contextPath}/admin/tasks/${taskId}`;
        }

        function openEditTaskModal(taskId) {
            window.location.href = `${pageContext.request.contextPath}/admin/tasks/${taskId}/edit`;
        }

        function confirmDeleteTask(taskId) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cette tâche ?')) {
                window.location.href = `${pageContext.request.contextPath}/admin/tasks/${taskId}/delete`;
            }
        }

        // Fermer le modal si l'utilisateur clique en dehors
        window.onclick = function(event) {
            const modal = document.getElementById('newTaskModal');
            if (event.target == modal) {
                closeNewTaskModal();
            }
        }
    </script>
</body>
</html>