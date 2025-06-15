package com.constructionxpert.dao;

import com.constructionxpert.models.Supplier;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class SupplierDAO extends AbstractDAO<Supplier> {

    /**
     * Trouve un fournisseur par son email
     * @param email l'email du fournisseur
     * @return le fournisseur correspondant ou null
     */
    public Supplier findByEmail(String email) {
        try (Session session = getSession()) {
            String hql = "FROM Supplier s WHERE s.email = :email";
            Query<Supplier> query = session.createQuery(hql, Supplier.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche du fournisseur par email", e);
        }
    }

    /**
     * Trouve les fournisseurs par nom (recherche partielle)
     * @param name le nom à rechercher
     * @return liste des fournisseurs
     */
    public List<Supplier> findSuppliersByName(String name) {
        try (Session session = getSession()) {
            String hql = "FROM Supplier s WHERE lower(s.name) LIKE lower(:name)";
            Query<Supplier> query = session.createQuery(hql, Supplier.class);
            query.setParameter("name", "%" + name + "%");
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des fournisseurs par nom", e);
        }
    }

    /**
     * Vérifie si un email est déjà utilisé
     * @param email l'email à vérifier
     * @return true si l'email existe déjà, false sinon
     */
    public boolean isEmailExists(String email) {
        try (Session session = getSession()) {
            String hql = "SELECT COUNT(s) FROM Supplier s WHERE s.email = :email";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("email", email);
            return query.uniqueResult() > 0;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification de l'email", e);
        }
    }

    /**
     * Trouve les fournisseurs par numéro de téléphone
     * @param phoneNumber le numéro de téléphone
     * @return liste des fournisseurs
     */
    public List<Supplier> findSuppliersByPhoneNumber(String phoneNumber) {
        try (Session session = getSession()) {
            String hql = "FROM Supplier s WHERE s.phoneNumber = :phoneNumber";
            Query<Supplier> query = session.createQuery(hql, Supplier.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des fournisseurs par numéro de téléphone", e);
        }
    }

    /**
     * Trouve les fournisseurs par adresse (recherche partielle)
     * @param address l'adresse à rechercher
     * @return liste des fournisseurs
     */
    public List<Supplier> findSuppliersByAddress(String address) {
        try (Session session = getSession()) {
            String hql = "FROM Supplier s WHERE lower(s.address) LIKE lower(:address)";
            Query<Supplier> query = session.createQuery(hql, Supplier.class);
            query.setParameter("address", "%" + address + "%");
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des fournisseurs par adresse", e);
        }
    }
}