import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/rubella/bloc/rubella_bloc.dart';
import 'package:untitled/rubella/bloc/rubella_event.dart';
import 'package:untitled/rubella/bloc/rubella_state.dart';

class Rubella extends StatefulWidget {
  @override
  _RubellaState createState() => _RubellaState();
}

class _RubellaState extends State<Rubella> {
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  // ignore: unused_field
  String? _migratoryFamilySelection;
  String? _similarSymptoms;
  String? _requirescross;
  String? _symptomsneighbour;
  String? _provisional;
  String? _activecase;
  final GlobalKey<FormState> _formKeyPage1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage6 = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            _buildPage1(),
            _buildPage2(),
            _buildPage3(),
            _buildPage4(),
            _buildPage5(),
            _buildPage6(),
            _buildPage7()
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
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
                "1. Type of Case",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['Sporadic', 'Outbreak'],
                      "Title",
                      "Title",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "[If case belongs to an outbreak then please provide a linked MOB-ID (MOB- IND-BI- AGB- _____- ______ )",
                      "[If case belongs to an outbreak then please provide a linked MOB-ID (MOB- IND-BI- AGB- _____- ______ )",
                    ),
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
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
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
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                        "Date case verified", "Date case verified"),
                  ),
                ],
              ),
              _buildTextField("Verified By", "Verified By"),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
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
                  ),
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
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['VHP', 'HP', 'Other', 'LP'],
                      "Category",
                      "Category",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
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
                  ),
                ],
              ),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return BlocConsumer<RubellaBloc, RubellaState>(
      listener: (context, state) {
        // Handle additional actions based on state changes here if needed
      },
      builder: (context, state) {
        final migratoryFamilySelection =
        state.fields["Patient belongs to migratory family/community"];

        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKeyPage2,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  // First Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("3. Case Identification",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
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

                        // Dropdown field for migratory family/community
                        _buildDropdownField(
                          ['YES', 'NO', 'UNKNOWN'],
                          "Patient belongs to migratory family/community",
                          "Patient belongs to migratory family/community",
                        ),

                        // Conditional question
                        if (migratoryFamilySelection == "YES")
                          _buildDropdownField(
                            [
                              'Slum',
                              'Nomad',
                              'Brick kiln',
                              'Construction site'
                            ],
                            "If yes, specify",
                            "If yes, specify",
                          ),
                        if (migratoryFamilySelection == "YES")
                          _buildTextField("Others(specify)", "Others(specify)"),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKeyPage2.currentState?.validate() ??
                                false) {
                              _nextPage();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please fill in all required fields'),
                                ),
                              );
                            }
                          },
                          child: Text("Next"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                [
                  'YES',
                  'NO',
                  'Unknown',
                  'NA',
                ],
                " Measles containing vaccine received through RI",
                " Measles containing vaccine received through RI",
              ),
              _buildDropdownField(
                [
                  ' MCP card',
                  'Recall',
                  "both",
                ],
                " If yes, vaccination history as per",
                "If yes, vaccination history as per",
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
                  'refusal'
                ],
                "  If MCV is missed in RI ,specify reason",
                " If MCV is missed in RI ,specify reason",
              ),
              _buildTextField("others", "others MCV missed reason"),
              _buildTextField(
                  " No. of MCV doses received through campaign (SIA):",
                  "c. No. of MCV doses received through campaign (SIA):"),
              _buildDropdownField(
                [
                  'Awareness gap',
                  ' AEFI apprehension',
                  " Child travelling",
                  " Operational gap",
                  'refusal',
                  'campaign not held',
                ],
                "   If campaign dose is missed, encircle reason",
                "  If campaign dose is missed, encircle reason",
              ),
              _buildTextField("others", "others campaign missed reason"),
              _buildDateField("  Date of last dose of MCV (before rash onset)",
                  "  Date of last dose of MCV (before rash onset)"),
              _buildDateField(
                  "  Date of last dose of MCV (before blood collection):",
                  " Date of last dose of MCV (before blood collection):"),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyPage3.currentState?.validate() ?? false) {
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
                      ['YES', 'NO'],
                      "Complications",
                      "Complications",
                    ),
                  ),
                ],
              ),
              _buildDropdownField(
                [
                  'Diarrhea',
                  'Malnutrition',
                  'Encephalitis',
                  'ARI',
                  'Pneumonia',
                  'Ear problems (otitis media)'
                ],
                "If yes:",
                "If yes:",
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
                  "If yes, date of cross notification:",
                  'If yes, No. affected',
                )
              ],
              _buildTextField('Block/ Urban area of residence:',
                  'Block/ Urban area of residence:'),
              _buildTextField('Places visited during most infectious period::',
                  'Places visited during most infectious period::'),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyPage4.currentState?.validate() ?? false) {
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
          child: Form(
            key: _formKey,
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
                    'If yes, No. affected',
                    'If yes, No. affected',
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
                    'If yes, No. affected',
                    'If yes, No. affected neigbour',
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
                Text(
                  "9. Health seeking behaviour after rash onset",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Text(
                  "12. Provisional diagnosis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Text(
                  "14. Name of Govt Health Facility resposible for Active Case Search and public health response in neihbourhood community (scanning of area by HW /FLW ): : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  _buildDateField(
                      "If yes, Date of search", "If yes, Date of search:"),
                ],
                _buildTextField(
                  'Number of suspected cases found ',
                  'Number of suspected cases found',
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKeyPage5.currentState?.validate() ?? false) {
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
          ),
        ),
      ),
    );
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
                  "11. Final Classification:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyPage2.currentState?.validate() ?? false) {
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
        ),
      ),
    );
  }

  Widget _buildPage7() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "11. Final Classification:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            _buildDropdownField(
              [
                'Laboratory confirmed typhoid',
                'Paratyphoid A or B or C',
                'Suspected case',
                'Rejected',
                'Invasive Nontyphoidal Salmonella',
              ],
              "Final Classification:",
              "Final Classification:",
            ),
            SizedBox(height: 16),
            Text(
              "12. 60 Day follow-up (telephonic)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDateField("Date of follow-up", "followUpDate"),
            SizedBox(height: 16),
            _buildDropdownField(
              [
                'Alive',
                'Lost',
                'Death',
              ],
              "Outcome",
              "Outcome",
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Text(
              "Case definition of suspected typhoid fever:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RubellaBloc>().add(SubmitForm());
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String fieldName,
      {TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
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
            labelText: labelText,
            border: OutlineInputBorder(),
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
                        fieldValue,
                        style: TextStyle(
                          color:
                          fieldValue.isEmpty ? Colors.grey : Colors.black,
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
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<RubellaBloc, RubellaState>(
        builder: (context, state) {
          final selectedValue = state.fields[fieldName] as String?;

          return DropdownButtonFormField<String>(
            value: items.contains(selectedValue) ? selectedValue : null,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                context.read<RubellaBloc>().add(
                  UpdateField(fieldName, value),
                );
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
    return value == null || value.isEmpty ? 'This field is required':null;
    }
}
