// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.entity;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import javax.annotation.Nullable;
import java.math.BigInteger;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 EntityRank is a collection of one type of Entity (e.g. Sequence or Instrument),
 stored in a HashMap using its id as an index.
 <p>
 A separate quality-score (Q-score) index uses the entity id as an index
 for a double that represents that entity's score.

 @param <T>  */
public class EntityRank<T extends Entity> {
  //  final TypeToken<T> type = new TypeToken<T>(getClass()) {};
  private final List<T> entities;
  private final HashMap<BigInteger, Double> scores;

  /**
   Constructor instantiates a new inner hash map
   */
  public EntityRank() {
    entities = Lists.newArrayList();
    scores = Maps.newHashMap();
  }

  /**
   Add an entity

   @param entity to add
   */
  public void add(T entity) {
    entities.add(entity);
  }

  /**
   Add many entities

   @param entities to add
   */
  public void addAll(Collection<T> entities) {
    this.entities.addAll(entities);
  }

  /**
   Add an entity, with a Q-score

   @param entity to add
   */
  public void add(T entity, double Q) {
    add(entity);
    score(entity, Q);
  }

  /**
   Set the Q-score for an entity

   @param entity to add
   */
  public void score(T entity, Double Q) {
    score(entity.getId(), Q);
  }

  /**
   Set the Q-score by entity id

   @param entityId to add
   */
  public void score(BigInteger entityId, Double Q) {
    if (scores.containsKey(entityId))
      scores.put(entityId, scores.get(entityId) + Q);
    else
      scores.put(entityId, Q);
  }

  /**
   Get a collection of all the stored entities

   @return all entities
   */
  public List<T> getAll() {
    return Collections.unmodifiableList(entities);
  }

  /**
   Get a collection of all the stored entities

   @return all entities
   */
  public Map<BigInteger, Double> getScores() {
    return Collections.unmodifiableMap(scores);
  }

  /**
   Get the top entity by Q-score

   @return T
   */
  @Nullable
  public T getTop() {
    List<T> allScored = getAllScored();
    if (Objects.nonNull(allScored) && 1 <= allScored.size())
      return allScored.get(0);
    else
      return null;
  }

  /**
   Get the top entities by Q-score

   @param total quantity to return
   @return T
   */
  public List<T> getScored(int total) {
    return getAllScored().subList(0, total);
  }

  /**
   Get all entities sorted by Q-score

   @return T
   */
  public List<T> getAllScored() {
    entities.sort(
      Comparator.comparing(
        e -> {
          Double score = scores.get(e.getId());
          if (Objects.nonNull(score))
            return -score;
          else
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
    String name = entities.get(0).getClass().getSimpleName();
    List<String> reports = Lists.newArrayList();
    scores.forEach((id, score) -> reports.add(String.format("%s:%f", id, score)));
    return "(" + name + ") " + String.join(", ", reports);
  }
}