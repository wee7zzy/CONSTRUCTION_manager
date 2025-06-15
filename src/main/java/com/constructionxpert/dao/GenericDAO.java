package com.constructionxpert.dao;

import java.util.List;
import java.util.Optional;

public interface GenericDAO<T> {
    /**
     * Sauvegarde une entité
     * @param entity l'entité à sauvegarder
     * @return l'entité sauvegardée
     */
    T save(T entity);

    /**
     * Met à jour une entité
     * @param entity l'entité à mettre à jour
     * @return l'entité mise à jour
     */
    T update(T entity);

    /**
     * Supprime une entité
     * @param id l'identifiant de l'entité à supprimer
     * @return true si la suppression a réussi, false sinon
     */
    boolean delete(Long id);

    /**
     * Trouve une entité par son identifiant
     * @param id l'identifiant de l'entité
     * @return Optional contenant l'entité si trouvée
     */
    Optional<T> findById(Long id);

    /**
     * Récupère toutes les entités
     * @return la liste des entités
     */
    List<T> findAll();

    /**
     * Vérifie si une entité existe
     * @param id l'identifiant de l'entité
     * @return true si l'entité existe, false sinon
     */
    boolean exists(Long id);
}