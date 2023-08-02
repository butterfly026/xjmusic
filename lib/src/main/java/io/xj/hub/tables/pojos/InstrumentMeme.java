/*
 * This file is generated by jOOQ.
 */
package io.xj.hub.tables.pojos;


import io.xj.hub.tables.interfaces.IInstrumentMeme;

import java.util.UUID;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class InstrumentMeme implements IInstrumentMeme {

    private static final long serialVersionUID = 1L;

    private UUID   id;
    private UUID   instrumentId;
    private String name;

    public InstrumentMeme() {}

    public InstrumentMeme(IInstrumentMeme value) {
        this.id = value.getId();
        this.instrumentId = value.getInstrumentId();
        this.name = value.getName();
    }

    public InstrumentMeme(
        UUID   id,
        UUID   instrumentId,
        String name
    ) {
        this.id = id;
        this.instrumentId = instrumentId;
        this.name = name;
    }

    /**
     * Getter for <code>xj.instrument_meme.id</code>.
     */
    @Override
    public UUID getId() {
        return this.id;
    }

    /**
     * Setter for <code>xj.instrument_meme.id</code>.
     */
    @Override
    public void setId(UUID id) {
        this.id = id;
    }

    /**
     * Getter for <code>xj.instrument_meme.instrument_id</code>.
     */
    @Override
    public UUID getInstrumentId() {
        return this.instrumentId;
    }

    /**
     * Setter for <code>xj.instrument_meme.instrument_id</code>.
     */
    @Override
    public void setInstrumentId(UUID instrumentId) {
        this.instrumentId = instrumentId;
    }

    /**
     * Getter for <code>xj.instrument_meme.name</code>.
     */
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * Setter for <code>xj.instrument_meme.name</code>.
     */
    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("InstrumentMeme (");

        sb.append(id);
        sb.append(", ").append(instrumentId);
        sb.append(", ").append(name);

        sb.append(")");
        return sb.toString();
    }

    // -------------------------------------------------------------------------
    // FROM and INTO
    // -------------------------------------------------------------------------

    @Override
    public void from(IInstrumentMeme from) {
        setId(from.getId());
        setInstrumentId(from.getInstrumentId());
        setName(from.getName());
    }

    @Override
    public <E extends IInstrumentMeme> E into(E into) {
        into.from(this);
        return into;
    }
}
