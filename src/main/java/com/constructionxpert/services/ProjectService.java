package com.constructionxpert.services;

import com.constructionxpert.dao.ProjectDAO;
import com.constructionxpert.models.Project;

import java.util.Date;
import java.util.List;

public class ProjectService {
    private final ProjectDAO projectDAO;

    public ProjectService() {
        this.projectDAO = new ProjectDAO();
    }

    /**
     * Crée un nouveau projet
     * @param project le projet à créer
     * @return le projet créé
     */
    public Project createProject(Project project) {
        validateProject(project);
        return projectDAO.save(project);
    }

    /**
     * Met à jour un projet existant
     * @param project le projet à mettre à jour
     * @return le projet mis à jour
     */
    public Project updateProject(Project project) {
        if (project.getId() == null || !projectDAO.exists(project.getId())) {
            throw new IllegalArgumentException("Projet non trouvé");
        }
        validateProject(project);
        return projectDAO.update(project);
    }

    /**
     * Supprime un projet
     * @param projectId l'ID du projet
     * @return true si la suppression a réussi
     */
    public boolean deleteProject(Long projectId) {
        if (projectId == null) {
            throw new IllegalArgumentException("ID du projet requis");
        }
        return projectDAO.delete(projectId);
    }

    /**
     * Trouve un projet par son ID
     * @param projectId l'ID du projet
     * @return le projet trouvé
     */
    public Project getProjectById(Long projectId) {
        return projectDAO.findById(projectId)
                .orElseThrow(() -> new IllegalArgumentException("Projet non trouvé"));
    }

    /**
     * Récupère tous les projets
     * @return la liste des projets
     */
    public List<Project> getAllProjects() {
        return projectDAO.findAll();
    }

    /**
     * Trouve les projets par plage de dates
     * @param startDate date de début
     * @param endDate date de fin
     * @return la liste des projets
     */
    public List<Project> getProjectsByDateRange(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Les dates sont requises");
        }
        if (startDate.after(endDate)) {
            throw new IllegalArgumentException("La date de début doit être antérieure à la date de fin");
        }
        return projectDAO.findProjectsByDateRange(startDate, endDate);
    }

    /**
     * Trouve les projets par budget minimum
     * @param minBudget le budget minimum
     * @return la liste des projets
     */
    public List<Project> getProjectsByMinBudget(Double minBudget) {
        if (minBudget == null || minBudget < 0) {
            throw new IllegalArgumentException("Le budget minimum doit être positif");
        }
        return projectDAO.findProjectsByBudgetGreaterThan(minBudget);
    }

    /**
     * Met à jour le budget d'un projet
     * @param projectId l'ID du projet
     * @param newBudget le nouveau budget
     * @return true si la mise à jour a réussi
     */
    public boolean updateProjectBudget(Long projectId, Double newBudget) {
        if (projectId == null || newBudget == null || newBudget < 0) {
            throw new IllegalArgumentException("Données invalides pour la mise à jour du budget");
        }
        return projectDAO.updateProjectBudget(projectId, newBudget);
    }

    /**
     * Valide les données d'un projet
     * @param project le projet à valider
     */
    private void validateProject(Project project) {
        if (project == null) {
            throw new IllegalArgumentException("Le projet ne peut pas être null");
        }
        if (project.getName() == null || project.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom du projet est requis");
        }
        if (project.getStartDate() == null) {
            throw new IllegalArgumentException("La date de début est requise");
        }
        if (project.getEndDate() == null) {
            throw new IllegalArgumentException("La date de fin est requise");
        }
        if (project.getStartDate().after(project.getEndDate())) {
            throw new IllegalArgumentException("La date de début doit être antérieure à la date de fin");
        }
        if (project.getBudget() == null || project.getBudget() < 0) {
            throw new IllegalArgumentException("Le budget doit être positif");
        }
    }
}