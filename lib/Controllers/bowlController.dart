List<String> type = [
  'Separated hard lumps',
  'Lumpy and sausage like',
  'Sausage shaped with cracks',
  'Like a smooth soft sausge or snake',
  'Soft bolbs, with clear cut edges',
  'Mushy with ragged edges',
  'Liquid, with no solid pieces'
];
List<String> color = [
  'Darkned',
  'Dark Brown',
  'Brown',
  'Light Brown',
  'Little Green',
  'Green',
];
List<String> smell = [
  'Smelless',
  'Soft Smell',
  'Moderate Smell',
  'Strong Smell',
  'Unbearable Smell',
];
List<String> volume = [
  'Less than normal',
  'Normal',
  'More than normal',
];
List<String> pain = [
  'No pain',
  'Mild pain',
  'Moderate pain',
  'Intense pain',
  'Unbearable pain',
];
List<String> symptoms = [
  'Dizziness',
  'Constipation',
  'Nausea',
  'Tremors',
  'Colic',
  'Chills',
  'Urgency',
];
List<String> duration = ['5 min', '15 min', '10 min', '20 min', '25 min'];
bool blood = false;
bool floatiness = false;
bool flalulence = false;
bool evacuatingStrain = false;
String time = '';

bowlEntries(type, color, smell, volume, pain, symptoms, duration, blood,
        floatiness, flalulence, evacuatingStrain, time) =>
    {
      'type': type,
      'color': color,
      'smell': smell,
      'volume': volume,
      'pain': pain,
      'symptoms': symptoms,
      'duration': duration,
      'blood': blood,
      'floatiness': floatiness,
      'flalulence': flalulence,
      'evacuatingStrain': evacuatingStrain,
      'time': time,
    };
