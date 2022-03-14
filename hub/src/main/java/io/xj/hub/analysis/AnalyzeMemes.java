package io.xj.hub.analysis;

import com.google.api.client.util.Maps;
import com.google.api.client.util.Sets;
import io.xj.hub.client.HubContent;
import io.xj.lib.app.Environment;
import io.xj.lib.util.Text;

import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 Template content Analysis #161199945
 */
public class AnalyzeMemes extends Analyze {
  private final MemeHistogram memes;

  public AnalyzeMemes(HubContent content, Environment env) {
    super(content, env);

    memes = new MemeHistogram();
    content.getInstrumentMemes().forEach(meme -> memes.addInstrumentId(meme.getName(), meme.getInstrumentId()));
    content.getProgramMemes().forEach(meme -> memes.addProgramId(meme.getName(), meme.getProgramId()));
    content.getProgramSequenceBindingMemes().forEach(meme -> memes.addProgramId(meme.getName(), meme.getProgramId()));
  }

  @Override
  String toHTML() {
    return TABLE(TR(TD("Total"), TD("Name"), TD("Programs"), TD("Instruments")),
      memes.histogram.entrySet().stream()
        .sorted((c1, c2) -> c2.getValue().total.compareTo(c1.getValue().total))
        .map(e -> TR(
          TD(e.getValue().total.toString()),
          TD(e.getKey()),
          TD(e.getValue().programIds.stream().map(this::renderHtmlLinkToProgram).collect(Collectors.joining("\n"))),
          TD(e.getValue().instrumentIds.stream().map(this::renderHtmlLinkToInstrument).collect(Collectors.joining("\n")))
        ))
        .collect(Collectors.joining()));
  }

  @Override
  Type getType() {
    return Type.Memes;
  }

  /**
   Representation of the construction of a histogram of usage of all memes
   */
  private static class MemeHistogram {
    Map<String, MemeCount> histogram;

    public MemeHistogram() {
      histogram = Maps.newHashMap();
    }

    public void addInstrumentId(String raw, UUID instrumentId) {
      var name = Text.toMeme(raw);
      if (!histogram.containsKey(name)) histogram.put(name, new MemeCount());
      histogram.get(name).addInstrumentId(instrumentId);
    }

    public void addProgramId(String raw, UUID programId) {
      var name = Text.toMeme(raw);
      if (!histogram.containsKey(name)) histogram.put(name, new MemeCount());
      histogram.get(name).addProgramId(programId);
    }
  }

  /**
   Representation of the count of usages for one meme
   */
  private static class MemeCount {
    Set<UUID> programIds;
    Set<UUID> instrumentIds;
    Integer total;

    public MemeCount() {
      total = 0;
      programIds = Sets.newHashSet();
      instrumentIds = Sets.newHashSet();
    }

    public void addInstrumentId(UUID instrumentId) {
      instrumentIds.add(instrumentId);
      total++;
    }

    public void addProgramId(UUID programId) {
      programIds.add(programId);
      total++;
    }
  }

}
