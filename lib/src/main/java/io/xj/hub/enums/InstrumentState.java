/*
 * This file is generated by jOOQ.
 */
package io.xj.hub.enums;


import io.xj.hub.Xj;
import org.jooq.Catalog;
import org.jooq.EnumType;
import org.jooq.Schema;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public enum InstrumentState implements EnumType {

    Draft("Draft"),

    Published("Published");

    private final String literal;

    private InstrumentState(String literal) {
        this.literal = literal;
    }

    @Override
    public Catalog getCatalog() {
        return getSchema().getCatalog();
    }

    @Override
    public Schema getSchema() {
        return Xj.XJ;
    }

    @Override
    public String getName() {
        return "instrument_state";
    }

    @Override
    public String getLiteral() {
        return literal;
    }
}
