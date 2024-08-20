import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/homepage/view/DiseaseScreen.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_bloc.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_event.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_state.dart';


class Vaccine extends StatefulWidget {
  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
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
        title: Text('Acute Flaccid Paralysis'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSlider(), // Call the separate slider method
          Expanded(
            child: PageView(
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
              _buildDateField("Date Vaccine Administered", "Date Vaccine Administered"),
              _buildTextField("Administered By", "Administered By"),
              _buildTextField("Vaccine Type", "Vaccine Type"),
              _buildDateField("Date of Last Dose", "Date of Last Dose"),
              _buildDropdownField(['Routine', 'SIA'], "Type of Vaccination", "Type of Vaccination"),
              Text("2. Patient Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField("Patient Name", "patientName"),
              _buildTextField("Date of Birth", "dateOfBirth"),
              _buildTextField("Age (Years / Months)", "age", keyboardType: TextInputType.number),
              _buildTextField("Contact Number", "contactNumber", keyboardType: TextInputType.number),
              _buildTextField("Address", "address"),
              _buildDropdownField(['Male', 'Female'], "Sex", "Sex"),
              _buildTextField("Email ID", "emailId"),
              _buildDropdownField(['Urban', 'Rural'], "Setting", "setting"),
              _buildTextField("State", "state"),
              _buildTextField("Pincode", "pincode"),
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
              _buildDropdownField(['RI Card ', 'Any Record or Register ','Recall ','Both recall and register ','Other'], "Has the case ever received one or more vaccines (of any listed below) in his or her lifetime?  ", "Has the case ever received one or more vaccines (of any listed below) in his or her lifetime?  "),
              _buildTextField("Number of Doses Received", "numberOfDoses"),
              _buildDateField("Date of Last Dose", "dateOfLastDose"),
              _buildDropdownField(['RI Card ', 'Any Record or Register ','Recall ','Both recall and register ','Other'], "Source of vaccination status", "Source of vaccination status"),
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
              _buildDropdownField(['Yes', 'No'], "Adverse Event", "adverseEvent"),
              BlocBuilder<VaccineBloc, VaccineState>(
                builder: (context, state) {
                  final adverseEventValue = state.fields["adverseEvent"];
                  return adverseEventValue == 'Yes'
                      ? _buildTextField("Details of Adverse Event", "detailsOfAdverseEvent")
                      : SizedBox.shrink();
                },
              ),
              _buildTextField("Duration of illness in days", "Duration of illness in days"),
              Text('Diphtheria'),
              _buildDateField("Date of onset of sore throat ", "Date of onset of sore throat "),
              Text('Pertussis'),
              _buildDateField("Date of onset of cough  ", "Date of onset of cough "),
              Text('Neonatal Tetanus'),
              _buildDateField("Date of onset of inability to suck", "Date of onset of inability to suck"),
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

  Widget _buildPage5() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("6. Treatment History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Antibiotic given", "Antibiotic given"),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Antibiotic started before specimen collection", "Antibiotic started before specimen collection"),
              _buildDropdownField(
                  ['YES', 'NO'], "Hospitalization", "Hospitalization"),
              Text("7. Contact History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "History of contact with a laboratory confirmed case", "History of contact with a laboratory confirmed case"),
              _buildTextField("EPID No of laboratory confirmed case", "EPID No of laboratory confirmed case"),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Similar symptoms in other neighbourhood/ work/ school contact(s)", "Similar symptoms in other neighbourhood/ work/ school contact(s)"),
              _buildTextField("details", "details"),
              _buildTextField("No. of sick contacts", "No. of sick contacts"),
              _buildDropdownField(
                  ['YES', 'NO','Unknown'], "Similar symptoms in other household contact(s)", "Similar symptoms in other household contact(s)"),
              _buildTextField("No. of sick contacts", "No. of sick contacts"),
              _buildTextField("details", "details"),
              Text("8. Travel History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField("Follow-up Date", "followUpDate"),
              _buildTextField("Follow-up Remarks", "followUpRemarks"),
              Text("9. History of contacts with healthcare providers after the date of onset ( including  reporting health facility):",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text("10. Specimen Collection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

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
              _buildDropdownField(['Yes', 'No'],
                  "Active case search in community done", "Active case search in community done"),
              _buildDateField("Date of search", "Date of search"),
              _buildTextField("Number of individuals verified", "Number of individuals verified"),
              _buildTextField("Number of contacts identified", "Number of contacts identified"),
              _buildTextField("Number of contacts received antibiotics", "Number of contacts received antibiotics"),
              _buildTextField("Number of suspected cases found", "Number of suspected cases found"),
              _buildTextField("Number of susceptibles vaccinated", "Number of susceptibles vaccinated"),


              Text("12. Final Classification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDateField("Date of search", "Date of search"),
              _buildTextField("Number of individuals verified", "Number of individuals verified"),
              Text("13. 60 Day follow-up (telephonic",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              _buildDateField("Date of follow-up", "Date of follow-up"),

              Text("14. Complications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              _buildDropdownField(['Myocarditis ', 'Paralysis ','Peripheral neuropathy ','Pneumonia ','Otitis media ','Respiratory insufficiency ','Other'], "Complications of Diphtheria", "Complications of Diphtheria"),
              _buildTextField("Final Comments", "finalComments"),
              _buildDropdownField(['Myocarditis ', 'Paralysis ','Peripheral neuropathy ','Pneumonia ','Otitis media ','Respiratory insufficiency ','Other'], "Complications of Pertussis", "Complications of Pertussis"),

              _buildDropdownField(['Residual weakness ', 'Delayed milestones ','Other '],
                  "Complications of Neonatal Tetanus", "Complications of Neonatal Tetanus"),



              ElevatedButton(
                onPressed: () {
                  final vaccineBloc = context.read<VaccineBloc>();

                  // Trigger the form submission
                  vaccineBloc.add(SubmitForm());

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

  String? _validateRequired(String? value) {
    return value == null || value.isEmpty ? 'This field is required' : null;
  }
}



