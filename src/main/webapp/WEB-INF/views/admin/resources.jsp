<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Ressources - ConstructionXpert</title>
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
                           class="flex items-center px-4 py-2 text-white hover:bg-blue-900 rounded-lg">
                            <i class="fas fa-tasks"></i>
                            <span class="ml-3">Tâches</span>
                        </a>
                    </li>
                    <li class="px-2 mt-2">
                        <a href="${pageContext.request.contextPath}/admin/resources" 
                           class="flex items-center px-4 py-2 text-white bg-blue-900 rounded-lg">
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
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Ressources</h1>
                    <button onclick="openNewResourceModal()" 
                            class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        Nouvelle Ressource
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
                                <label class="block text-sm font-medium text-gray-700">Type</label>
                                <select name="type" 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="">Tous les types</option>
                                    <option value="MATERIEL">Matériel</option>
                                    <option value="OUTIL">Outil</option>
                                    <option value="VEHICULE">Véhicule</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Fournisseur</label>
                                <select name="supplierId" 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="">Tous les fournisseurs</option>
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <option value="${supplier.id}">${supplier.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Stock minimum</label>
                                <input type="number" name="minQuantity" min="0" 
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

                <!-- Liste des ressources -->
                <div class="bg-white shadow rounded-lg">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantité</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fournisseur</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut Stock</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach items="${resources}" var="resource">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${resource.name}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${resource.type}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${resource.quantity}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${resource.supplier.name}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${resource.quantity gt 10}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">En stock</span>
                                                </c:when>
                                                <c:when test="${resource.quantity gt 0}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">Stock faible</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">Rupture</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-3">
                                                <button onclick="openResourceDetailsModal(${resource.id})" 
                                                        class="text-blue-600 hover:text-blue-900">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button onclick="openEditResourceModal(${resource.id})" 
                                                        class="text-yellow-600 hover:text-yellow-900">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button onclick="confirmDeleteResource(${resource.id})" 
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

    <!-- Modal Nouvelle Ressource -->
    <div id="newResourceModal" class="hidden fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
            </div>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <form id="newResourceForm" action="${pageContext.request.contextPath}/admin/resources/create" method="POST">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">Nouvelle Ressource</h3>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Nom</label>
                                <input type="text" name="name" required 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Type</label>
                                <select name="type" required 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="MATERIEL">Matériel</option>
                                    <option value="OUTIL">Outil</option>
                                    <option value="VEHICULE">Véhicule</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Quantité</label>
                                <input type="number" name="quantity" required min="0" 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Fournisseur</label>
                                <select name="supplierId" required 
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <option value="${supplier.id}">${supplier.name}</option>
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
                        <button type="button" onclick="closeNewResourceModal()" 
                                class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Annuler
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openNewResourceModal() {
            document.getElementById('newResourceModal').classList.remove('hidden');
        }

        function closeNewResourceModal() {
            document.getElementById('newResourceModal').classList.add('hidden');
        }

        function openResourceDetailsModal(resourceId) {
            window.location.href = `${pageContext.request.contextPath}/admin/resources/${resourceId}`;
        }

        function openEditResourceModal(resourceId) {
            window.location.href = `${pageContext.request.contextPath}/admin/resources/${resourceId}/edit`;
        }

        function confirmDeleteResource(resourceId) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cette ressource ?')) {
                window.location.href = `${pageContext.request.contextPath}/admin/resources/${resourceId}/delete`;
            }
        }

        // Fermer le modal si l'utilisateur clique en dehors
        window.onclick = function(event) {
            const modal = document.getElementById('newResourceModal');
            if (event.target == modal) {
                closeNewResourceModal();
            }
        }
    </script>
</body>
</html>