// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.service.nexus;

class LoremIpsum {
  /**
   List of colors
   */
  static final String[] COLORS = {
    "Amber",
    "Amethyst",
    "Apricot",
    "Aquamarine",
    "Azure",
    "Baby",
    "Beige",
    "Black",
    "Blue",
    "Blush",
    "Bronze",
    "Brown",
    "Burgundy",
    "Byzantium",
    "Carmine",
    "Cerise",
    "Cerulean",
    "Champagne",
    "Chartreuse",
    "Chocolate",
    "Cobalt",
    "Coffee",
    "Copper",
    "Coral",
    "Crimson",
    "Cyan",
    "Desert",
    "Electric",
    "Emerald",
    "Erin",
    "Gold",
    "Gray",
    "Green",
    "Harlequin",
    "Indigo",
    "Ivory",
    "Jade",
    "Jungle",
    "Lavender",
    "Lemon",
    "Lilac",
    "Lime",
    "Magenta",
    "Maroon",
    "Mauve",
    "Navy",
    "Ochre",
    "Olive",
    "Orange",
    "Orchid",
    "Peach",
    "Pear",
    "Periwinkle",
    "Persian",
    "Pink",
    "Plum",
    "Prussian",
    "Puce",
    "Purple",
    "Raspberry",
    "Red",
    "Rose",
    "Ruby",
    "Salmon",
    "Sangria",
    "Sapphire",
    "Scarlet",
    "Silver",
    "Slate",
    "Spring",
    "Tan",
    "Taupe",
    "Teal",
    "Turquoise",
    "Ultramarine",
    "Violet",
    "Viridian",
    "White",
    "Yellow"
  };
  /**
   List of variants
   */
  static final String[] VARIANTS = {
    "Light",
    "Dark",
    "Saturated",
    "Dry",
    "Wet",
    "Pastel",
    "Transparent",
    "Glossy",
    "Matte",
    "Opaque",
    "Shiny",
    "Reflective",
    "Grainy",
    "Basic",
    "Simple",
    "Complex",
    "Evocative",
    "Dull",
    "Excellent",
    "Fantastic",
    "Tremendous"
  };
  /**
   List of variants
   */
  static final String[] PERCUSSIVE_NAMES = {
    "AGOGOHIGH",
    "AGOGOLOW",
    "BELLRIDE",
    "BLOCKWOODHIGH",
    "BLOCKWOODLOW",
    "BONGOHIGH",
    "BONGOLOW",
    "CABASA",
    "CLAP",
    "CLAVES",
    "CONGAHIGHMUTE",
    "CONGAHIGHOPEN",
    "CONGALOW",
    "COWBELL",
    "CUICAMUTE",
    "CUICAOPEN",
    "CYMBALCRASH",
    "CYMBALRIDE",
    "CYMBALSPLASH",
    "GONG",
    "GUIROLONG",
    "GUIROSHORT",
    "HIHATCLOSED",
    "HIHATOPEN",
    "HIHATPEDAL",
    "KICK",
    "KICKLONG",
    "MARACAS",
    "SHAKER",
    "SLAP",
    "SNARE",
    "SNARERIM",
    "STICKSIDE",
    "TAMBOURINE",
    "TIMBALEHIGH",
    "TIMBALELOW",
    "TOMFLOORHIGH",
    "TOMFLOORLOW",
    "TOMHIGH",
    "TOMHIGHMID",
    "TOMLOW",
    "TOMLOWMID",
    "TRIANGLEMUTE",
    "TRIANGLEOPEN",
    "VIBRASLAP",
    "WHISTLELONG",
    "WHISTLESHORT"
  };
  /**
   List of musical keys
   */
  static final String[] MUSICAL_CHORDS = {
    "A",
    "Am",
    "A#",
    "Bbm",
    "B",
    "Bm",
    "C",
    "Cm",
    "C#",
    "Dbm",
    "D",
    "Dm",
    "D#",
    "Ebm",
    "E",
    "Em",
    "F",
    "Fm",
    "F#",
    "Gbm",
    "G",
    "Gm",
    "G#",
    "Abm",
    "A7",
    "Am7",
    "A#7",
    "Bbm7",
    "B7",
    "Bm7",
    "C7",
    "Cm7",
    "C#7",
    "Dbm7",
    "D7",
    "Dm7",
    "D#7",
    "Ebm7",
    "E7",
    "Em7",
    "F7",
    "Fm7",
    "F#7",
    "Gbm7",
    "G7",
    "Gm7",
    "G#7",
    "Abm7",
    "A9",
    "Am9",
    "A#9",
    "Bbm9",
    "B9",
    "Bm9",
    "C9",
    "Cm9",
    "C#9",
    "Dbm9",
    "D9",
    "Dm9",
    "D#9",
    "Ebm9",
    "E9",
    "Em9",
    "F9",
    "Fm9",
    "F#9",
    "Gbm9",
    "G9",
    "Gm9",
    "G#9",
    "Abm9",
    "A dim",
    "Am dim",
    "A# dim",
    "Bbm dim",
    "B dim",
    "Bm dim",
    "C dim",
    "Cm dim",
    "C# dim",
    "Dbm dim",
    "D dim",
    "Dm dim",
    "D# dim",
    "Ebm dim",
    "E dim",
    "Em dim",
    "F dim",
    "Fm dim",
    "F# dim",
    "Gbm dim",
    "G dim",
    "Gm dim",
    "G# dim",
    "Abm dim",
    "A sus",
    "Am sus",
    "A# sus",
    "Bbm sus",
    "B sus",
    "Bm sus",
    "C sus",
    "Cm sus",
    "C# sus",
    "Dbm sus",
    "D sus",
    "Dm sus",
    "D# sus",
    "Ebm sus",
    "E sus",
    "Em sus",
    "F sus",
    "Fm sus",
    "F# sus",
    "Gbm sus",
    "G sus",
    "Gm sus",
    "G# sus",
    "Abm sus",
    "A/C",
    "Am/C",
    "A#/C#",
    "Bbm/Db",
    "B/D",
    "Bm/D",
    "C/D#",
    "Cm/Eb",
    "C#/E",
    "Dbm/E",
    "D/F",
    "Dm/F",
    "D#/F#",
    "Ebm/Gb",
    "E/G",
    "Em/G",
    "F/G#",
    "Fm/Ab",
    "F#/A",
    "Gbm/A",
    "G/A#",
    "Gm/Bb",
    "G#/B",
    "Abm/B"
  };
  /**
   List of musical keys
   */
  static final String[] MUSICAL_KEYS = {
    "A Major",
    "A minor",
    "A# Major",
    "Bb minor",
    "B Major",
    "B minor",
    "C Major",
    "C minor",
    "C# Major",
    "Db minor",
    "D Major",
    "D minor",
    "D# Major",
    "Eb minor",
    "E Major",
    "E minor",
    "F Major",
    "F minor",
    "F# Major",
    "Gb minor",
    "G Major",
    "G minor",
    "G# Major",
    "Ab minor"
  };
  /**
   List of possible Sequence totals
   */
  static final Integer[] SEQUENCE_TOTALS = {
    8,
    12,
    16
  };
  /**
   List of possible Pattern totals
   */
  static final Integer[] PATTERN_TOTALS = {
    1,
    2,
    4
  };
  /**
   List of elements
   */
  static final String[] ELEMENTS = {
    "Actinium",
    "Aluminum",
    "Americium",
    "Antimony",
    "Argon",
    "Arsenic",
    "Astatine",
    "Barium",
    "Berkelium",
    "Beryllium",
    "Bismuth",
    "Bohrium",
    "Boron",
    "Bromine",
    "Cadmium",
    "Calcium",
    "Californium",
    "Carbon",
    "Cerium",
    "Cesium",
    "Chlorine",
    "Chromium",
    "Cobalt",
    "Copper",
    "Curium",
    "Dubnium",
    "Dysprosium",
    "Einsteinium",
    "Erbium",
    "Europium",
    "Fermium",
    "Fluorine",
    "Francium",
    "Gadolinium",
    "Gallium",
    "Germanium",
    "Gold",
    "Hafnium",
    "Hassium",
    "Helium",
    "Holmium",
    "Hydrogen",
    "Indium",
    "Iodine",
    "Iridium",
    "Iron",
    "Krypton",
    "Lanthanum",
    "Lawrencium",
    "Lead",
    "Lithium",
    "Lutetium",
    "Magnesium",
    "Manganese",
    "Meitnerium",
    "Mendelevium",
    "Mercury",
    "Molybdenum",
    "Neodymium",
    "Neon",
    "Neptunium",
    "Nickel",
    "Niobium",
    "Nitrogen",
    "Nobelium",
    "Osmium",
    "Oxygen",
    "Palladium",
    "Phosphorus",
    "Platinum",
    "Plutonium",
    "Polonium",
    "Potassium",
    "Praseodymium",
    "Promethium",
    "Protactinium",
    "Radium",
    "Radon",
    "Rhenium",
    "Rhodium",
    "Rubidium",
    "Ruthenium",
    "Rutherfordium",
    "Samarium",
    "Scandium",
    "Seaborgium",
    "Selenium",
    "Silicon",
    "Silver",
    "Sodium",
    "Strontium",
    "Sulfur",
    "Tantalum",
    "Technetium",
    "Tellurium",
    "Terbium",
    "Thallium",
    "Thorium",
    "Thulium",
    "Tin",
    "Titanium",
    "Tungsten",
    "Uranium",
    "Vanadium",
    "Xenon",
    "Ytterbium",
    "Yttrium",
    "Zinc",
    "Zirconium"
  };
}
