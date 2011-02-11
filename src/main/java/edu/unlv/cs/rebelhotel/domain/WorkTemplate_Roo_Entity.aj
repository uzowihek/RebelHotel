// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package edu.unlv.cs.rebelhotel.domain;

import edu.unlv.cs.rebelhotel.domain.WorkTemplate;
import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect WorkTemplate_Roo_Entity {
    
    declare @type: WorkTemplate: @Entity;
    
    @PersistenceContext
    transient EntityManager WorkTemplate.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long WorkTemplate.id;
    
    @Version
    @Column(name = "version")
    private Integer WorkTemplate.version;
    
    public Long WorkTemplate.getId() {
        return this.id;
    }
    
    public void WorkTemplate.setId(Long id) {
        this.id = id;
    }
    
    public Integer WorkTemplate.getVersion() {
        return this.version;
    }
    
    public void WorkTemplate.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void WorkTemplate.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void WorkTemplate.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            WorkTemplate attached = WorkTemplate.findWorkTemplate(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void WorkTemplate.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public WorkTemplate WorkTemplate.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        WorkTemplate merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager WorkTemplate.entityManager() {
        EntityManager em = new WorkTemplate().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long WorkTemplate.countWorkTemplates() {
        return entityManager().createQuery("select count(o) from WorkTemplate o", Long.class).getSingleResult();
    }
    
    public static List<WorkTemplate> WorkTemplate.findAllWorkTemplates() {
        return entityManager().createQuery("select o from WorkTemplate o", WorkTemplate.class).getResultList();
    }
    
    public static WorkTemplate WorkTemplate.findWorkTemplate(Long id) {
        if (id == null) return null;
        return entityManager().find(WorkTemplate.class, id);
    }
    
    public static List<WorkTemplate> WorkTemplate.findWorkTemplateEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from WorkTemplate o", WorkTemplate.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
