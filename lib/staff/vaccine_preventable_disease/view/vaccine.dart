// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/staff/homepage/view/DiseaseScreen.dart';
import 'package:untitled/staff/vaccine_preventable_disease/bloc/vaccine_bloc.dart';
import 'package:untitled/staff/vaccine_preventable_disease/bloc/vaccine_event.dart';
import 'package:untitled/staff/vaccine_preventable_disease/bloc/vaccine_state.dart';



class Vaccine extends StatefulWidget {
  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {

String? nodelivery;
String? anysubstance;
String? specimen;
String? antitoxin;
String? labc;
String? householdcontact;
String? sickcontact;
String? datecross;
String? nospecimen;
String? vaccinestatus;
String? casesearch;
String? datesearch;
String? deathdate;


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
      context.read<VaccineBloc>().add(
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
        title: Text('Vaccine Preventable Disease'),
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

              Text("Vaccine Administration",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text("1. Reporting / Investigation Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
                _buildDateField("Date Case Reported", "Date Case Reported"),
              _buildTextField("Reported By", "Reported By"),
              _buildTextField("Title", "Title"),
              _buildDateField(
                  "Date Case Investigated", "Date Case Investigated"),
              _buildTextField("Investigated By", "Investigated By"),
              _buildDateField("Date of Desk Review", "Date of Desk Review"),
              _buildTextField("Reviewed By", "Reviewed By"),
              _buildDropdownField(['SMO', 'DIO', 'DSO','Medical Officer ','Nodal Officer ','Other'], "Title", "Title"),
              _buildDropdownField(
                  ['RU  ', 'Informer  ', 'Other  ', 'ACS (facility)  ','Community Search	'],
                  "Reporting Health Facility",
                  "Reporting Health Facility"),
                   _buildDropdownField(
                  ['Govt. Allopathic  ', 'Pvt Allopathic    ', 'ISM Pract  ', 'ACS (facility)  ','Others	'],
                  "Setup",
                  "Setup"),
                   SizedBox(height: 16),
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
              _buildTextField("State", "state"),
              _buildTextField("Pincode", "pincode"),
              _buildTextField("Mobile", "mobile"),
              _buildTextField("Mail ID", "mailId"),
            
                   _buildDropdownField(
                  ['YES', 'NO', 'UNKNOWN'],  "Patient belongs to migratory family/community",
                  "Patient belongs to migratory family/community"),
                  BlocBuilder<VaccineBloc, VaccineState>(
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
                  "Date of Admission", "Date of Admission"),
              _buildDateField("Date of Discharge/LAMA/Death",
                  "Date of Discharge/LAMA/Death"),

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
              Text("4. Vaccination Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(' If vaccinated, encircle vaccines received irrespective of age when they were received',
               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
              ),

              Text('At Birth',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
              
      _buildDropdownField(
                  ['YES', 'NO'], "OPV 0", "OPV 0"),

                    _buildDropdownField(
                ['YES', 'NO'],  "BCG", "BCG"),
                    _buildDropdownField(
                  ['YES', 'NO'], "HepB 0", "HepB 0"),
                 




                Text('6 weeks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
               
                    _buildDropdownField(
                ['YES', 'NO'],  "OPV 1", "OPV 1"),
                    _buildDropdownField(
                  ['YES', 'NO'], "DPT 1", "DPT 1"),
                    _buildDropdownField(
            ['YES', 'NO'],  "Pentavalent 1", "Pentavalent 1"),
             _buildDropdownField(
            ['YES', 'NO'],  "HepB 1", "HepB 1"),
             _buildDropdownField(
            ['YES', 'NO'],  "f-IPV 1", "f-IPV 1"),
             _buildDropdownField(
            ['YES', 'NO'],  "PCV 1", "PCV 1"),
             _buildDropdownField(
            ['YES', 'NO'],  "Rotavirus 1", "Rotavirus 1"),





                  Text('10 weeks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                   _buildDropdownField(
                  ['YES', 'NO',], "DPT Booster", "DPT Booster"),

                          
                              _buildDropdownField(
                  ['YES', 'NO'], "OPV 2", "OPV 2"),
                    _buildDropdownField(
                  ['YES', 'NO'],  "DPT 2", "DPT 2"),
                    _buildDropdownField(
                ['YES', 'NO'],  "Pentavalent 2", "Pentavalent 2"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Hep B 2", "Hep B 2"),
                    _buildDropdownField(
            ['YES', 'NO'],  "Rotavirus 2", "Rotavirus 2"),



                    Text('14 weeks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                     _buildDropdownField(
            ['YES', 'NO'],  "OPV 3", "OPV 3"),
             _buildDropdownField(
            ['YES', 'NO'],  "DPT 3", "DPT 3"),


                        
                              _buildDropdownField(
                  ['YES', 'NO'], "Pentavalent 3", "Pentavalent 3"),
                    _buildDropdownField(
                  ['YES', 'NO'],  "HepB 3", "HepB 3"),
                    _buildDropdownField(
                ['YES', 'NO'],  "f-IPV 2  /  IM-IPV", "f-IPV 2  /  IM-IPV"),
                    _buildDropdownField(
                  ['YES', 'NO'], "PCV 2", "PCV 2"),
                    _buildDropdownField(
            ['YES', 'NO'],  "Rotavirus 3", "Rotavirus 3"),



                      Text('9 Month',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
  _buildDropdownField(
                  ['YES', 'NO',], "DPT Booster", "DPT Booster"),

                          
                              _buildDropdownField(
                  ['YES', 'NO'], "M1/MR1", "M1/MR1"),
                    _buildDropdownField(
                  ['YES', 'NO'],  "MMR1/MMRV1 ", "MMR1/MMRV1 "),
                    _buildDropdownField(
                ['YES', 'NO'],  "JE 1", "JE1"),
                    _buildDropdownField(
                  ['YES', 'NO'], "PCV Booster", "PCV Booster"),
                    _buildDropdownField(
            ['YES', 'NO'],  "f-IPV 3", "f-IPV 3"),



                        Text('16 Month',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                           _buildDropdownField(
                  ['YES', 'NO',], "DPT Booster", "DPT Booster"),

                           
                              _buildDropdownField(
                  ['YES', 'NO'], "M2/MR2", "M2/MR2"),
                    _buildDropdownField(
                  ['YES', 'NO'],  "MMR2", "MMR2"),
                    _buildDropdownField(
                ['YES', 'NO'],  "DPT Booster", "DPT Booster"),
                    _buildDropdownField(
                  ['YES', 'NO'], "OPV Booster", "OPV Booster"),
                    _buildDropdownField(
            ['YES', 'NO'],  "JE 2", "JE 2"),



                          Text('5 Year',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),

                            _buildDropdownField(
                  ['YES', 'NO',], "DPT Booster", "DPT Booster"),

                           

             Text('Other',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),

             
                              _buildDropdownField(
                  ['YES', 'NO'], "Td 10", "Td 10"),
                    _buildDropdownField(
                  ['YES', 'NO'],  "Td 16", "Td 16"),
                    _buildDropdownField(
                ['YES', 'NO'],  "Tdap", "Tdap"),
                    _buildDropdownField(
                  ['YES', 'NO'], "TT", "TT"),
                    _buildDropdownField(
            ['YES', 'NO'],  "HPV", "HPV"),





                 _buildDropdownField(
                  ['RI Card ', 'Any Record or Register','Recall ','Both recall and register ','Other'], "Source of vaccination status", "Source of vaccination status"),
                  BlocBuilder<VaccineBloc, VaccineState>(
  builder: (context, state) {
    final vaccinestatus = state.fields["Source of vaccination status"];
    return vaccinestatus == 'Other'
        ? _buildTextField(
           "Specify ", "Specify "
          )
        : SizedBox.shrink();
  },
),         
              
              _buildDropdownField(['Yes ', 'No','Unknown ',],
               "Has the case ever received one or more vaccines (of any listed below) in his or her lifetime?  ", "Has the case ever received one or more vaccines (of any listed below) in his or her lifetime?  "),
              _buildDateField("Date of last dose of diphtheria or pertussis-containing vaccine: For diphtheria (DPT,Pentavalent, Td or Tdap); For pertussis (DPT, Pentavalent, Tdap)  ", "Date of last dose of diphtheria or pertussis-containing vaccine: For diphtheria (DPT,Pentavalent, Td or Tdap); For pertussis (DPT, Pentavalent, Tdap)  "),
              _buildDropdownField(['0', '1','3 ','Booster ','Unknown'], "In case of NNT - Vaccination of mother during pregnancy:	Tetanus Toxoid (TT/Td)", "In case of NNT - Vaccination of mother during pregnancy:	Tetanus Toxoid (TT/Td)"),
              _buildDateField("Date of Last Dose of TT/Td", "Date of Last Dose of TT/Td"),
             
              
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
    return Form(
      key: _formKeyPage4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("5. Clinical Symptoms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
        
              _buildTextField("Duration of illness in days", "Duration of illness in days"),
               _buildDateField("Date of onset ", "Date of onset"),
              Text('Diphtheria'),
              _buildDateField("Date of onset of sore throat ", "Date of onset of sore throat "),
                _buildDropdownField(
                  ['YES', 'NO'], "Fevert", "Fever"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Greyish white adherent membrane in throat", "Greyish white adherent membrane in throat"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Bloody nasal discharge", "Bloody nasal discharge"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Hoarseness of voice", "Hoarseness of voice"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Bull neck", "Bull neck"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Nasal regurgitation", "Nasal regurgitation"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Difficulty in swallowing", "Difficulty in swallowing"),
                  _buildDropdownField(
                  ['YES', 'NO'], "Difficulty in breathing", "Difficulty in breathing"),








              Text('Pertussis'),
              _buildDateField("Date of onset of cough  ", "Date of onset of cough "),
                _buildDropdownField(
                  ['YES', 'NO'], "Duration of cough: Cough >2 weeks", "Duration of cough: Cough >2 weeks"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Paroxysms of cough", "Paroxysms of cough"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Cough leading to vomiting", "Cough leading to vomiting"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Whoop", "Whoop"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Apnoea", "Apnoea"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Cyanosis", "Cyanosis"),
                    _buildDropdownField(
                  ['YES', 'NO'], "History of active TB / other chronic URTI", "History of active TB / other chronic URTI"),
                    _buildDropdownField(
                  ['YES', 'NO'], "Clinician suspicion of pertussis", "Clinician suspicion of pertussis"),
                 






              Text('Neonatal Tetanus'),
              _buildDateField("Date of onset of inability to suck", "Date of onset of inability to suck"),
                 _buildDropdownField(
                  ['YES', 'NO'], "Child sucked and cried normally at 0-2 days", "Child sucked and cried normally at 0-2 days"),

                     _buildTextField("Onset of following symptom(s) at 3-28 days of age ", "Onset of following symptom(s) at 3-28 days of age"),
                     _buildDropdownField(
                  ['YES', 'NO'], "Inability to suck and cry", "Inability to suck and cry"),
                     _buildDropdownField(
                  ['YES', 'NO'], "Stiffness", "Stiffness"),
                     _buildDropdownField(
                  ['YES', 'NO',], "Spasms / Seizures ", "Spasms / Seizures "),
                  BlocBuilder<VaccineBloc, VaccineState>(
  builder: (context, state) {
    final spasms = state.fields["Spasms / Seizures"];
    return spasms == 'YES'
        ? _buildDropdownField(
            ['YES', 'NO'], 
            "Precipitated by stimuli", 
            "precipitated_by_stimuli"
          )
        : SizedBox.shrink();
  },
),
                     _buildDropdownField(
                  ['Institutional ', 'Home ','Other '], "No Delivery", "No Delivery"),
                  BlocBuilder<VaccineBloc, VaccineState>(
                  builder: (context, state) {
                  final nodelivery = state.fields["No Delivery"];
                 return nodelivery == 'Other '
                    ?   _buildTextField("Specify ", "Specify")
                  : SizedBox.shrink();
                   },
                   ),
                 _buildDropdownField(
                  ['None  ', 'Medicine  ','Other '], "Any substance applied on cord", "Any substance applied on cord"),
                  BlocBuilder<VaccineBloc, VaccineState>(
                  builder: (context, state) {
                  final anysubstance = state.fields["Any substance applied on cord"];
                 return anysubstance == 'Other '
                    ?   _buildTextField("Specify ", "Specify")
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
              Text("6. Treatment History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Antibiotic given", "Antibiotic given"),
                  BlocBuilder<VaccineBloc, VaccineState>(
  builder: (context, state) {
    final specimen = state.fields["Antibiotic given"];
    return specimen == 'YES'
        ? _buildDropdownField(
            ['Yes  ', 'NO', 'Unknown','Not Applicable (not a diphtheria case)'], 
            "Diphtheria Antitoxin (DAT)", 
            "Diphtheria Antitoxin (DAT)"
          )
        : SizedBox.shrink();
  },
),         

  _buildTextField("Dose of DAT", "Dose of DAT"),


     _buildDropdownField(
                  ['DAT not available   ','Other '], "Reason for not giving antitoxin", "Reason for not giving antitoxin"),
                  BlocBuilder<VaccineBloc, VaccineState>(
                  builder: (context, state) {
                  final antitoxin = state.fields["Reason for not giving antitoxin"];
                 return antitoxin == 'Other '
                    ?   _buildTextField("Specify ", "Specify")
                  : SizedBox.shrink();
                   },
                   ),














            
              Text("7. Contact History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "History of contact with a laboratory confirmed case", "History of contact with a laboratory confirmed case"),
              BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final lab = state.fields["History of contact with a laboratory confirmed case"];
                  return  lab == 'YES'
                      ? _buildTextField("EPID No of laboratory confirmed case", "EPID No of laboratory confirmed case")
                      : SizedBox.shrink();
                },
              ),
              
             
              _buildDropdownField(
                  ['YES', 'NO',], "Similar symptoms in other household contact(s)", "Similar symptoms in other household contact(s)"),

                    BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final householdcontact = state.fields["Similar symptoms in other household contact(s)"];
                  return  householdcontact == 'YES'
                      ? _buildTextField("No. of sick contacts", "No. of sick contacts")
                      : SizedBox.shrink();
                },
              ),
              
              _buildDropdownField(
                  ['YES', 'NO',], "Similar symptoms in other neighbourhood/ work/ school contact(s)", "Similar symptoms in other neighbourhood/ work/ school contact(s)"),

                    BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final sickcontact = state.fields["Similar symptoms in other neighbourhood/ work/ school contact(s)"];
                  return  sickcontact == 'YES'
                      ? _buildTextField("No. of sick contacts", "No. of sick contacts")
                      : SizedBox.shrink();
                },
              ),
              
             





              Text("8. Travel History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              
               BlocBuilder<VaccineBloc, VaccineState>(
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
                  label: selectedNumber.toString(),
                  // Label showing the selected number
                  onChanged: (double newValue) {
                    // Triggered when the user selects a new value
                    context
                        .read<VaccineBloc>()
                        .add(UpdateField('selectedNumber', newValue.toInt()));
                  },
                );
              },
            ),

               _buildDropdownField(
                  ['YES', 'NO',], "Requires cross notification?  ", "Requires cross notification?  "),

                    BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final datecross = state.fields["Requires cross notification?  "];
                  return  datecross == 'YES'
                      ? _buildDateField("date of cross notification", "date of cross notification")
                      : SizedBox.shrink();
                },
              ),

               _buildTextField("District of residence", "District of residence"),
                _buildTextField("Block/ Urban area of residence", "Block/ Urban area of residence"),
              
             






            
              Text("9. History of contacts with healthcare providers after the date of onset ( including  reporting health facility):",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

                 _buildTextField("Name & address of Hospital/ doctor", "Name & address of Hospital/ doctor"),
                 _buildTextField("Phone no. / Email ID", "Phone no. / Email ID"),

                  _buildDateField("Dates case visited", "Dates case visited"),



                   _buildDropdownField(
                  ['YES', 'NO',], "Already RU/informer?  ", "Already RU/informer?  "),
                    _buildDropdownField(
                  ['YES', 'NO',], "Did they report this case?  ", "Did they report this case? "),
                   _buildDateField("Date of sensitization visit/ Actions taken to improve case reporting", "Date of sensitization visit/ Actions taken to improve case reporting"),
                 

              Text("10. Specimen Collection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              Text('Throat swab (Diphtheria)' , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),



                _buildTextField("Number", "Number"),
                  _buildDateField("Date Collected    ", "Date Collected "),


                     GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    hintText: 'Select time',
                    suffixIcon: Icon(Icons.access_time),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),




              _buildDateField("Date Sent", "Date Sent"),
                      _buildTextField("Name of Lab", "Name of Lab"),
                        _buildDateField("Dates case visited", "Dates case visited"),

                  _buildDropdownField( ['Good ', 'Poor ',],
                   "Condition", "Condition  "),
                    _buildDropdownField( ['Positive ','Negative ','Other'],
                   "Laboratory Result", "Laboratory Result  "),


                 Text('Nasopharyngeal swab (Pertussis)' , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),



                 
                _buildTextField("Number", "Number"),
                  _buildDateField("Date Collected    ", "Date Collected "),
                    _buildTimeField(context, "Select time", "time_field"),
              _buildDateField("Date Sent", "Date Sent"),
                      _buildTextField("Name of Lab", "Name of Lab"),
                        _buildDateField("Dates case visited", "Dates case visited"),

                  _buildDropdownField( ['Good ', 'Poor ',],
                   "Condition", "Condition  "),
                    _buildDropdownField( ['Positive ','Negative ','Other'],
                   "Laboratory Result", "Laboratory Result  "),

                    Text('Serum (Pertussis)',  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),



                    
                _buildTextField("Number", "Number"),
                  _buildDateField("Date Collected    ", "Date Collected "),


          
                   _buildTimeField(context, "Select time", "time_field"),




              _buildDateField("Date Sent", "Date Sent"),
                      _buildTextField("Name of Lab", "Name of Lab"),
                        _buildDateField("Dates case visited", "Dates case visited"),

                  _buildDropdownField( ['Good ', 'Poor ',],
                   "Condition", "Condition  "),
                    _buildDropdownField( ['Positive ','Negative ','Other'],
                   "Laboratory Result", "Laboratory Result  "),
                    
                  _buildDropdownField( ['Death    ', 'Not willing    ','Lost to follow-up  ','Logistic issue ','Late notification   ','Other'],
                   "If no specimen is collected, reason for not collecting specimen", "If no specimen is collected, reason for not collecting specimen  "),

                    BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final nospecimen = state.fields["If no specimen is collected, reason for not collecting specimen "];
                  return  nospecimen == 'Other'
                      ? _buildTextField("specify", "specify")
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
      child: Form(
        key: _formKeyPage6,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Text("11. Name of Govt Health Facility responsible for Active Case Search, Contact Tracing and Response in Community",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
            _buildDropdownField(
                  ['YES', 'NO',], "Active case search in community done", "Active case search in community done"),
                  BlocBuilder<VaccineBloc, VaccineState>(
  builder: (context, state) {
    final casesearch = state.fields["Active case search in community done"];
    return casesearch == 'YES'
        ? _buildDateField(
           "Date of search", "Date of search"
          )
        : SizedBox.shrink();
  },
),         
             
              _buildTextField("Number of individuals verified", "Number of individuals verified"),
              _buildTextField("Number of contacts identified", "Number of contacts identified"),
              _buildTextField("Number of contacts received antibiotics", "Number of contacts received antibiotics"),
              _buildTextField("Number of suspected cases found", "Number of suspected cases found"),
              _buildTextField("Number of susceptibles vaccinated", "Number of susceptibles vaccinated"),


              Text("12. Final Classification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
           _buildDropdownField(['Laboratory confirmed   ', 'Epi-linked   ','Clinically compatible    ','Rejected  ','Confirmed NNT'],
                  "Final Classification", "Final Classification"),
              Text("13. 60 Day follow-up (telephonic)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDateField(
           "Date of follow-up", "Date of follow-up"
          ),
   _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Antibiotic given", "Antibiotic given"),
                  BlocBuilder<VaccineBloc, VaccineState>(
  builder: (context, state) {
    final deathdate = state.fields["Antibiotic given"];
    return deathdate == 'YES'
        ? _buildDateField(
           "Death date", "Death date"
          )
        : SizedBox.shrink();
  },
),         

              Text("14. Complications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(
           "At anytime during illness or follow up", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
          ),

              _buildDropdownField(['Myocarditis ', 'Paralysis ','Peripheral neuropathy ','Pneumonia ','Otitis media ','Respiratory insufficiency ','Other'], "Complications of Diphtheria", "Complications of Diphtheria"),
              _buildTextField("Final Comments", "finalComments"),
              _buildDropdownField(['Myocarditis ', 'Paralysis ','Peripheral neuropathy ','Pneumonia ','Otitis media ','Respiratory insufficiency ','Other'], "Complications of Pertussis", "Complications of Pertussis"),

              _buildDropdownField(['Residual weakness ', 'Delayed milestones ','Other '],
                  "Complications of Neonatal Tetanus", "Complications of Neonatal Tetanus"),



           ElevatedButton(
                onPressed: () {
                  final paralysisBloc = context.read<VaccineBloc>();

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
      child: Text("Profile Page"),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Text(" Menu Page"),
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
          context.read<VaccineBloc>().add(
            UpdateField(fieldName, value),
          );
        },
      ),
    );
  }
  String? _validateRequired(String? value) {
  return value == null || value.isEmpty ? 'Please select a time' : null;
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
      context.read<VaccineBloc>().add(
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
      validator: validator ?? _validateRequired, // Apply validation
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
      child: BlocBuilder<VaccineBloc, VaccineState>(
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
                context.read<VaccineBloc>().add(
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
      child: BlocBuilder<VaccineBloc, VaccineState>(
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



