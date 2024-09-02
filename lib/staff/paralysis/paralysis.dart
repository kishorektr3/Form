// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:untitled/staff/homepage/view/DiseaseScreen.dart';

import 'bloc_paralysis/bloc.dart';
import 'bloc_paralysis/event.dart';
import 'bloc_paralysis/state.dart';

class Paralysis extends StatefulWidget {
  @override
  _ParalysisState createState() => _ParalysisState();
}

class _ParalysisState extends State<Paralysis> {

  String? injectionsValue;
  String? settingvalue;
  String? ascent;
  String? Classification;
  String? finaldiagnosis;

  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  

  final TextEditingController titleController = TextEditingController();

int _selectedIndex = 0;
  double _sliderValue = 0;
  final int _totalPages = 6;
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
    titleController.dispose();
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
      context.read<ParalysisBloc>().add(
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


void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
      _pageController.jumpToPage(value.toInt());
    });
  }



 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text('Acute Flaccid Paralysis'),
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
          inactiveTrackColor: Colors.blueGrey[200],
          thumbColor: Colors.blueAccent,
          overlayColor: Colors.blueAccent.withOpacity(0.2),
          trackHeight: 4.0,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
        ),
        child: Slider(
          value: _sliderValue,
          min: 0,
          max: (_totalPages - 1).toDouble(),
          divisions: _totalPages - 1,
          label: (_sliderValue + 1).toInt().toString(),
          onChanged: _onSliderChanged,
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
              Text("1. Reporting / Investigation Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDateField("Date Case Reported", "Date Case Reported"),
              _buildTextField("Reported By", "Reported By"),
              _buildTextField("Title", "Title"),
              _buildDateField(
                  "Date Case Investigated", "Date Case Investigated"),
              _buildTextField("Investigated By", "Investigated By"),
               _buildDropdownField(['SMO', 'DIO', 'DSO','Medical Officer ','Nodal Officer ','Other'], "Title", "Title"),
              _buildDateField("Date Case verified by DIO/SMO", "Date Case verified by DIO/SMO"),
              _buildTextField("Name of DIO/SMO", "Name of DIO/SMO"),
             
              _buildDropdownField(
                  ['RU  ', 'Informer  ', 'Other  ', 'ACS (facility)  ','Community Search	'],
                  "Reporting Health Facility",
                  "Reporting Health Facility"),
                    _buildDropdownField(
                  ['VHP  ', 'HP  ', 'LP','Others	'],
                  "Category",
                  "Category"),
                   _buildDropdownField(
                  ['Govt. Allopathic  ', 'Pvt Allopathic    ', 'ISM Pract  ', 'ACS (facility)  ','Others	'],
                  "Setup",
                  "Setup"),


                          Text("2. Case Identification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              _buildDropdownField(['Male', 'Female'], "Sex", "Sex"),
              _buildTextField("Address", "address"),
              _buildTextField("Landmark", "landmark"),
              _buildTextField("Planning unit(PHC/UPHC)", "planningUnit"),
              _buildTextField("Village/Mohalla", "villageMohalla"),
              _buildTextField("HRA", "hra"),
              _buildDropdownField(
                  ['Hindu', 'Muslim', 'Other'], "Religion", "Religion"),
              _buildTextField("Panchayat/Ward No", "panchayatWardNo"),
              _buildTextField("Caste", "caste"),
              _buildTextField("Id No", "idNo"),
              _buildTextField("Block/Urban area", "blockUrbanArea"),
              _buildTextField("District", "district"),
              _buildDropdownField(['Urban', 'Rural'], "Setting", "setting"),
               BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final settingvalue = state
                      .fields["Setting"];
                  return settingvalue == 'Urban'
                      ? _buildTextField(
                      "default", "default")
                      : SizedBox.shrink();
                },
              ),
              _buildTextField("State", "state"),
              _buildTextField("Pincode", "pincode"),
              _buildTextField("Mobile", "mobile"),
              _buildTextField("Mail ID", "mailId"),
              _buildDropdownField(
                  ['YES', 'NO', 'UNKNOWN'],  "Patient belongs to migratory family/community",
                  "Patient belongs to migratory family/community"),
                  BlocBuilder<ParalysisBloc, ParalysisState>(
                  builder: (context, state) {
                  final anysubstance = state.fields["Patient belongs to migratory family/community"];
                 return anysubstance == 'YES '
                    ?     _buildTextField("Mail ID", "mailId")
                  : SizedBox.shrink();
                   },
                   ),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyPage1.currentState?.validate() ?? false) {
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

  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage2,
        child: SingleChildScrollView(
          child: Column(
            children: [
                    Text("3. Hospitalization",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['YES', 'NO'], "Hospitalization", "Hospitalization"),
                  
              _buildTextField("Name of Hospital", "Name of Hospital"),
              _buildDateField(
                  "Date of Hospitalization", "Date of Hospitalization"),
              _buildDateField("Diagnosis as per hospital records, if any",
                  "Diagnosis as per hospital records, if any"),
              SizedBox(height: 16),
              Text("4. Immunization History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField(
                  "a. OPV doses received through routine EPI (before onset)",
                  "a. OPV doses received through routine EPI (before onset)"),
              _buildTextField("b. OPV doses received through SIAs (before onset)",
                  "b. OPV doses received through SIAs (before onset)"),
              _buildTextField("Total OPV doses (a+b)", "Total OPV doses (a+b)"),
              _buildDateField("Date of last dose of OPV (before onset)",
                  "Date of last dose of OPV (before onset)"),
              _buildDateField(
                  "Date of last dose of OPV (before stool collection)",
                  "Date of last dose of OPV (before stool collection)"),
              _buildTextField("Number of f-IPV doses received (before onset)",
                  "Number of f-IPV doses received (before onset)"),
              _buildTextField("Number of f-IPV doses received (before onset)",
                  "Number of f-IPV doses received (before onset)"),
              _buildDateField("Date of last dose of f-IPV (before onset)",
                  "Date of last dose of f-IPV (before onset)"),
              _buildDateField("Date of last dose of IM-IPV (before onset)",
                  "Date of last dose of IM-IPV (before onset)"),
      
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){
                    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, child: Text("Previous")),
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
              
              Text("5. Clinical Symptoms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField("Number of days from onset to maximum paralysis",
                  "Number of days from onset to maximum paralysis"),
              _buildDateField("Date of Paralysis Onset)",
                  "Date of Paralysis Onset)"),
              _buildDropdownField(
                  ['Yes', 'No', 'Unknown'], "Acute paralysis", "Acute paralysis"),
              _buildDropdownField(['Yes', 'No', 'Unknown'],
                  "Flaccid paralysis (anytime during course of illness)",
                  "Flaccid paralysis (anytime during course of illness)"),
              _buildDropdownField(
                  ['Yes', 'No', 'Unknown'],
                  "Any Injections during 30 days before paralysis onset",
                  "Any Injections during 30 days before paralysis onset"),
              BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final injectionsValue = state
                      .fields["Any Injections during 30 days before paralysis onset"];
                  return injectionsValue == 'Yes'
                      ? _buildTextField(
                      "settingvalue", "settingvalue ")
                      : SizedBox.shrink();
                },
              ),
              _buildDropdownField(['Yes', 'No', 'Unknown'],
                  "Fever at onset of paralysis (anytime during 7 days before)",
                  "Fever at onset of paralysis (anytime during 7 days before)"),
              _buildDropdownField(
                  ['Yes', 'No', 'Unknown'], "Ascending paralysis", "Ascending paralysis"),
                   
              _buildDropdownField(
                  ['Yes', 'No', 'Unknown'], "Descending paralysis", "Descending paralysis"),
        
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){
                    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, child: Text("Previous")),
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage4,
        child: SingleChildScrollView(
          child: Column(
            children: [


              
              Text("6. Clinical history",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
             
              _buildDropdownField(
                  ['Yes', 'No'], "Respiratory involvement",
                  "Respiratory involvement"),
              _buildDropdownField(
                  ['Yes', 'No'], "Bulbar involvement",
                  "Bulbar involvement"),
              _buildDropdownField(
                  ['Yes', 'No'], "Bladder/bowel",
                  "Bladder/bowel"),
              _buildDropdownField(
                  ['Yes', 'No'], "Joint pain/Swelling",
                  "Joint pain/Swelling"),
                   _buildDropdownField(
                  ['Yes', 'No'], "Gait",
                  "Gait"),


              Text("7. Travel history",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              
              Text('Travel of child within 35 days prior to onset of paralysis (indicate dates and place of travel with arrows on dateline)'),
              SizedBox(height: 10,),


               BlocBuilder<ParalysisBloc, ParalysisState>(
              builder: (context, state) {
                // Ensure that 'selectedNumber' is initialized as an integer
                final selectedNumber =
                    (state.fields["selectedNumber"] ?? 0) as int;

                return Slider(
                  value: selectedNumber.toDouble(),
                  // Current slider value
                  min: 0,
                  // Minimum value the slider can select
                  max: 35,
                  // Maximum value the slider can select
                  divisions: 35,
                  // Number of discrete divisions on the slider
                  label: selectedNumber.toString(),
                  // Label showing the selected number
                  onChanged: (double newValue) {
                    // Triggered when the user selects a new value
                    context
                        .read<ParalysisBloc>()
                        .add(UpdateField('selectedNumber', newValue.toInt()));
                  },
                );
              },
            ),
              
              Text('Write dates of travel',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text('Write here places visited corresponding to the travel dates',style: TextStyle(fontWeight: FontWeight.bold),),
              _buildTextField(
                  "District of residence", "District of residence"),
              _buildDropdownField(
                  ['Yes', 'No'], "Requires cross notification?  ",
                  "Requires cross notification?  "),
              BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final injectionsValue = state
                      .fields["Requires cross notification? "];
                  return injectionsValue == 'Yes'
                      ? _buildDateField(
                      "date of cross notification ", "date of cross notification")
                      : SizedBox.shrink();
                },
              ),
              _buildTextField(
                  "Block/ Urban area of residence", "Block/ Urban area of residence"),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){
                    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, child: Text("Previous")),
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKeyPage5,
        child: SingleChildScrollView(
          child: Column(
            children: [

                Text("8. History of contacts with healthcare providers after the date of paralysis onset ( including the notifying health facility):",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      _buildTextField("Name",
                  "Name"),
                   _buildTextField("Mobile number",
                  "Mobile number"),
                   _buildTextField("Address of hospital",
                  "Address of hospital"),
                   _buildTextField("Doctor",
                  "Doctor"),
                   _buildTextField("quack",
                  "quack"),
                   _buildDateField("Dates case visited",
                  "Dates case visited"),
                    _buildDropdownField(
                  ['Yes','No'], "Already RU/informer ",
                  "Already RU/informer"),
                    _buildDropdownField(
                  ['Yes','No'], "Did they report this case ",
                  "Did they report this case"),
                 





                   _buildDateField("Action taken by SMO / Date of visit by SMO",
                  "Action taken by SMO / Date of visit by SMO"),



              Text("9. Clinical examination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                  ['Yes', 'No' , 'Unknown'], "Sensation loss",
                  "Sensation loss"),
              _buildDropdownField(
                  ['Yes', 'No' ,'Unknown'], "JAsymmetrical paralysis",
                  "Asymmetrical paralysis"),
              _buildDropdownField(
                  ['Yes', 'No',], "Hot AFP case",
                  "Hot AFP case"),
              _buildDropdownField(
                  ['right arm ', 'left arm ','right leg ','left leg ','neck ','bulbar ','respiratory muscle','trunk ','facial'], "Site(s) of Paralysis",
                  "Site(s) of Paralysis"),
              Text("10. Provisional diagnosis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                  ['Guillain-Barre Syndrome ', 'Transverse Myelitis  ','Traumatic Neuritis ','Transient Paralysis  ','Facial Palsy  ','bulbar ','other ','Unknown ',], "Provisional diagnosis",
                  "Provisional diagnosis"),

              BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final injectionsValue = state
                      .fields["Provisional diagnosis"];
                  return injectionsValue == 'other'
                      ? _buildTextField(
                      "Specify", "Specify")
                      : SizedBox.shrink();
                },
              ),
              Text("11. Contact stool",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                  ['Yes', 'No',], "Was this case eligible for contact stool collection",
                  "Was this case eligible for contact stool collection"),
              BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final injectionsValue = state
                      .fields["Was this case eligible for contact stool collection"];
                  return injectionsValue == 'Yes'
                      ? _buildTextField(
                      "date collected", "date collected")
                      : SizedBox.shrink();
                },
              ),


              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){
                    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, child: Text("Previous")),
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(key: _formKeyPage6,
        child: SingleChildScrollView(
          child: Column(
            children: [

                 Text("12. Stool Specimen Collection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   Text("Stool 1",
                  style: TextStyle(fontSize: 13),),
                   _buildDateField("Date Collected ",
                  "Date Collected "),
                _buildTimeField(context, "Time Collected", "Time Collected "),
                  _buildDateField("Date Sent ",
                  "Date Sent"),
                    _buildDateField("Date of Result",
                  "Date of Result"),
                    _buildDropdownField(
                  ['Good / P',], "Condition ",
                  "Condition"),
                    _buildDropdownField(
                  ['Good / P', 'P1','P2','P3','Wild/Vaccine','NPEV','Negative'], "Laboratory Result (circle) ",
                  " 	Laboratory Result (circle) "),

                   Text("Stool 2",
                  style: TextStyle(fontSize: 13),),
                   _buildDateField("Date Collected ",
                  "Date Collected "),
                _buildTimeField(context, "Time Collected", "Time Collected "),
                  _buildDateField("Date Sent ",
                  "Date Sent"),
                    _buildDateField("Date of Result",
                  "Date of Result"),
                    _buildDropdownField(
                  ['Good / P',], "Condition ",
                  "Condition"),
                    _buildDropdownField(
                  ['Good / P', 'P1','P2','P3','Wild/Vaccine','NPEV','Negative'], "Laboratory Result (circle) ",
                  " 	Laboratory Result (circle) "),


                    _buildDropdownField(
                  ['Late Notification', 'Late investigation','Delay in stool collection','Constipation','Death','Lost','Other'], "If Stool Not Collected in 14 days  why?  ",
                  " If Stool Not Collected in 14 days  why? "),



                  
              Text("13.	Name of Govt Health Facility Responsible for Active Case Search and Outbreak Response",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                  ['Yes', 'No',], "ORI done",
                  "ORI done"),
              _buildDropdownField(
                  ['Yes', 'No',], "Active case search in community done",
                  "Active case search in community done"),
              _buildDropdownField(
                  ['Yes', 'No',], "Additional AFP case found",
                  "Additional AFP case found"),
              _buildDateField("Date active case search conducted",
                  "Date active case search conducted"),
              Text("14.	60 Day Follow-up Examination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
              _buildDateField("Date of follow-up",
                  "Date of follow-up"),
              _buildDropdownField(
                  ['Yes', 'No',], "Residual weakness present",
                  "Residual weakness present"),
              _buildTextField(
                  "cause of death", "cause of death"),
              _buildDropdownField(
                  ['right arm ', 'left arm ','right leg ','left leg ','neck ','bulbar ','respiratory muscle','trunk ','facial'], "Site of weakness",
                  "Site of weakness"),
              Text("15.	Final Classification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                  ['Confirmed Polio ', 'Compatible ','Discarded'], "Final Classification",
                  "Final Classification"),
              BlocBuilder<ParalysisBloc, ParalysisState>(
                builder: (context, state) {
                  final Classification = state
                      .fields["Final Classification"];
                  return Classification == 'Compatible'
                      ? _buildTextField(
                      "reason", "reason")
                      : SizedBox.shrink();
                },
              ),
            
               _buildDropdownField  (
                  ['Guillain-Barre Syndrome ', 'Transverse Myelitis  ','Traumatic Neuritis ','Transient Paralysis  ','Facial Palsy  ','bulbar ','other ','Unknown ',], "Provisional diagnosis",
                  "Provisional diagnosis"),
                  BlocBuilder<ParalysisBloc, ParalysisState>(
  builder: (context, state) {
    final finaldiagnosis = state.fields["Provisional diagnosis"];
    return finaldiagnosis == 'other'
        ? _buildTextField(
           "Specify", "Specify"
          )
        : SizedBox.shrink();
  },
),      




                     ElevatedButton(
                onPressed: () {
                  final paralysisBloc = context.read<ParalysisBloc>();

                  // Trigger the form submission
                  paralysisBloc.add(SubmitForm());

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
      ),
    );
  }

  Widget _buildSearchPage() {
    return Center(
      child: Text("Menu Page"),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Text("Profile Page"),
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
          context.read<ParalysisBloc>().add(
            UpdateField(fieldName, value),
          );
        },

      ),
    );
  }
  String? _validateRequired(String? value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }


  
  Widget _buildTimeField(
    BuildContext context, String labelText, String fieldName,
    {String? Function(String?)? validator}) {
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      _timeController.text = picked.format(context);
      context.read<ParalysisBloc>().add(
        UpdateField(fieldName, _timeController.text),
      );
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: _timeController,
      readOnly: true, // Ensure the field is not directly editable
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
      ),
      validator: validator ?? _validateRequiredTime, // Apply validation
      onTap: _selectTime, // Show time picker when tapped
    ),
  );
}

String? _validateRequiredTime(String? value) {
  return value == null || value.isEmpty ? 'Please select a time' : null;
}





  Widget _buildDropdownField(List<String> items,
      String labelText,
      String fieldName, {
        ValueChanged<String?>? onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<ParalysisBloc, ParalysisState>(
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
                context.read<ParalysisBloc>().add(
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

  Widget _buildDateField(String label, String fieldName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<ParalysisBloc, ParalysisState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => _selectDate(context, fieldName),
            child: AbsorbPointer(
              child: TextFormField(
                controller: TextEditingController(
                  text: state.fields[fieldName] ?? '',
                ),
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
            ),
          );
        },
      ),
    );
  }


}

