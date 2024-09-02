// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/staff/homepage/view/DiseaseScreen.dart';
import 'package:untitled/staff/ivdv/bloc/ivdv_bloc.dart';

import 'package:untitled/staff/ivdv/bloc/ivdv_event.dart';
import 'package:untitled/staff/ivdv/bloc/ivdv_state.dart';

class Ivdv extends StatefulWidget {
  @override
  _IvdvState createState() => _IvdvState();
}

class _IvdvState extends State<Ivdv> {
  final TextEditingController titleController = TextEditingController();
  final PageController _pageController = PageController();
  String? others;
  String? _specimen;
  String? _othersdue;
  String? _migratory;
  String?
      _antiviralRequested; // Add this variable to track the "Antiviral treatment requested?" selection

  final GlobalKey<FormState> _formKeyPage1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage6 = GlobalKey<FormState>();
  double _sliderValue = 0;
  final int _totalPages = 6;
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

  void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        title: Text('IVDV'),
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
      context.read<IvdvBloc>().add(
            UpdateField(fieldName, formattedDate) as IvdvEvent,
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

  @override
  Widget buildpage(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildFormPages(),
          _buildHomePage(),
          _buildSearchPage(),
          _buildProfilePage(),
        ],
      ),
    );
  }

  Widget _buildFormPages() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        _buildPage1(),
        _buildPage2(),
        _buildPage3(),
        _buildPage4(),
        _buildPage5(),
        _buildPage6(),
      ],
    );
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage1, // Ensure that _formKey is unique for each form
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("1. Reporting / Investigation Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              // First Row
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                        "Date Case Reported", "Date Case Reported"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Reported By", "Reported By"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Second Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Title", "Title"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                        "Date Case Investigated", "Date Case Investigated"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Third Row
              Row(
                children: [
                  Expanded(
                    child:
                        _buildTextField("Investigated By", "Investigated By"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                        "Date of Desk Review", "Date of Desk Review"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Fourth Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Reviewed By", "Reviewed By"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField([
                      'SMO',
                      'DIO',
                      'DSO',
                    ], "Title", "Title"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Fifth Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField([
                      'Govt. Allopathic',
                      'Pvt Allopathic',
                      'ISM Pract',
                      'Other',
                    ], "Reporting Health Facility",
                        "Reporting Health Facility"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Next Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyPage1.currentState?.validate() ?? true) {
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
                ],
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
              Text("2. Case Identification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              // First Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Patient name", "patientName"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child:
                        _buildTextField("Other Given name", "otherGivenName"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Second Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Father's name", "fatherName"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField("Date of Birth", "dateOfBirth"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Third Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Age (Years / Months)", "age",
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Tel/Mobile", "mobile",
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Fourth Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Mother's name", "motherName"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['Male', 'Female'],
                      "Sex",
                      "Sex",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Continue with more rows...
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Address", "address"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Landmark", "landmark"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        "Planning unit(PHC/UPHC)", "planningUnit"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Village/Mohalla", "villageMohalla"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // ... Continue organizing all fields in two-column rows

              Row(
                children: [
                  Expanded(
                    child:
                        _buildTextField("Panchayat/Ward No", "panchayatWardNo"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Caste", "caste"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Id No", "idNo"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child:
                        _buildTextField("Block/Urban area", "blockUrbanArea"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField("District", "district"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                        ['Urban', 'Rural'], "Setting", "setting"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField("State", "state"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Pincode", "pincode"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Mobile", "mobile"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField("Mail ID", "mailId"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              _buildDropdownField(
                ['YES', 'NO', 'UNKNOWN'],
                "Patient belongs to migratory family/community",
                "Patient belongs to migratory family/community",
                onChanged: (value) {
                  setState(() {
                    _migratory = value;
                  });
                },
              ),
              if (others == 'YES') ...[
                _buildTextField(
                  'Other ',
                  'Other complications',
                )
              ],

              // Conditional question
              if (_migratory == "YES")
                Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            [
                              'Slum',
                              'Nomad',
                              'Brick kiln',
                              'Construction site'
                            ],
                            "If yes, specify",
                            "If yes, specify",
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                              "Others(specify)", "Others(specify)"),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 20),

              // Previous and Next buttons
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
              Text("3.Immunization History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['OPV', 'IPV', 'Both'],
                  "Type of poliovirus received by patient:",
                  "Type of poliovirus received by patient"),
              _buildTextField("Number of OPV doses through RI(a):",
                  "Number of OPV doses through RI(a):"),
              _buildTextField("Number of OPV doses through SIA(b):",
                  "Number of OPV doses through SIA(b):"),
              _buildTextField("Total OPV doses(a+b)", "Total OPV doses(a+b)"),
              _buildDateField(
                  "Date of last dose of OPV (at time of first investigation):",
                  "Date of last dose of OPV (at time of first investigation):"),
              _buildDateField(
                  "Date of last dose of OPV (before stool collection):",
                  "Date of last dose of OPV (before stool collection):"),
              _buildDateField(
                  "Date of recent exposure to OPV for close contacts (in last 6 months):",
                  "Date of recent exposure to OPV for close contacts (in last 6 months):"),
              _buildDateField("Date of last OPV campaign in community:",
                  "Date of last OPV campaign in community:"),
              _buildDropdownField([
                '0',
                '1',
                '2',
                '3',
                'Unknown',
              ], "Number of IPV doses received",
                  "Number of IPV doses received"),
              _buildDropdownField([
                'EI card',
                'Recall',
                'both',
              ], "Source of RI data", "Source of RI data"),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("4.Medical History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 16),
                _buildDateField(" Date of first consultation as a suspect PID:",
                    " Date of first consultation as a suspect PID:"),
                _buildDateField(" Date of confirmation of PID:",
                    " Date of confirmation of PID: "),
                _buildTextField(
                    " Age at diagnosis of PID: ", " Age at diagnosis of PID: "),
                Text(
                  'PID diagnosis as per latest International Union of Immunological Societies (IUIS) [encircle correct one):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildTextField(
                    "a. Severe Combined Immunodeficiency Disorder (specify): _",
                    "a. Severe Combined Immunodeficiency Disorder (specify): _"),
                _buildTextField(
                    "b. Combined Immunodeficiency Disorder with or without syndromic features (specify):",
                    "b. Combined Immunodeficiency Disorder with or without syndromic features (specify):"),
                _buildTextField(
                    "c. Antibody deficiencies i. Agammaglobulinemia, ii. CVID iii. Others (Specify): ",
                    "c. Antibody deficiencies i. Agammaglobulinemia, ii. CVID iii. Others (Specify): "),
                _buildTextField(
                    "d. Other PID (specify):", "d. Other PID (specify):"),
                _buildDropdownField([
                  'Yes',
                  'No',
                ], "IVIG treatment", "IVIG treatment"),
                _buildDropdownField([
                  'Yes',
                  'No',
                ], "Bone marrow transplant: ", "Bone marrow transplant: "),
                _buildDropdownField([
                  'Yes',
                  'No',
                ], " Acute flaccid paralysis (AFP):  ",
                    " Acute flaccid paralysis (AFP):  "),
                _buildDateField("If AFP, Date of onset of paralysis:",
                    " If AFP, Date of onset of paralysis:"),
                _buildTextField(" AFP EPID number ", " AFP EPID number"),
                _buildDropdownField(
                  [
                    'left arm',
                    'right arm',
                    'left arm',
                    'right leg',
                    'neck',
                    'bulbar',
                    'respirator muscle'
                        'trunk',
                    'facial',
                    'Others'
                  ],
                  "  Site(s) of Paralysis (encircle): ",
                  "  Site(s) of Paralysis (encircle): ",
                  onChanged: (value) {
                    setState(() {
                      others = value;
                    });
                  },
                ),
                if (others == 'Others') ...[
                  _buildTextField(
                    'Other ',
                    'Other complications',
                  )
                ],
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
                              content:
                                  Text('Please fill in all required fields'),
                            ),
                          );
                        }
                      },
                      child: Text("Next"),
                    ),
                  ],
                ),
              ]),
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
                    "5. Stool Specimen Collection",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField(
                            "Date Collected", "Date Collected")),
                    SizedBox(width: 16),
                    Expanded(child: _buildDateField("Date Sent", "Date Sent")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField(
                            "Date of result", "Date of result")),
                    SizedBox(width: 16),
                    Expanded(child: _buildTextField("Condition", "Condition:")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField("Lab result", "Lab result")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField("1st sample", "1st sample")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDropdownField(['Good', 'Poor'],
                            "1st sample ", "1st sample check")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField("Name of the laboratory",
                            "Name of the laboratory")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField("2nd sample", "2nd sample")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildDropdownField(['Good', 'Poor'],
                            "2nd sample ", "2nd sample check")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField("Name of the laboratory",
                            "Name of the laboratory 2nd sample")),
                    SizedBox(width: 16),
                    Expanded(
                        child:
                            _buildTextField("*Reason", "*Reason 2nd sample")),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Follow-up Specimen",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField("Sample no.", "Sample no.")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildDateField("Due date for sample collection",
                            "Due date for sample collection")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField("Sample collection date",
                            "Sample collection date")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildDateField("Due Sample Sent to lab",
                            "Due Sample Sent to lab")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField(
                            "Date of lab result", "Date of lab result")),
                    SizedBox(width: 16),
                    Expanded(
                        child:
                            _buildDateField("Last OPV dose", "Last OPV dose")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildDateField(
                            "Last SIA round", "Last SIA round")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField(
                            "Laboratory name", "Laboratory name")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField(
                            "Reason for late sample collection",
                            "Reason for late sample collection")),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildDropdownField(['Good', 'Poor'],
                            "Condition of sample", "Condition of sample")),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField("Final result", "Final result")),
                  ],
                ),
                _buildDropdownField(
                  [
                    ' Lack of tracking',
                    'Constipation',
                    'Death',
                    'Lost',
                    'Other'
                  ],
                  '*Reason if follow-up specimen not collected within 7 days of due date:',
                  '*Reason if follow-up specimen not collected within 7 days of due date:',
                  onChanged: (value) {
                    setState(() {
                      _othersdue = value;
                    });
                  },
                ),
                if (_othersdue == 'Other') ...[
                  _buildTextField(
                    'Other ',
                    'Other due date',
                  ),
                ],
                if (_othersdue == 'Death') ...[
                  _buildDateField(
                    'Death date',
                    'Please specify details',
                  ),
                ],
                _buildDropdownField(
                  ['Yes', 'No'],
                  'Contact specimen Collected',
                  'Contact specimen Collected',
                  onChanged: (value) {
                    setState(() {
                      _specimen = value;
                    });
                  },
                ),
                if (_specimen == 'Yes') ...[
                  _buildDateField(
                    'Date of collection First sample ',
                    'Date of collection First sample',
                  ),
                  _buildDateField(
                    'Date of collection last sample ',
                    'Date of collection last sample',
                  ),
                  _buildTextField(
                    'Number of contact specimens collected:',
                    'Number of contact specimens collected:',
                  ),
                  _buildTextField('SL positive', 'SL positive'),
                  _buildTextField('VDPV positive', 'VDPV positive'),
                  _buildTextField('WPV positive', 'WPV positive'),
                  _buildTextField('NPEV positive', 'NPEV  positive'),
                  _buildTextField('Negative', 'Negative'),
                ],
                SizedBox(height: 20),
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
                              content:
                                  Text('Please fill in all required fields'),
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
        ));
  }

  Widget _buildPage6() {
    return Form(
      key: _formKeyPage6,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "6. Case Classification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),

              // First Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField([
                      'SL',
                      'WPV',
                      'VDPV',
                    ], "Type-1", "Type-1"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField([
                      'SL',
                      'WPV',
                      'VDPV',
                    ], "Type-2", "Type-2"),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Second Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField([
                      'SL',
                      'WPV',
                      'VDPV',
                    ], "Type-3", "Type-3"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField([
                      'Yes',
                      'No',
                    ], "Is the person eligible for antiviral polio treatment?",
                        "Is the person eligible for antiviral polio treatment?",
                        onChanged: (value) {
                      setState(() {
                        _specimen = value;
                      });
                    }),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Third Row with conditional display
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField([
                      'Yes',
                      'No',
                    ], "Antiviral treatment requested?",
                        "Antiviral treatment requested?", onChanged: (value) {
                      setState(() {
                        _antiviralRequested = value;
                      });
                    }),
                  ),
                  if (_antiviralRequested == 'Yes') ...[
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField("If yes, treatment dates: Start",
                          "If yes, treatment dates: Start"),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 16),

              if (_antiviralRequested == 'Yes') ...[
                // Fourth Row
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField("End date", "End date"),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField("Type of antiviral(specify)",
                          "Type of antiviral(specify)"),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],

              // Fifth Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField([
                      'Fulldose',
                      'partial',
                      'not taken',
                    ], "Compliance", "Compliance"),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(), // Placeholder for alignment
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Align the submit button to the bottom-right corner
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    final ivdvBloc = context.read<IvdvBloc>();

                    // Trigger the form submission
                    ivdvBloc.add(SubmitForm());
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<IvdvBloc, IvdvState>(
      builder: (context, state) {
        final selectedIndex = state.fields['selectedIndex'] as int? ?? 0;

        return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<IvdvBloc>().add(
                  UpdateField('selectedIndex', index as String) as IvdvEvent,
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

  Widget _buildTextField(String labelText, String fieldName,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    final ivdvBloc = context.read<IvdvBloc>();
    final controller = TextEditingController(
      text: ivdvBloc.state.fields[fieldName] ?? '',
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
              color: Color.fromARGB(255, 12, 184, 232),
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
          // Update the state only when the value changes
          ivdvBloc.add(
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
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
              borderSide: BorderSide(
                color: Colors.blueGrey, // Border color
                width: 1.5, // Border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blueGrey, // Border color when enabled
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blue, // Border color when focused
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 12.0), // Padding inside the field
          ),
          child: BlocBuilder<IvdvBloc, IvdvState>(
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
                        fieldValue.isEmpty ? 'Select a date' : fieldValue,
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
      child: BlocBuilder<IvdvBloc, IvdvState>(
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
                    context.read<IvdvBloc>().add(
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

  Widget _buildHomePage() {
    return Center(
      child: Text("Home Page"),
    );
  }

  Widget _buildSearchPage() {
    return Center(
      child: Text("Search Page"),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Text("Profile Page"),
    );
  }

  String? _validateRequired(String? value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }
}
