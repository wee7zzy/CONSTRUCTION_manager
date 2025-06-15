package com.constructionxpert.dao;

import com.constructionxpert.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Optional;

public abstract class AbstractDAO<T> implements GenericDAO<T> {

    private final Class<T> entityClass;

    @SuppressWarnings("unchecked")
    protected AbstractDAO() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
    }

    protected Session getSession() {
        return HibernateUtil.getSessionFactory().getCurrentSession();
    }

    @Override
    public T save(T entity) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            session.save(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de l'entité", e);
        }
    }

    @Override
    public T update(T entity) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            session.update(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de l'entité", e);
        }
    }

    @Override
    public boolean delete(Long id) {
        Transaction transaction = null;
        try (Session session = getSession()) {
            transaction = session.beginTransaction();
            T entity = session.get(entityClass, id);
            if (entity != null) {
                session.delete(entity);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de l'entité", e);
        }
    }

    @Override
    public Optional<T> findById(Long id) {
        try (Session session = getSession()) {
            return Optional.ofNullable(session.get(entityClass, id));
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de l'entité", e);
        }
    }

    @Override
    public List<T> findAll() {
        try (Session session = getSession()) {
            return session.createQuery("from " + entityClass.getName(), entityClass).list();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération de toutes les entités", e);
        }
    }

    @Override
    public boolean exists(Long id) {
        try (Session session = getSession()) {
            T entity = session.get(entityClass, id);
            return entity != null;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification de l'existence de l'entité", e);
        }
    }
}