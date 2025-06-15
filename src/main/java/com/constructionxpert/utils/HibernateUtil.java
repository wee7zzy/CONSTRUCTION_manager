package com.constructionxpert.utils;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;

import com.constructionxpert.models.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();

                // Charger les propriétés de la base de données
                Properties dbProperties = new Properties();
                InputStream inputStream = HibernateUtil.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

                if (inputStream == null) {
                    throw new RuntimeException("Le fichier db.properties est introuvable");
                }

                dbProperties.load(inputStream);

                // Appliquer les propriétés Hibernate
                Properties settings = new Properties();
                settings.put(Environment.DRIVER, dbProperties.getProperty("db.driver"));
                settings.put(Environment.URL, dbProperties.getProperty("db.url"));
                settings.put(Environment.USER, dbProperties.getProperty("db.username"));
                settings.put(Environment.PASS, dbProperties.getProperty("db.password"));
                settings.put(Environment.DIALECT, dbProperties.getProperty("hibernate.dialect"));
                settings.put(Environment.SHOW_SQL, dbProperties.getProperty("hibernate.show_sql"));
                settings.put(Environment.HBM2DDL_AUTO, dbProperties.getProperty("hibernate.hbm2ddl.auto"));
                settings.put(Environment.FORMAT_SQL, dbProperties.getProperty("hibernate.format_sql"));
                settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, 
                    dbProperties.getProperty("hibernate.current_session_context_class"));

                configuration.setProperties(settings);

                // Ajouter les classes annotées
                configuration.addAnnotatedClass(Project.class);
                configuration.addAnnotatedClass(Task.class);
                configuration.addAnnotatedClass(Resource.class);
                configuration.addAnnotatedClass(Supplier.class);
                configuration.addAnnotatedClass(Admin.class);

                sessionFactory = configuration.buildSessionFactory();

            } catch (IOException e) {
                throw new RuntimeException("Erreur lors du chargement des propriétés de la base de données", e);
            } catch (Exception e) {
                throw new RuntimeException("Erreur lors de la création de SessionFactory", e);
            }
        }
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}