package com.constructionxpert.dao;

import com.constructionxpert.models.Admin;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class AdminDAO extends AbstractDAO<Admin> {

    /**
     * Trouve un administrateur par son nom d'utilisateur
     * @param username le nom d'utilisateur
     * @return l'administrateur correspondant ou null
     */
    public Admin findByUsername(String username) {
        try (Session session = getSession()) {
            String hql = "FROM Admin a WHERE a.username = :username";
            Query<Admin> query = session.createQuery(hql, Admin.class);
            query.setParameter("username", username);
            return query.uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de l'administrateur par nom d'utilisateur", e);
        }
    }

    /**
     * Vérifie si un nom d'utilisateur existe déjà
     * @param username le nom d'utilisateur à vérifier
     * @return true si le nom d'utilisateur existe déjà, false sinon
     */
    public boolean isUsernameExists(String username) {
        try (Session session = getSession()) {
            String hql = "SELECT COUNT(a) FROM Admin a WHERE a.username = :username";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("username", username);
            return query.uniqueResult() > 0;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification du nom d'utilisateur", e);
        }
    }

    /**
     * Vérifie si un email existe déjà
     * @param email l'email à vérifier
     * @return true si l'email existe déjà, false sinon
     */
    public boolean isEmailExists(String email) {
        try (Session session = getSession()) {
            String hql = "SELECT COUNT(a) FROM Admin a WHERE a.email = :email";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("email", email);
            return query.uniqueResult() > 0;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification de l'email", e);
        }
    }

    /**
     * Authentifie un administrateur
     * @param username le nom d'utilisateur
     * @param password le mot de passe
     * @return l'administrateur si l'authentification réussit, null sinon
     */
    public Admin authenticate(String username, String password) {
        try (Session session = getSession()) {
            Admin admin = findByUsername(username);
            if (admin != null && admin.checkPassword(password)) {
                return admin;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de l'authentification", e);
        }
    }

    /**
     * Met à jour le mot de passe d'un administrateur
     * @param adminId l'ID de l'administrateur
     * @param newPassword le nouveau mot de passe
     * @return true si la mise à jour a réussi, false sinon
     */
    public boolean updatePassword(Long adminId, String newPassword) {
        try (Session session = getSession()) {
            Admin admin = session.get(Admin.class, adminId);
            if (admin != null) {
                admin.setPassword(newPassword);
                session.beginTransaction();
                session.update(admin);
                session.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la mise à jour du mot de passe", e);
        }
    }
}