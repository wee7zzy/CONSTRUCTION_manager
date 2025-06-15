package com.constructionxpert.dao;

import com.constructionxpert.models.Resource;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ResourceDAO extends AbstractDAO<Resource> {

    /**
     * Trouve toutes les ressources par type
     * @param type le type de ressource
     * @return liste des ressources
     */
    public List<Resource> findResourcesByType(String type) {
        try (Session session = getSession()) {
            String hql = "FROM Resource r WHERE r.type = :type";
            Query<Resource> query = session.createQuery(hql, Resource.class);
            query.setParameter("type", type);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des ressources par type", e);
        }
    }

    /**
     * Trouve toutes les ressources d'un fournisseur
     * @param supplierId l'ID du fournisseur
     * @return liste des ressources
     */
    public List<Resource> findResourcesBySupplier(Long supplierId) {
        try (Session session = getSession()) {
            String hql = "FROM Resource r WHERE r.supplier.id = :supplierId";
            Query<Resource> query = session.createQuery(hql, Resource.class);
            query.setParameter("supplierId", supplierId);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des ressources par fournisseur", e);
        }
    }

    /**
     * Met à jour la quantité d'une ressource
     * @param resourceId l'ID de la ressource
     * @param quantity la nouvelle quantité
     * @return true si la mise à jour a réussi, false sinon
     */
    public boolean updateResourceQuantity(Long resourceId, Integer quantity) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            Resource resource = session.get(Resource.class, resourceId);
            if (resource != null) {
                resource.setQuantity(quantity);
                session.update(resource);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de la quantité de la ressource", e);
        }
    }

    /**
     * Trouve les ressources avec une quantité inférieure à un seuil
     * @param threshold le seuil de quantité
     * @return liste des ressources
     */
    public List<Resource> findResourcesBelowThreshold(Integer threshold) {
        try (Session session = getSession()) {
            String hql = "FROM Resource r WHERE r.quantity < :threshold";
            Query<Resource> query = session.createQuery(hql, Resource.class);
            query.setParameter("threshold", threshold);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des ressources sous le seuil", e);
        }
    }

    /**
     * Trouve les ressources par nom (recherche partielle)
     * @param name le nom à rechercher
     * @return liste des ressources
     */
    public List<Resource> findResourcesByName(String name) {
        try (Session session = getSession()) {
            String hql = "FROM Resource r WHERE lower(r.name) LIKE lower(:name)";
            Query<Resource> query = session.createQuery(hql, Resource.class);
            query.setParameter("name", "%" + name + "%");
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des ressources par nom", e);
        }
    }
}