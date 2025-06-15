package com.constructionxpert.dao;

import com.constructionxpert.models.Task;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Date;
import java.util.List;

public class TaskDAO extends AbstractDAO<Task> {

    /**
     * Trouve toutes les tâches d'un projet
     * @param projectId l'ID du projet
     * @return liste des tâches
     */
    public List<Task> findTasksByProject(Long projectId) {
        try (Session session = getSession()) {
            String hql = "FROM Task t WHERE t.project.id = :projectId";
            Query<Task> query = session.createQuery(hql, Task.class);
            query.setParameter("projectId", projectId);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des tâches par projet", e);
        }
    }

    /**
     * Trouve toutes les tâches entre deux dates
     * @param startDate date de début
     * @param endDate date de fin
     * @return liste des tâches
     */
    public List<Task> findTasksByDateRange(Date startDate, Date endDate) {
        try (Session session = getSession()) {
            String hql = "FROM Task t WHERE t.startDate >= :startDate AND t.endDate <= :endDate";
            Query<Task> query = session.createQuery(hql, Task.class);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des tâches par date", e);
        }
    }

    /**
     * Met à jour les dates d'une tâche
     * @param taskId l'ID de la tâche
     * @param startDate nouvelle date de début
     * @param endDate nouvelle date de fin
     * @return true si la mise à jour a réussi, false sinon
     */
    public boolean updateTaskDates(Long taskId, Date startDate, Date endDate) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            Task task = session.get(Task.class, taskId);
            if (task != null) {
                task.setStartDate(startDate);
                task.setEndDate(endDate);
                session.update(task);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour des dates de la tâche", e);
        }
    }

    /**
     * Trouve les tâches par description (recherche partielle)
     * @param description la description à rechercher
     * @return liste des tâches correspondantes
     */
    public List<Task> findTasksByDescription(String description) {
        try (Session session = getSession()) {
            String hql = "FROM Task t WHERE lower(t.description) LIKE lower(:description)";
            Query<Task> query = session.createQuery(hql, Task.class);
            query.setParameter("description", "%" + description + "%");
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des tâches par description", e);
        }
    }

    /**
     * Compte le nombre de tâches par projet
     * @param projectId l'ID du projet
     * @return le nombre de tâches
     */
    public Long countTasksByProject(Long projectId) {
        try (Session session = getSession()) {
            String hql = "SELECT COUNT(t) FROM Task t WHERE t.project.id = :projectId";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("projectId", projectId);
            return query.uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors du comptage des tâches par projet", e);
        }
    }
}