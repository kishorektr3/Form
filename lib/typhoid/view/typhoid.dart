import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/typhoid/bloc/typhoid_bloc.dart';
import 'package:untitled/typhoid/bloc/typhoid_state.dart';

import '../bloc/typhoid_event.dart';

class Typhoid extends StatefulWidget {
  @override
  _TyphoidState createState() => _TyphoidState();
}

class _TyphoidState extends State<Typhoid> {
  final PageController _pageController = PageController();

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

  void _submitForm() {
    if (_formKeyPage6.currentState?.validate() ?? false) {
      context.read<TyphoidBloc>().add(SubmitForm());
    }
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
      context.read<TyphoidBloc>().add(UpdateField(fieldName, formattedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
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
    );
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "1. Reporting / Investigation Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      "Date Case Reported",
                      "Date Case Reported",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Reported By",
                      "Reported By",
                      validator: _validateRequired,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Title",
                      "Title",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDateField(
                      "Date Case Investigated",
                      "Date Case Investigated",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Investigated By",
                      "Investigated By",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      ['DIO', 'MO', 'DSO', 'Nodal Officer', 'SMO'],
                      "Title",
                      "title",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      "Date of Desk Review",
                      "Date of Desk Review",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Reviewed By",
                      "Reviewed By",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['SMO', 'DIO', 'DSO'],
                      "Title",
                      "Title",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      [
                        'Govt. Allopathic',
                        'Pvt Allopathic',
                        'ISM Pract',
                        'Other',
                      ],
                      "Reporting Health Facility",
                      "Reporting Health Facility",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyPage1.currentState?.validate() ?? false) {
                    // Capture the form field values
                    final dateReported = context
                        .read<TyphoidBloc>()
                        .state
                        .fields['Date Case Reported'];
                    final reportedBy =
                    context
                        .read<TyphoidBloc>()
                        .state
                        .fields['Reported By'];
                    final investigatedBy = context
                        .read<TyphoidBloc>()
                        .state
                        .fields['Investigated  By'];
                    final title =
                    context
                        .read<TyphoidBloc>()
                        .state
                        .fields['Title'];

                    // Store the captured form data in the BLoC
                    context
                        .read<TyphoidBloc>()
                        .add(UpdateField('dateReported', dateReported));
                    context
                        .read<TyphoidBloc>()
                        .add(UpdateField('reportedBy', reportedBy));
                    context
                        .read<TyphoidBloc>()
                        .add(UpdateField('investigatedBy', investigatedBy));
                    context
                        .read<TyphoidBloc>()
                        .add(UpdateField('title', title));
                    // ...add more fields as needed

                    _nextPage(); // Navigate to the next page
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
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKeyPage2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. Case Identification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Patient name",
                        "patientName",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Other Given name",
                        "otherGivenName",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Father's name",
                        "fatherName",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField(
                        "Date of Birth",
                        "dateOfBirth",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Age (Years / Months)",
                        "age",
                        keyboardType: TextInputType.number,
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Tel/Mobile",
                        "mobile",
                        keyboardType: TextInputType.number,
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Mother's name",
                        "motherName",
                        validator: _validateRequired,
                      ),
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
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Address",
                        "address",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Landmark",
                        "landmark",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Planning unit(PHC/UPHC)",
                        "planningUnit",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Village/Mohalla",
                        "villageMohalla",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "HRA",
                        "hra",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                        ['Hindu', 'Muslim', 'Other'],
                        "Religion",
                        "Religion",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Panchayat/Ward No",
                        "panchayatWardNo",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Caste",
                        "caste",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Id No",
                        "idNo",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Block/Urban area",
                        "blockUrbanArea",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "District",
                        "district",
                        validator: _validateRequired,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                        ['Urban', 'Rural'],
                        "Setting",
                        "setting",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "State",
                        "state",
                        validator: _validateRequired,
                      ),
                    ),
                  ],
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
        ));
  }

  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("3. Hospitalization",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField(
                "Name of Hospital",
                "hospitalName",
                validator: _validateRequired,
              ),
              _buildDateField(
                "Date of Admission",
                "dateOfAdmission",
              ),
              _buildDateField(
                "Date of Discharge/LAMA/Death",
                "dateOfDischarge",
              ),
              Text("4. Vaccination Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                [
                  'RI Card',
                  'Any Record or Register',
                  'Recall',
                  'Both RI card and recall'
                ],
                "Source of vaccination status",
                "sourceOfVaccinationStatus",
              ),
              _buildTextField(
                "No. of doses of pentavalent vaccine received",
                "dosesPentavalent",
              ),
              _buildTextField(
                "No. of doses of PCV received",
                "dosesPCV",
              ),
              _buildTextField(
                "No. of doses of M/MR/MMR vaccine received",
                "dosesMMR",
              ),
              _buildTextField(
                "No. of doses of typhoid vaccine received",
                "dosesTyphoid",
              ),
              _buildDateField(
                "Date of 1st dose of typhoid vaccine",
                "date1stDoseTyphoid",
              ),
              _buildDateField(
                "Date of 2nd dose of typhoid vaccine",
                "date2ndDoseTyphoid",
              ),
              SizedBox(height: 16),
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
        ),
      ),
    );
  }

  Widget _buildPage4() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKeyPage4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("5. Clinical Symptoms:",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16),
              _buildTextField(" Duration of illness in days ",
                  " Age at diagnosis of PID: "),
              _buildDateField(
                  "Date of Onset of fever", "Date of Onset of fever"),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                  'Unknown',
                ],
                "Fever for at least three out of seven consecutive days",
                "Fever for at least three out of seven consecutive days",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Maculo-papular Rash",
                "Maculo-papular Rash",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Malaise",
                "Malaise",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Headache",
                "Headache",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Abdominal discomfort",
                "Abdominal discomfort",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Diarrhoea:",
                "Diarrhoea:",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Constipation:",
                "Constipation:",
              ),
              _buildDropdownField(
                [
                  ' Intestinal hemorrhage',
                  'intestinal perforation',
                  ' encephalopathy',
                  'hemodynamic shock',
                ],
                "Complication",
                "Complication",
              ),
              _buildTextField(" Others ", "  otherComplication "),
              Text("On examination/investigation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                  'not palpated ',
                ],
                "Liver enlarged:",
                "Liver enlarged:",
              ),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                  'not palpated ',
                ],
                "Spleen enlarged:",
                "Spleen enlarged",
              ),
              _buildTextField("Pulse per minute ", "  Pulse per minute "),
              Text("WASH practices: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField([
                'Piped water in home',
                ' public tap ',
                'water tanker  ',
                ' hand pump or bore-well',
              ], "Source of drinking water supply",
                  "Source of drinking water supply"),
              _buildTextField(
                  " other sources (specify) ", " other sources (specify) "),
              _buildDropdownField(
                [
                  'YES',
                  'NO',
                ],
                "Toilet in the house",
                "Toilet in the house",
              ),
              _buildDropdownField(
                [' All members', ' Few members ', 'None of the members'],
                "Handwashing practice: Use of soap after defecation:",
                "Handwashing practice: Use of soap after defecation:",
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
        ),
      ),
    );
  }

  Widget _buildPage5() {
    String? _antibioticStarted; // State variable for dropdown selection

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKeyPage5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "6.Treatment History:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              Text(
                "7.Contact History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      ['Yes', 'No'],
                      "Similar symptoms in other household contact(s):",
                      "Similar symptoms in other household contact(s):",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "If yes, No. of sick contacts:",
                      "If yes, No. of sick contacts:",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                ['Yes', 'No'],
                "Similar symptoms in neighbourhood/school contact(s):",
                "Similar symptoms in neighbourhood/school contact(s):",
              ),
              _buildTextField(
                "If yes, No. of sick contacts in neighbourhood:",
                "If yes, No. of sick contacts in neighbourhood:",
              ),
              SizedBox(height: 16),
              Text(
                "9. Specimen Collection:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rapid diagnostic :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                        _buildTextField(
                          "Amount",
                          "Amount",
                        ),
                        _buildDateField(
                            "Date Collected", "Date Collected Rapid"),
                        _buildDateField("Date Sent", "Date Sent Rapid"),
                        _buildTextField(
                          "Name of Lab",
                          "Name of Lab",
                        ),
                        _buildDropdownField(
                          ['Good', 'Poor'],
                          "Condition",
                          "Condition rapid",
                        ),
                        _buildDateField(
                            "Date of Result", "Date of Result for rapid"),
                        _buildDropdownField(
                          [
                            'Typhoid',
                            'Paratyphoid A',
                            'Paratyphoid B',
                            'Paratyphoid C',
                            'Negative',
                            'Other'
                          ],
                          "Laboratory Result ",
                          "Laboratory Result rapid",
                        ),
                        _buildTextField(
                          "Other",
                          "Other  rapid",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood culture:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                        _buildTextField(
                          "Amount",
                          "Amount",
                        ),
                        _buildDateField("Date Collected", "Date Collected"),
                        _buildDateField("Date Sent", "Date Sent"),
                        _buildTextField(
                          "Name of Lab",
                          "Name of Lab",
                        ),
                        _buildDropdownField(
                          ['Good', 'Poor'],
                          "Condition",
                          "Condition",
                        ),
                        _buildDateField("Date of Result", "Date of Result"),
                        _buildDropdownField(
                          [
                            'Typhoid',
                            'Paratyphoid A',
                            'Paratyphoid B',
                            'Paratyphoid C',
                            'Negative',
                            'Other'
                          ],
                          "Laboratory Result",
                          "Laboratory Result",
                        ),
                        _buildTextField(
                          "Other",
                          "Other",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "10.Active Case Search and Response in Community: Act",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDateField(
                  "If yes, Date of search", "If yes, Date of search"),
              _buildTextField(
                "Number of households verified:",
                "Number of households verified:",
              ),
              _buildTextField(
                "Number of suspected cases found:",
                "Number of suspected cases found:",
              ),
              _buildDropdownField(
                ['typhoid', 'coliform', 'Not tested', 'Not known'],
                "Water source tested for:",
                "Water source tested for",
              ),
              _buildDropdownField(
                [
                  'typhoid positive',
                  'coliform positive',
                  'Both negative',
                ],
                "If yes, findings:",
                "If yes, findings:",
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
        ),
      ),
    );
  }

  Widget _buildPage6() {
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
            BlocBuilder<TyphoidBloc, TyphoidState>(
              builder: (context, state) {
                final outcome = state.fields["Outcome"] ?? '';

                if (outcome == 'Death') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      _buildDateField(
                          "if died, date of death:", "if died, date of death:"),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 16),
            Text(
              "13.Travel History 0 to 28",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            BlocBuilder<TyphoidBloc, TyphoidState>(
              builder: (context, state) {
                // Ensure that 'selectedNumber' is initialized as an integer
                final selectedNumber =
                (state.fields["selectedNumber"] ?? 0) as int;

                return Slider(
                  value: selectedNumber.toDouble(),
                  // Current slider value
                  min: 0,
                  // Minimum value the slider can select
                  max: 28,
                  // Maximum value the slider can select
                  divisions: 28,
                  // Number of discrete divisions on the slider
                  label: selectedNumber
                      .toString(),
                  // Label showing the selected number
                  onChanged: (double newValue) {
                    // Triggered when the user selects a new value
                    context
                        .read<TyphoidBloc>()
                        .add(UpdateField('selectedNumber', newValue.toInt()));
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              "Case definition of suspected typhoid fever:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Add the Submit button at the bottom
            ElevatedButton(
              onPressed: () {
                final typhoidBloc = context.read<TyphoidBloc>();

                // Trigger the form submission
                typhoidBloc.add(SubmitForm());

                // Show a success message using a SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Submitted successfully'),
                    duration: Duration(
                        seconds: 2), // You can adjust the duration if needed
                  ),
                );

                // After submission, navigate to the next page with the form data
              },
              child: Text("Submit"),
            ),
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
          context.read<TyphoidBloc>().add(
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
          child: BlocBuilder<TyphoidBloc, TyphoidState>(
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

  Widget _buildDropdownField(List<String> items,
      String labelText,
      String fieldName, {
        ValueChanged<String?>? onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<TyphoidBloc, TyphoidState>(
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
                context.read<TyphoidBloc>().add(
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
    return BlocBuilder<TyphoidBloc, TyphoidState>(
      builder: (context, state) {
        final selectedIndex = state.fields['selectedIndex'] as int? ?? 0;

        return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<TyphoidBloc>().add(
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