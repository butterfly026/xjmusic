// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.music;

import com.google.api.client.util.Strings;
import io.xj.lib.util.Text;

import java.util.Objects;
import java.util.regex.Pattern;

/**
 Root can be the root of a Chord, Key or Scale.
 */
public class SlashRoot {
  private static final Pattern rgxSlashPost = Pattern.compile("[^/]*/([A-G♯#♭b]+)$");
  private static final Pattern rgxSlashNote = Pattern.compile("/([A-G])$");
  private static final Pattern rgxSlashNoteModified = Pattern.compile("/([A-G][♯#♭b])$");
  private static final Pattern rgxSlashPre = Pattern.compile("^([^/]*)/");
  private static final String SLASH = "/";
  private static final String EMPTY = "";
  private final PitchClass pitchClass;
  private final String pre;
  private final String post;

  /**
   Parse slash root string, using regular expressions

   @param name to parse slash root
   */
  private SlashRoot(String name) {
    post = Text.match(rgxSlashPost, name).orElse(EMPTY);
    pre = Strings.isNullOrEmpty(post) ? name : Text.match(rgxSlashPre, name).orElse(EMPTY);
    pitchClass =
      Text.match(rgxSlashNoteModified, name)
        .map(PitchClass::of)
        .orElse(Text.match(rgxSlashNote, name)
          .map(PitchClass::of)
          .orElse(PitchClass.None));
  }

  /**
   Instantiate a Root by name
   <p>
   XJ understands the root of a slash chord https://www.pivotaltracker.com/story/show/176728338

   @param name of root
   @return root
   */
  public static SlashRoot of(String name) {
    return new SlashRoot(name);
  }

  public static SlashRoot none() {
    return new SlashRoot("");
  }

  /**
   Get pitch class of root

   @return root pitch class
   */
  public PitchClass getPitchClass() {
    return pitchClass;
  }

  public PitchClass orDefault(PitchClass dpc) {
    if (pitchClass.equals(PitchClass.None)) return dpc;
    return pitchClass;
  }

  /**
   Returns the pre-slash content, or whole string if no slash is present

   @param description to search for pre-slash content
   */
  public static String pre(String description) {
    if (Strings.isNullOrEmpty(description)) return "";
    if (Objects.equals(SLASH, description.substring(0, 1))) return "";
    return Text.match(rgxSlashPre, description).orElse(description);
  }

  /**
   Return true if a slash is present in the given chord name

   @param name to test for slash
   @return true if slash is found
   */
  public static boolean isPresent(String name) {
    return rgxSlashPost.matcher(name).find();
  }

  /**
   @return true if any slash info is present
   */
  public boolean isPresent() {
    return !Strings.isNullOrEmpty(post);
  }

  /**
   @return entire text after the first slash
   */
  public String getPost() {
    return post;
  }

  /**
   @return entire text before the first slash
   */
  public String getPre() {
    return pre;
  }

  /**
   Display the slash root, with an adjustment symbol if it's a clean note, otherwise as-is

   @param withOptional adjustment symbol
   @return displayed slash root
   */
  public String display(Accidental withOptional) {
    if (PitchClass.None != pitchClass)
      return String.format("/%s", pitchClass.toString(withOptional));
    else if (!Strings.isNullOrEmpty(post))
      return String.format("/%s", post);
    else return EMPTY;
  }

  /**
   Whether this slash root is the same as another

   @param o to compare
   @return true if same
   */
  public boolean isSame(SlashRoot o) {
    return (Objects.nonNull(post) && Objects.nonNull(o.post) && post.equals(o.post))
      || pitchClass.equals(o.pitchClass);
  }
}
