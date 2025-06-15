package com.constructionxpert.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "resources")
public class Resource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    private Supplier supplier;

    @ManyToMany(mappedBy = "resources")
    private List<Task> tasks;

    // Constructeurs
    public Resource() {}

    public Resource(String name, String type, Integer quantity, Supplier supplier) {
        this.name = name;
        this.type = type;
        this.quantity = quantity;
        this.supplier = supplier;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }

    // Méthode pour mettre à jour la quantité après assignation
    public void updateQuantityAfterAssignment(int usedQuantity) {
        if (this.quantity >= usedQuantity) {
            this.quantity -= usedQuantity;
        } else {
            throw new IllegalArgumentException("Quantité insuffisante disponible");
        }
    }

    @Override
    public String toString() {
        return "Resource{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", quantity=" + quantity +
                ", supplier=" + (supplier != null ? supplier.getName() : "N/A") +
                '}';
    }
}