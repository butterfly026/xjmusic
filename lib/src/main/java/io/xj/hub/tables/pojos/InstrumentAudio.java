/*
 * This file is generated by jOOQ.
 */
package io.xj.hub.tables.pojos;


import io.xj.hub.tables.interfaces.IInstrumentAudio;

import java.util.UUID;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class InstrumentAudio implements IInstrumentAudio {

    private static final long serialVersionUID = 1L;

    private UUID   id;
    private UUID   instrumentId;
    private String name;
    private String waveformKey;
    private Float  transientSeconds;
    private Float  totalBeats;
    private Float  tempo;
    private Float  density;
    private String event;
    private Float  volume;
    private String tones;

    public InstrumentAudio() {}

    public InstrumentAudio(IInstrumentAudio value) {
        this.id = value.getId();
        this.instrumentId = value.getInstrumentId();
        this.name = value.getName();
        this.waveformKey = value.getWaveformKey();
        this.transientSeconds = value.getTransientSeconds();
        this.totalBeats = value.getTotalBeats();
        this.tempo = value.getTempo();
        this.density = value.getDensity();
        this.event = value.getEvent();
        this.volume = value.getVolume();
        this.tones = value.getTones();
    }

    public InstrumentAudio(
        UUID   id,
        UUID   instrumentId,
        String name,
        String waveformKey,
        Float  transientSeconds,
        Float  totalBeats,
        Float  tempo,
        Float  density,
        String event,
        Float  volume,
        String tones
    ) {
        this.id = id;
        this.instrumentId = instrumentId;
        this.name = name;
        this.waveformKey = waveformKey;
        this.transientSeconds = transientSeconds;
        this.totalBeats = totalBeats;
        this.tempo = tempo;
        this.density = density;
        this.event = event;
        this.volume = volume;
        this.tones = tones;
    }

    /**
     * Getter for <code>xj.instrument_audio.id</code>.
     */
    @Override
    public UUID getId() {
        return this.id;
    }

    /**
     * Setter for <code>xj.instrument_audio.id</code>.
     */
    @Override
    public void setId(UUID id) {
        this.id = id;
    }

    /**
     * Getter for <code>xj.instrument_audio.instrument_id</code>.
     */
    @Override
    public UUID getInstrumentId() {
        return this.instrumentId;
    }

    /**
     * Setter for <code>xj.instrument_audio.instrument_id</code>.
     */
    @Override
    public void setInstrumentId(UUID instrumentId) {
        this.instrumentId = instrumentId;
    }

    /**
     * Getter for <code>xj.instrument_audio.name</code>.
     */
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * Setter for <code>xj.instrument_audio.name</code>.
     */
    @Override
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Getter for <code>xj.instrument_audio.waveform_key</code>.
     */
    @Override
    public String getWaveformKey() {
        return this.waveformKey;
    }

    /**
     * Setter for <code>xj.instrument_audio.waveform_key</code>.
     */
    @Override
    public void setWaveformKey(String waveformKey) {
        this.waveformKey = waveformKey;
    }

    /**
     * Getter for <code>xj.instrument_audio.transient_seconds</code>.
     */
    @Override
    public Float getTransientSeconds() {
        return this.transientSeconds;
    }

    /**
     * Setter for <code>xj.instrument_audio.transient_seconds</code>.
     */
    @Override
    public void setTransientSeconds(Float transientSeconds) {
        this.transientSeconds = transientSeconds;
    }

    /**
     * Getter for <code>xj.instrument_audio.total_beats</code>.
     */
    @Override
    public Float getTotalBeats() {
        return this.totalBeats;
    }

    /**
     * Setter for <code>xj.instrument_audio.total_beats</code>.
     */
    @Override
    public void setTotalBeats(Float totalBeats) {
        this.totalBeats = totalBeats;
    }

    /**
     * Getter for <code>xj.instrument_audio.tempo</code>.
     */
    @Override
    public Float getTempo() {
        return this.tempo;
    }

    /**
     * Setter for <code>xj.instrument_audio.tempo</code>.
     */
    @Override
    public void setTempo(Float tempo) {
        this.tempo = tempo;
    }

    /**
     * Getter for <code>xj.instrument_audio.density</code>.
     */
    @Override
    public Float getDensity() {
        return this.density;
    }

    /**
     * Setter for <code>xj.instrument_audio.density</code>.
     */
    @Override
    public void setDensity(Float density) {
        this.density = density;
    }

    /**
     * Getter for <code>xj.instrument_audio.event</code>.
     */
    @Override
    public String getEvent() {
        return this.event;
    }

    /**
     * Setter for <code>xj.instrument_audio.event</code>.
     */
    @Override
    public void setEvent(String event) {
        this.event = event;
    }

    /**
     * Getter for <code>xj.instrument_audio.volume</code>.
     */
    @Override
    public Float getVolume() {
        return this.volume;
    }

    /**
     * Setter for <code>xj.instrument_audio.volume</code>.
     */
    @Override
    public void setVolume(Float volume) {
        this.volume = volume;
    }

    /**
     * Getter for <code>xj.instrument_audio.tones</code>.
     */
    @Override
    public String getTones() {
        return this.tones;
    }

    /**
     * Setter for <code>xj.instrument_audio.tones</code>.
     */
    @Override
    public void setTones(String tones) {
        this.tones = tones;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("InstrumentAudio (");

        sb.append(id);
        sb.append(", ").append(instrumentId);
        sb.append(", ").append(name);
        sb.append(", ").append(waveformKey);
        sb.append(", ").append(transientSeconds);
        sb.append(", ").append(totalBeats);
        sb.append(", ").append(tempo);
        sb.append(", ").append(density);
        sb.append(", ").append(event);
        sb.append(", ").append(volume);
        sb.append(", ").append(tones);

        sb.append(")");
        return sb.toString();
    }

    // -------------------------------------------------------------------------
    // FROM and INTO
    // -------------------------------------------------------------------------

    @Override
    public void from(IInstrumentAudio from) {
        setId(from.getId());
        setInstrumentId(from.getInstrumentId());
        setName(from.getName());
        setWaveformKey(from.getWaveformKey());
        setTransientSeconds(from.getTransientSeconds());
        setTotalBeats(from.getTotalBeats());
        setTempo(from.getTempo());
        setDensity(from.getDensity());
        setEvent(from.getEvent());
        setVolume(from.getVolume());
        setTones(from.getTones());
    }

    @Override
    public <E extends IInstrumentAudio> E into(E into) {
        into.from(this);
        return into;
    }
}