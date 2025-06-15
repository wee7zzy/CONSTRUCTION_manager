package com.constructionxpert.dao;

import com.constructionxpert.models.Project;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Date;
import java.util.List;

public class ProjectDAO extends AbstractDAO<Project> {

    /**
     * Trouve tous les projets entre deux dates
     * @param startDate date de début
     * @param endDate date de fin
     * @return liste des projets
     */
    public List<Project> findProjectsByDateRange(Date startDate, Date endDate) {
        try (Session session = getSession()) {
            String hql = "FROM Project p WHERE p.startDate >= :startDate AND p.endDate <= :endDate";
            Query<Project> query = session.createQuery(hql, Project.class);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des projets par date", e);
        }
    }

    /**
     * Trouve tous les projets avec un budget supérieur à un montant donné
     * @param amount le montant minimum du budget
     * @return liste des projets
     */
    public List<Project> findProjectsByBudgetGreaterThan(Double amount) {
        try (Session session = getSession()) {
            String hql = "FROM Project p WHERE p.budget > :amount";
            Query<Project> query = session.createQuery(hql, Project.class);
            query.setParameter("amount", amount);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des projets par budget", e);
        }
    }

    /**
     * Met à jour le budget d'un projet
     * @param projectId l'ID du projet
     * @param newBudget le nouveau budget
     * @return true si la mise à jour a réussi, false sinon
     */
    public boolean updateProjectBudget(Long projectId, Double newBudget) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            Project project = session.get(Project.class, projectId);
            if (project != null) {
                project.setBudget(newBudget);
                session.update(project);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour du budget du projet", e);
        }
    }

    /**
     * Recherche des projets par nom (recherche partielle)
     * @param name le nom à rechercher
     * @return liste des projets correspondants
     */
    public List<Project> findProjectsByName(String name) {
        try (Session session = getSession()) {
            String hql = "FROM Project p WHERE lower(p.name) LIKE lower(:name)";
            Query<Project> query = session.createQuery(hql, Project.class);
            query.setParameter("name", "%" + name + "%");
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des projets par nom", e);
        }
    }
}