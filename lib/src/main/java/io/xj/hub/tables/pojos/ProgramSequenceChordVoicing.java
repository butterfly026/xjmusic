/*
 * This file is generated by jOOQ.
 */
package io.xj.hub.tables.pojos;


import io.xj.hub.tables.interfaces.IProgramSequenceChordVoicing;

import java.util.UUID;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class ProgramSequenceChordVoicing implements IProgramSequenceChordVoicing {

    private static final long serialVersionUID = 1L;

    private UUID   id;
    private UUID   programId;
    private UUID   programSequenceChordId;
    private String notes;
    private UUID   programVoiceId;

    public ProgramSequenceChordVoicing() {}

    public ProgramSequenceChordVoicing(IProgramSequenceChordVoicing value) {
        this.id = value.getId();
        this.programId = value.getProgramId();
        this.programSequenceChordId = value.getProgramSequenceChordId();
        this.notes = value.getNotes();
        this.programVoiceId = value.getProgramVoiceId();
    }

    public ProgramSequenceChordVoicing(
        UUID   id,
        UUID   programId,
        UUID   programSequenceChordId,
        String notes,
        UUID   programVoiceId
    ) {
        this.id = id;
        this.programId = programId;
        this.programSequenceChordId = programSequenceChordId;
        this.notes = notes;
        this.programVoiceId = programVoiceId;
    }

    /**
     * Getter for <code>xj.program_sequence_chord_voicing.id</code>.
     */
    @Override
    public UUID getId() {
        return this.id;
    }

    /**
     * Setter for <code>xj.program_sequence_chord_voicing.id</code>.
     */
    @Override
    public void setId(UUID id) {
        this.id = id;
    }

    /**
     * Getter for <code>xj.program_sequence_chord_voicing.program_id</code>.
     */
    @Override
    public UUID getProgramId() {
        return this.programId;
    }

    /**
     * Setter for <code>xj.program_sequence_chord_voicing.program_id</code>.
     */
    @Override
    public void setProgramId(UUID programId) {
        this.programId = programId;
    }

    /**
     * Getter for
     * <code>xj.program_sequence_chord_voicing.program_sequence_chord_id</code>.
     */
    @Override
    public UUID getProgramSequenceChordId() {
        return this.programSequenceChordId;
    }

    /**
     * Setter for
     * <code>xj.program_sequence_chord_voicing.program_sequence_chord_id</code>.
     */
    @Override
    public void setProgramSequenceChordId(UUID programSequenceChordId) {
        this.programSequenceChordId = programSequenceChordId;
    }

    /**
     * Getter for <code>xj.program_sequence_chord_voicing.notes</code>.
     */
    @Override
    public String getNotes() {
        return this.notes;
    }

    /**
     * Setter for <code>xj.program_sequence_chord_voicing.notes</code>.
     */
    @Override
    public void setNotes(String notes) {
        this.notes = notes;
    }

    /**
     * Getter for
     * <code>xj.program_sequence_chord_voicing.program_voice_id</code>.
     */
    @Override
    public UUID getProgramVoiceId() {
        return this.programVoiceId;
    }

    /**
     * Setter for
     * <code>xj.program_sequence_chord_voicing.program_voice_id</code>.
     */
    @Override
    public void setProgramVoiceId(UUID programVoiceId) {
        this.programVoiceId = programVoiceId;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("ProgramSequenceChordVoicing (");

        sb.append(id);
        sb.append(", ").append(programId);
        sb.append(", ").append(programSequenceChordId);
        sb.append(", ").append(notes);
        sb.append(", ").append(programVoiceId);

        sb.append(")");
        return sb.toString();
    }

    // -------------------------------------------------------------------------
    // FROM and INTO
    // -------------------------------------------------------------------------

    @Override
    public void from(IProgramSequenceChordVoicing from) {
        setId(from.getId());
        setProgramId(from.getProgramId());
        setProgramSequenceChordId(from.getProgramSequenceChordId());
        setNotes(from.getNotes());
        setProgramVoiceId(from.getProgramVoiceId());
    }

    @Override
    public <E extends IProgramSequenceChordVoicing> E into(E into) {
        into.from(this);
        return into;
    }
}