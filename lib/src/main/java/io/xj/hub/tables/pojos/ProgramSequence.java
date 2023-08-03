/*
 * This file is generated by jOOQ.
 */
package io.xj.hub.tables.pojos;


import io.xj.hub.tables.interfaces.IProgramSequence;

import java.util.UUID;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class ProgramSequence implements IProgramSequence {

    private static final long serialVersionUID = 1L;

    private UUID   id;
    private UUID   programId;
    private String name;
    private String key;
    private Float  density;
    private Short  total;

    public ProgramSequence() {}

    public ProgramSequence(IProgramSequence value) {
        this.id = value.getId();
        this.programId = value.getProgramId();
        this.name = value.getName();
        this.key = value.getKey();
        this.density = value.getDensity();
        this.total = value.getTotal();
    }

    public ProgramSequence(
        UUID   id,
        UUID   programId,
        String name,
        String key,
        Float  density,
        Short  total
    ) {
        this.id = id;
        this.programId = programId;
        this.name = name;
        this.key = key;
        this.density = density;
        this.total = total;
    }

    /**
     * Getter for <code>xj.program_sequence.id</code>.
     */
    @Override
    public UUID getId() {
        return this.id;
    }

    /**
     * Setter for <code>xj.program_sequence.id</code>.
     */
    @Override
    public void setId(UUID id) {
        this.id = id;
    }

    /**
     * Getter for <code>xj.program_sequence.program_id</code>.
     */
    @Override
    public UUID getProgramId() {
        return this.programId;
    }

    /**
     * Setter for <code>xj.program_sequence.program_id</code>.
     */
    @Override
    public void setProgramId(UUID programId) {
        this.programId = programId;
    }

    /**
     * Getter for <code>xj.program_sequence.name</code>.
     */
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * Setter for <code>xj.program_sequence.name</code>.
     */
    @Override
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Getter for <code>xj.program_sequence.key</code>.
     */
    @Override
    public String getKey() {
        return this.key;
    }

    /**
     * Setter for <code>xj.program_sequence.key</code>.
     */
    @Override
    public void setKey(String key) {
        this.key = key;
    }

    /**
     * Getter for <code>xj.program_sequence.density</code>.
     */
    @Override
    public Float getDensity() {
        return this.density;
    }

    /**
     * Setter for <code>xj.program_sequence.density</code>.
     */
    @Override
    public void setDensity(Float density) {
        this.density = density;
    }

    /**
     * Getter for <code>xj.program_sequence.total</code>.
     */
    @Override
    public Short getTotal() {
        return this.total;
    }

    /**
     * Setter for <code>xj.program_sequence.total</code>.
     */
    @Override
    public void setTotal(Short total) {
        this.total = total;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("ProgramSequence (");

        sb.append(id);
        sb.append(", ").append(programId);
        sb.append(", ").append(name);
        sb.append(", ").append(key);
        sb.append(", ").append(density);
        sb.append(", ").append(total);

        sb.append(")");
        return sb.toString();
    }

    // -------------------------------------------------------------------------
    // FROM and INTO
    // -------------------------------------------------------------------------

    @Override
    public void from(IProgramSequence from) {
        setId(from.getId());
        setProgramId(from.getProgramId());
        setName(from.getName());
        setKey(from.getKey());
        setDensity(from.getDensity());
        setTotal(from.getTotal());
    }

    @Override
    public <E extends IProgramSequence> E into(E into) {
        into.from(this);
        return into;
    }
}