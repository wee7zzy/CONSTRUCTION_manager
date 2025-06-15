package com.constructionxpert.services;

import com.constructionxpert.dao.AdminDAO;
import com.constructionxpert.models.Admin;

public class AuthenticationService {
    private final AdminDAO adminDAO;

    public AuthenticationService() {
        this.adminDAO = new AdminDAO();
    }

    /**
     * Authentifie un administrateur
     * @param username nom d'utilisateur
     * @param password mot de passe
     * @return l'administrateur si l'authentification réussit, null sinon
     */
    public Admin login(String username, String password) {
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }

        return adminDAO.authenticate(username.trim(), password);
    }

    /**
     * Crée un nouvel administrateur
     * @param username nom d'utilisateur
     * @param password mot de passe
     * @param email email
     * @param fullName nom complet
     * @return l'administrateur créé
     * @throws IllegalArgumentException si les données sont invalides
     */
    public Admin createAdmin(String username, String password, String email, String fullName) {
        // Validation des données
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom d'utilisateur est requis");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Le mot de passe est requis");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("L'email est invalide");
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom complet est requis");
        }

        // Vérification de l'unicité
        if (adminDAO.isUsernameExists(username)) {
            throw new IllegalArgumentException("Ce nom d'utilisateur existe déjà");
        }
        if (adminDAO.isEmailExists(email)) {
            throw new IllegalArgumentException("Cet email existe déjà");
        }

        // Création de l'administrateur
        Admin admin = new Admin(username, password, email, fullName);
        return adminDAO.save(admin);
    }

    /**
     * Change le mot de passe d'un administrateur
     * @param adminId ID de l'administrateur
     * @param currentPassword mot de passe actuel
     * @param newPassword nouveau mot de passe
     * @return true si le changement a réussi, false sinon
     */
    public boolean changePassword(Long adminId, String currentPassword, String newPassword) {
        if (adminId == null || currentPassword == null || newPassword == null) {
            return false;
        }

        Admin admin = adminDAO.findById(adminId).orElse(null);
        if (admin == null || !admin.checkPassword(currentPassword)) {
            return false;
        }

        return adminDAO.updatePassword(adminId, newPassword);
    }

    /**
     * Met à jour les informations d'un administrateur
     * @param admin l'administrateur à mettre à jour
     * @return l'administrateur mis à jour
     */
    public Admin updateAdmin(Admin admin) {
        if (admin == null || admin.getId() == null) {
            throw new IllegalArgumentException("Données d'administrateur invalides");
        }

        Admin existingAdmin = adminDAO.findById(admin.getId())
                .orElseThrow(() -> new IllegalArgumentException("Administrateur non trouvé"));

        // Vérification de l'unicité de l'email si modifié
        if (!existingAdmin.getEmail().equals(admin.getEmail()) && adminDAO.isEmailExists(admin.getEmail())) {
            throw new IllegalArgumentException("Cet email existe déjà");
        }

        return adminDAO.update(admin);
    }
}