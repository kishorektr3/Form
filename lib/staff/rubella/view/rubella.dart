import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/staff/homepage/view/DiseaseScreen.dart';
import 'package:untitled/staff/rubella/bloc/rubella_bloc.dart';
import 'package:untitled/staff/rubella/bloc/rubella_event.dart';
import 'package:untitled/staff/rubella/bloc/rubella_state.dart';

class Rubella extends StatefulWidget {
  @override
  _RubellaState createState() => _RubellaState();
}

class _RubellaState extends State<Rubella> {
  final TextEditingController titleController = TextEditingController();
  final PageController _pageController = PageController();
  double _sliderValue = 0;
  final int _totalPages = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        title: Text('Rubella'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSlider(), // Call the separate slider method
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _sliderValue = index.toDouble();
                });
              },
              children: [
                _buildPage1(),
                _buildPage2(),
                _buildPage3(),
                _buildPage4(),
                _buildPage5(),
                _buildPage6(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: Colors.blueAccent,
          inactiveTrackColor: Colors.grey[300],
          thumbColor: Colors.blueAccent,
          overlayColor: Colors.blueAccent.withOpacity(0.2),
          trackHeight: 8.0, // Thicker track to match the design
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          trackShape:
              RoundedRectSliderTrackShape(), // Rounded corners for the track
        ),
        child: Slider(
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          value: _sliderValue,
          min: 0,
          max: (_totalPages - 1).toDouble(),
          divisions: _totalPages - 1,
          label: '${(_sliderValue * 5 / (_totalPages - 1)).toInt()}',
          onChanged: (e) {}, // Disable user interaction
        ),
      ),
    );
  }

  // ignore: unused_field
  String? _migratoryFamilySelection;
  String? _similarSymptoms;
  String? _requirescross;
  String? _symptomsneighbour;
  String? _provisional;
  String? _activecase;
  String? _others;
  String? _birthdefect;
  String? _otherdefect;
  String? _othermigratory;
  String? _specimen;
  String? _blood;
  String? _death;
  String? _complications;
  String? _pregnant;
  final GlobalKey<FormState> _formKeyPage1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage6 = GlobalKey<FormState>();

  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _selectDate(BuildContext context, String fieldName) async {
    DateTime initialDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      context.read<RubellaBloc>().add(
            UpdateField(fieldName, formattedDate),
          );
    }
  }

  void _onNavItemTapped(int index) {
    if (index == 0) {
      // Navigate to the HomePage when the "Home" tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiseaseScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Type of case",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  _buildDropdownField(
                    ['Outbreak', 'Sporadic'],
                    "Type of Case",
                    "typeOfCase",
                    conditionalValue: 'Outbreak',
                    additionalWidgets: [
                      _buildTextField(
                          '  "If case belongs to an outbreak then please provide a linked MOB-ID (MOB- IND-BI- AGB- _____- ______ )",',
                          '  "If case belongs to an outbreak then please provide a linked MOB-ID (MOB- IND-BI- AGB- _____- ______ )",')
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "2. Reporting / Investigation Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildDateField("Date Case Notified", "Date Case Notified"),
              _buildTextField("Notified By", "Notified By"),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Designation", "Designation"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                        "Date Case Investigated", "Date Case Investigated"),
                  ),
                ],
              ),
              _buildTextField("Investigated By", "Investigated By"),
              _buildDropdownField(
                [
                  'Medical Officer',
                  'DIO',
                  'DSO',
                  'Nodal Officer',
                  'SMO',
                  'Other'
                ],
                "Designation",
                "Designation investigated by",
              ),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                        "Date case verified", "Date case verified"),
                  ),
                ],
              ),
              _buildTextField("Verified By", "Verified By"),
              _buildDropdownField(
                [
                  'Medical Officer',
                  'DIO',
                  'DSO',
                  'Nodal Officer',
                  'SMO',
                  'Other'
                ],
                "Designation",
                "Designation verified by",
              ),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['RU', 'Informer', 'Other'],
                      "Notifying Health Facility Type",
                      "Notifying Health Facility Type",
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns children to the start
                children: [
                  _buildDropdownField(
                    ['VHP', 'HP', 'Other', 'LP'],
                    "Category",
                    "Category",
                  ),
                  SizedBox(
                      height: 16), // Adds space between the two dropdown fields
                  _buildDropdownField(
                    [
                      'Govt. Allopathic',
                      'Pvt Allopathic',
                      'ISM Pract',
                      'Quack',
                      'HW',
                      'HSC',
                      'HWC',
                      'FLW',
                      'Others'
                    ],
                    "Setup",
                    "Setup",
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKeyPage1.currentState?.validate() ?? false) {
                      _nextPage();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all required fields'),
                        ),
                      );
                    }
                  },
                  child: Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "3. Case Identification",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  // First Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField("Patient name", "patientName"),
                        _buildTextField("Other Given name", "otherGivenName"),
                        _buildTextField("Father's name", "fatherName"),
                        _buildDateField("Date of Birth", "dateOfBirth"),
                        _buildTextField("Age (Years / Months)", "age",
                            keyboardType: TextInputType.number),
                        _buildTextField("Tel/Mobile", "mobile",
                            keyboardType: TextInputType.number),
                        _buildTextField("Mother's name", "motherName"),
                        _buildDropdownField(
                          ['Male', 'Female'],
                          "Sex",
                          "Sex",
                        ),
                        _buildTextField("Address", "address"),
                        _buildTextField("Landmark", "landmark"),
                      ],
                    ),
                  ),
                  SizedBox(width: 16), // Space between columns
                  // Second Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                            "Planning unit(PHC/UPHC)", "planningUnit"),
                        _buildTextField("Village/Mohalla", "villageMohalla"),
                        _buildTextField("HRA", "hra"),
                        _buildDropdownField(
                          ['Hindu', 'Muslim', 'Other'],
                          "Religion",
                          "Religion",
                        ),
                        _buildTextField("Panchayat/Ward No", "panchayatWardNo"),
                        _buildTextField("Caste", "caste"),
                        _buildTextField("Id No", "idNo"),
                        _buildTextField("Block/Urban area", "blockUrbanArea"),
                        _buildTextField("District", "district"),
                        _buildDropdownField(
                            ['Urban', 'Rural'], "Setting", "setting"),
                        _buildTextField("State", "state"),
                        _buildTextField("Pincode", "pincode"),
                        _buildTextField("Mobile", "mobile"),
                        _buildTextField("Mail ID", "mailId"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16), // Space between sections
              // Migratory family/community section
              _buildDropdownField(
                ['Yes', 'No'],
                "Patient belongs to migratory family/ community :",
                "Patient belongs to migratory family/ community :",
                onChanged: (value) {
                  setState(() {
                    _migratoryFamilySelection = value;
                  });
                },
              ),
              if (_migratoryFamilySelection == 'Yes') ...[
                _buildDropdownField(
                  [
                    ' Slum with migration',
                    'Nomad',
                    ' Brick Kiln ',
                    'Construction site',
                    'Others'
                  ],
                  '  specify',
                  '  specify patient belongs to',
                  onChanged: (value) {
                    setState(() {
                      _othermigratory = value;
                    });
                  },
                ),
                if (_othermigratory == "Others") ...[
                  _buildTextField('others', 'others migratory')
                ]
              ],
              SizedBox(height: 20), // Space before buttons
              // Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyPage2.currentState?.validate() ?? false) {
                        _nextPage(); // Navigate to the next page if validation passes
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("4.Hospitalization: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                [
                  'Yes',
                  'No',
                ],
                "hospitalization",
                "hospitalization",
              ),
              _buildDropdownField(
                [
                  'OPD',
                  'IP',
                ],
                "Treated at",
                "Treated at",
              ),
              _buildDateField(
                  "Date of Hospitalization:", "Date of Hospitalization:"),
              _buildTextField("IP No", "IP No"),
              _buildTextField("Name of Hospital", "Name of Hospital:"),
              _buildTextField("Diagnosis as per hospital records, if any",
                  "Diagnosis as per hospital records, if any"),
              Text(
                " 5. Immunization History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDropdownField(
                ['YES', 'NO', 'Unknown', 'NA'],
                " Measles containing vaccine received:",
                " Measles containing vaccine received:",
                conditionalValue: 'YES',
                additionalWidgets: [
                  _buildDropdownField(
                    ['MCP card', 'Recall' 'both'],
                    " vaccination history as per: ",
                    " vaccination history as per: ",
                  ),
                ],
              ),
              _buildDropdownField(
                ['YES', 'NO', "Unknown", "NA"],
                " MCV1",
                "MCV1",
              ),
              _buildDropdownField(
                ['M', 'MR', "MMR", "MMRV", 'UNknown'],
                " Type",
                "Type MCV1",
              ),
              _buildDateField(
                  " If card available, date", " If card available, date"),
              _buildDropdownField(
                ['YES', 'NO', "Unknown", "NA"],
                " MCV2",
                "MCV2",
              ),
              _buildDropdownField(
                ['M', 'MR', "MMR", "MMRV", 'UNknown'],
                " Type",
                "Type MCV2",
              ),
              _buildDateField(" If card available, date",
                  " If card available, date for MCV2"),
              _buildDropdownField(
                  [
                    'Awareness gap',
                    ' AEFI apprehension',
                    " Child travelling",
                    " Operational gap",
                    'refusal',
                    'Others',
                  ],
                  "  If MCV is missed in RI ,specify reason",
                  " If MCV is missed in RI ,specify reason",
                  conditionalValue: 'Others',
                  additionalWidgets: [
                    _buildTextField('Others', 'specify reason if others ')
                  ]),
              _buildTextField(
                  " No. of MCV doses received through campaign (SIA):",
                  "c. No. of MCV doses received through campaign (SIA):"),
              _buildDropdownField(
                [
                  '0',
                  '1',
                  " 2",
                  " 3",
                  '4',
                  'more',
                ],
                " Total MCV doses (RI+SIA):",
                "Total MCV doses (RI+SIA):",
              ),
              _buildDropdownField(
                  [
                    'Awareness gap',
                    ' AEFI apprehension',
                    " Child travelling",
                    " Operational gap",
                    'refusal',
                    'Others',
                  ],
                  "  If campaign dose is missed, encircle reason",
                  " If campaign dose is missed, encircle reason",
                  conditionalValue: 'Others',
                  additionalWidgets: [
                    _buildTextField('Others', 'specify reason if others ')
                  ]),
              _buildDateField("  Date of last dose of MCV (before rash onset)",
                  "  Date of last dose of MCV (before rash onset)"),
              _buildDateField(
                  "  Date of last dose of MCV (before blood collection):",
                  " Date of last dose of MCV (before blood collection):"),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyPage3.currentState?.validate() ?? false) {
                        _nextPage(); // Navigate to the next page if validation passes
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage4() {
    return Form(
      key: _formKeyPage4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "6. Clinical History:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO', 'Unknown'],
                      "Generalised Maculopapular Rash",
                      "Generalised Maculopapular Rash",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO', 'Unknown'],
                      "Fever",
                      "Fever",
                    ),
                  ),
                ],
              ),
              _buildDateField("Date of fever onset:", "Date of fever onset:"),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Cough",
                      "Cough",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Coryza (Running Nose):",
                      "Coryza (Running Nose):",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Conjunctivitis (Red eyes):",
                      "Conjunctivitis (Red eyes):",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Clinician suspects Measles",
                      "Clinician suspects Measles",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Enlarged lymph nodes:",
                      "Enlarged lymph nodes:",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Joint pain",
                      "Joint pain",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Clinician suspects Rubella",
                      "Clinician suspects Rubella",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                        ['YES', 'NO'], "Complications", "Complications",
                        conditionalField: 'YES',
                        additionalWidgets: [
                          _buildDropdownField(
                            [
                              'Diarrhea',
                              'Malnutrition',
                              'Encephalitis',
                              'ARI',
                              'Pneumonia',
                              'Ear problems (otitis media)'
                            ],
                            "Specify",
                            "Specify",
                          ),
                        ]),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Eye problems (corneal clouding)",
                      "Eye problems (corneal clouding)",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Eye problems (xerosis clouding)",
                      "Eye problems (xerosis clouding)",
                    ),
                  ),
                ],
              ),
              _buildTextField("Others", "Other Complications"),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['0', '1', '2'],
                      "No. of Vitamin-A doses received",
                      "No. of Vitamin-A doses received",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['YES', 'NO'],
                      "Malnutrition (in child <5 years):",
                      "Malnutrition (in child <5 years):",
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "7. Travel history",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildDropdownField(
                ['YES', 'NO'],
                "Travel History",
                "Travel History",
              ),
              Text(
                "Select a number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
              ),
              BlocBuilder<RubellaBloc, RubellaState>(
                builder: (context, state) {
                  final selectedNumber =
                      (state.fields["selectedNumber"] ?? 0) as int;

                  return Slider(
                    value: selectedNumber.toDouble(),
                    min: -21,
                    max: 7,
                    divisions: 28,
                    label: selectedNumber.toString(),
                    onChanged: (double newValue) {
                      context
                          .read<RubellaBloc>()
                          .add(UpdateField('selectedNumber', newValue.toInt()));
                    },
                  );
                },
              ),
              _buildTextField('District of residence', 'District of residence'),
              _buildDropdownField(
                [
                  'Yes',
                  'No',
                ],
                "Requires cross notification?",
                "Requires cross notification?",
                onChanged: (value) => {
                  setState(() {
                    _requirescross = value;
                  })
                },
              ),
              if (_requirescross == 'Yes') ...[
                _buildDateField(
                  " date of cross notification:",
                  ' date of cross notification:',
                )
              ],
              _buildTextField('Block/ Urban area of residence:',
                  'Block/ Urban area of residence:'),
              _buildTextField('Places visited during most infectious period::',
                  'Places visited during most infectious period::'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyPage4.currentState?.validate() ?? false) {
                        _nextPage(); // Navigate to the next page if validation passes
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage5() {
    return Form(
      key: _formKeyPage5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "8. History of similar symptoms among close contacts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                ['Yes', 'No'],
                "Similar symptoms in other household contact(s):",
                "Similar symptoms in other household contact(s):",
                onChanged: (value) {
                  setState(() {
                    _similarSymptoms = value;
                  });
                },
              ),
              if (_similarSymptoms == 'Yes') ...[
                _buildTextField(
                  ' No. affected',
                  ' No. affected',
                ),
                _buildTextField(
                  'Name/s:',
                  'Name/s:',
                ),
              ],
              _buildDropdownField(
                ['Yes', 'No'],
                "Similar symptoms in other neighbourhood / work / school contact(s):",
                "Similar symptoms in other neighbourhood / work / school contact(s):",
                onChanged: (value) {
                  setState(() {
                    _symptomsneighbour = value;
                  });
                },
              ),
              if (_symptomsneighbour == 'Yes') ...[
                _buildTextField(
                  'No. affected',
                  ' No. affected neigbour',
                ),
                _buildTextField(
                  'Name/s:',
                  'Name/s: ',
                ),
              ],
              _buildTextField(
                ' If any of the above contact is already lab confirmed, mention EPID No',
                " If any of the above contact is already lab confirmed, mention EPID No",
              ),
              Center(
                child: Text(
                  "9. Health seeking behaviour after rash onset",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildDropdownField(
                [
                  'confined at home',
                  'contacted community workers',
                  ' contacted health facility'
                ],
                "Health seeking behaviour after rash onset (encircle): ",
                " Health seeking behaviour after rash onset (encircle): ",
              ),
              Center(
                child: Text(
                  "10. If history of contact with community workers after the date of rash onset , mention details:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildTextField('Name', 'Name'),
              _buildDropdownField([
                'Health workers ',
                ' Religious leader',
                'Community influencer'
              ], 'Specify category of community workers',
                  'Specify category of community workers'),
              _buildDateField('Date of contact', 'Date of contact'),
              _buildDropdownField(
                  ['YES', 'NO'],
                  'Did they refer / report the case to  any facility',
                  'Did they refer / report the case to  any facility'),
              _buildTextField(
                  'Action by DIO / SMO/ MO', 'Action by DIO / SMO/ MO'),
              Center(
                child: Text(
                  "Categories of Community workers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              _buildDropdownField(['ANM', 'CHO', 'AWW', 'ASHA', 'LHV', 'MPW'],
                  ' Health Workers', ' Health Workers'),
              _buildDropdownField(
                  ['Priest', 'Temple link person', 'Mazars', 'Maulana', 'Ozha'],
                  ' Religious leaders',
                  ' Religious leaders'),
              _buildDropdownField(
                  ['Village head ', ' Teacher', 'Pradhan', 'Panchayat member'],
                  ' Community influencers ',
                  ' Community influencers '),
              Center(
                child: Text(
                  "12. Provisional diagnosis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildDropdownField(
                ['Suspected Measles', 'Suspected Rubella', 'Others'],
                "Provisional diagnosis:",
                "Provisional diagnosis:",
                onChanged: (value) {
                  setState(() {
                    _provisional = value;
                  });
                },
              ),
              if (_provisional == 'Others') ...[
                _buildTextField(
                  'Other ',
                  'Other provisional',
                ),
              ],
              Center(
                child: Text(
                  "13. Specimen Collection: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildDropdownField(
                ['Yes', 'No'],
                'Specimen Collection',
                'Specimen Collection',
                onChanged: (value) {
                  setState(() {
                    _specimen = value;
                  });
                },
              ),
              if (_specimen == 'Yes') ...[
                _buildDropdownField(
                  [
                    'Blood',
                    'Throat Swab ',
                    'Nasopharyngeal swab',
                    'Urine sample'
                  ],
                  'Select Specimen type',
                  'Select Specimen type',
                  onChanged: (value) => {
                    setState(() {
                      _blood = value;
                    })
                  },
                ),
                if (_blood == 'Blood') ...[
                  _buildDateField(
                      'Blood date collected', 'Blood date collected'),
                  _buildDateField('Blood Date Sent', 'Blood Date Sent'),
                  _buildDateField(
                      'Blood  Date of Result', 'Blood  Date of Result'),
                  _buildDropdownField(['Good ', 'Poor'], 'Conditon of sample',
                      'Conditon of sample')
                ]
              ],
              Center(
                child: Text(
                  "14. Name of Govt Health Facility resposible for Active Case Search and public health response in neihbourhood community (scanning of area by HW /FLW ): : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildDropdownField(
                ['Yes', 'No'],
                "Active case search in community done",
                "Active case search in community done:",
                onChanged: (value) {
                  setState(() {
                    _activecase = value;
                  });
                },
              ),
              if (_activecase == 'Yes') ...[
                _buildDateField(" Date of search", " Date of search:"),
              ],
              _buildTextField(
                'Number of suspected cases found ',
                'Number of suspected cases found',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyPage5.currentState?.validate() ?? false) {
                        _nextPage(); // Navigate to the next page if validation passes
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage6() {
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKeyPage6,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  " 15. Feedback",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Patient / Caregiver: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              _buildTextField('Mobile', ' patient Mobile  '),
              _buildTextField('Email Id', ' patient Email Id'),
              _buildDateField('Date Given ', ' Feedback Date Given '),
              Text(
                " Reporting Person / Institution: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              _buildTextField('Mobile', ' reporting person Mobile'),
              _buildTextField('Email Id', ' reporting  person Email Id'),
              _buildDateField(
                  'Date Given ', '  reporting person Feedback Date Given '),
              Text(
                " 16. 30 Day Follow-up:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDateField(' Date of follow-up ', 'Date of follow-up'),
              _buildDropdownField(
                ['Alive', 'Death', 'Lost'],
                'OUtcome',
                "outcome",
                onChanged: (value) => setState(() {
                  _death = value;
                }),
              ),
              if (_death == 'Death') ...[
                _buildDateField(
                    ' If died, date of death: ', ' If died, date of death: '),
                _buildTextField('Cause of death', 'Cause of death')
              ],
              _buildDropdownField(
                ['Yes', 'No'],
                'Complications present',
                'Complications present:',
                onChanged: (value) {
                  setState(() {
                    _complications = value;
                  });
                },
              ),
              if (_complications == 'Yes') ...[
                _buildDropdownField(
                  [
                    'Diarrhea',
                    'Pneumonia',
                    'Encephalitis',
                    'Ear infection',
                    'Eye complications ',
                    'Skin complications',
                    'Co-morbid conditions',
                    'Others'
                  ],
                  "Type of complications",
                  "Type of complications",
                  onChanged: (value) {
                    setState(() {
                      _others = value;
                    });
                  },
                ),
                if (_others == 'Others') ...[
                  _buildTextField(
                    'Other ',
                    'Other complications',
                  )
                ]
              ],
              _buildDropdownField(
                ['Yes', 'No'],
                ' suspected case is Pregnant',
                ' suspected case is Pregnant',
                onChanged: (value) => setState(() {
                  _pregnant = value;
                }),
              ),
              if (_pregnant == 'Yes') ...[
                _buildDateField(
                    'Date visit made to newborn from infected mother ',
                    ' Date visit made to newborn from infected mother '),
                _buildDropdownField(
                    [' Spontaneous abortion ', 'MTP', 'Still birth '],
                    ' observation after delivery / end of pregnancy',
                    ' observation after delivery / end of pregnancy'),
                SizedBox(height: 16),
                _buildDropdownField(
                  [': Normal', 'Birth defect'],
                  "Newborn Status",
                  "Newborn Status",
                  onChanged: (value) {
                    setState(() {
                      _birthdefect = value;
                    });
                  },
                ),
                if (_birthdefect == 'Birth defect') ...[
                  _buildDropdownField(
                    [
                      'Congenital heart defect',
                      'Eye defect',
                      'Hearing defect',
                      'Neurological defect',
                      ' Endocrine defect',
                      'Otherdefect'
                    ],
                    'If New born has birth defects then please encircle',
                    'If New born has birth defects then please encircle',
                    onChanged: (value) {
                      setState(() {
                        _otherdefect = value;
                      });
                    },
                  ),
                  if (_otherdefect == 'Other defect') ...[
                    _buildTextField('Other(specify)', 'birth defect  other ')
                  ]
                ],
              ],
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    final rubellaBloc = context.read<RubellaBloc>();

                    // Trigger the form submission
                    rubellaBloc.add(SubmitForm());

                    // Listen for form submission success
                    rubellaBloc.stream.listen((state) {
                      if (state.fields.isEmpty) {
                        // Show a success message using a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Submitted successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // After submission, navigate to the next page with the form data
                        // Navigator.push(...); // Uncomment and implement navigation as needed
                      }
                    });
                  },
                  child: Text("Submit"),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String fieldName,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    final controller = TextEditingController(
      text: context.read<RubellaBloc>().state.fields[fieldName] ?? '',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 12.0,
          ),
        ),
        validator: validator ?? _validateRequired, // Apply validation
        onChanged: (value) {
          context.read<RubellaBloc>().add(
                UpdateField(fieldName, value),
              );
        },
      ),
    );
  }

  Widget _buildDateField(String labelText, String fieldName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _selectDate(context, fieldName),
        child: InputDecorator(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_today),
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 12.0,
            ),
          ),
          child: BlocBuilder<RubellaBloc, RubellaState>(
            builder: (context, state) {
              final fieldValue = state.fields[fieldName] ?? '';
              return FormField<String>(
                validator: (value) {
                  if (fieldValue.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
                builder: (FormFieldState<String> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fieldValue.isEmpty ? 'pick date' : fieldValue,
                        style: TextStyle(
                          color:
                              fieldValue.isEmpty ? Colors.grey : Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            field.errorText!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    List<String> items,
    String labelText,
    String fieldName, {
    ValueChanged<String?>? onChanged,
    String? conditionalField,
    String? conditionalValue,
    List<Widget>? additionalWidgets,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<RubellaBloc, RubellaState>(
        builder: (context, state) {
          final selectedValue = state.fields[fieldName] as String?;

          // Check the condition to render additional widgets
          bool shouldShowAdditionalWidgets = selectedValue == conditionalValue;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: items.contains(selectedValue) ? selectedValue : null,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 12.0,
                  ),
                ),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<RubellaBloc>().add(
                          UpdateField(fieldName, value),
                        );

                    // Print the selected value to the console

                    if (onChanged != null) {
                      onChanged(value);
                    }
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a value';
                  }
                  return null;
                },
              ),
              if (shouldShowAdditionalWidgets && additionalWidgets != null)
                ...additionalWidgets,
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<RubellaBloc, RubellaState>(
      builder: (context, state) {
        final selectedIndex = state.fields['selectedIndex'] as int? ?? 0;

        return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<RubellaBloc>().add(
                  UpdateField('selectedIndex', index),
                );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }

  String? _validateRequired(String? value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }
}
