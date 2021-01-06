// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.fabricator;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityException;
import io.xj.lib.util.Text;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 EntityScorePicker is a collection of one type of Entity (e.g. Instrument or Program),
 stored in a HashMap using its id as an index.
 <p>
 A separate quality-score (Q-score) index uses the entity id as an index
 for a double that represents that entity's score.

 @param <E>  */
public class EntityScorePicker<E> {
  private static final Logger log = LoggerFactory.getLogger(EntityScorePicker.class);
  private final List<E> entities;
  private final HashMap<String, Double> scores;

  /**
   Constructor instantiates a new inner hash map
   */
  public EntityScorePicker() {
    entities = Lists.newArrayList();
    scores = Maps.newHashMap();
  }

  /**
   Add an entity

   @param entity to add
   */
  public void add(E entity) {
    entities.add(entity);
  }

  /**
   Add many entities

   @param entities to add
   */
  public void addAll(Collection<E> entities) {
    this.entities.addAll(entities);
  }

  /**
   Add an entity, with a Q-score

   @param entity to add
   */
  public void add(E entity, double Q) {
    add(entity);
    score(entity, Q);
  }

  /**
   Set the Q-score for an entity

   @param entity to add
   */
  public void score(E entity, Double Q) {
    try {
      score(Entities.getId(entity), Q);
    } catch (EntityException e) {
      log.warn("could not score {}={}", entity, Q, e);
    }
  }

  /**
   Set the Q-score by entity id

   @param entityId to add
   */
  public void score(String entityId, Double Q) {
    if (scores.containsKey(entityId))
      scores.put(entityId, scores.get(entityId) + Q);
    else
      scores.put(entityId, Q);
  }

  /**
   Get a collection of all the stored entities

   @return all entities
   */
  public List<E> getAll() {
    return Collections.unmodifiableList(entities);
  }

  /**
   Get a collection of all the stored entities

   @return all entities
   */
  public Map<String, Double> getScores() {
    return Collections.unmodifiableMap(scores);
  }

  /**
   Get the top entity by Q-score

   @return T
   */
  public E getTop() throws FabricationException {
    List<E> allScored = getAllScored();
    if (Objects.nonNull(allScored) && 1 <= allScored.size())
      return allScored.get(0);

    throw new FabricationException("Cannot rank zero entities");
  }

  /**
   Get the top entities by Q-score

   @param total quantity to return
   @return T
   */
  public List<E> getScored(int total) {
    return getAllScored().subList(0, total);
  }

  /**
   Get all entities sorted by Q-score

   @return T
   */
  public List<E> getAllScored() {
    entities.sort(
      Comparator.comparing(
        e -> {
          try {
            Double score = scores.get(Entities.getId(e));
            if (Objects.nonNull(score))
              return -score;
          } catch (EntityException ignored) {
          }
          return 0.0d;
        })
    );
    return Collections.unmodifiableList(entities);
  }

  /**
   Total number of entities stored

   @return total number of entities
   */
  public int size() {
    return entities.size();
  }

  /**
   assemble report of choices and scores

   @return report
   */
  public String report() {
    if (Objects.isNull(entities) || entities.isEmpty())
      return "(empty)";
    String name = Text.getSimpleName(entities.get(0));
    List<String> reports = Lists.newArrayList();
    scores.forEach((id, score) -> reports.add(String.format("%s:%f", id, score)));
    return "(" + name + ") " + String.join(", ", reports);
  }
}