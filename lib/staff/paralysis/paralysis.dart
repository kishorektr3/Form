import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/HomePage/view/DiseaseScreen.dart';

import 'bloc_paralysis/bloc.dart';
import 'bloc_paralysis/event.dart';
import 'bloc_paralysis/state.dart';

class Paralysis extends StatefulWidget {
  @override
  _ParalysisState createState() => _ParalysisState();
}

class _ParalysisState extends State<Paralysis> {
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  double _sliderValue = 0;
  final int _totalPages = 6;

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
            UpdateParalysisField(fieldName, formattedDate),
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
        key: _formKey,
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
              _buildDateField("Date of Desk Review", "Date of Desk Review"),
              _buildTextField("Reviewed By", "Reviewed By"),
              _buildDropdownField(['SMO', 'DIO', 'DSO'], "Title", "Title"),
              _buildDropdownField(
                  ['Govt. Allopathic', 'Pvt Allopathic', 'ISM Pract', 'Other'],
                  "Reporting Health Facility",
                  "Reporting Health Facility"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                ['YES', 'NO', 'UNKNOWN'],
                "Patient belongs to migratory family/community",
                "Patient belongs to migratory family/community"),
          ],
        ),
      ),
    );
  }

  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
          ],
        ),
      ),
    );
  }

  Widget _buildPage4() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("5. Clinical Symptoms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildTextField("Number of days from onset to maximum paralysis",
                "Number of days from onset to maximum paralysis"),
            _buildDateField(
                "Date of Paralysis Onset)", "Date of Paralysis Onset)"),
            _buildDropdownField(
                ['Yes', 'No', 'Unknown'], "Acute paralysis", "Acute paralysis"),
            _buildDropdownField(
                ['Yes', 'No', 'Unknown'],
                "Flaccid paralysis (anytime during course of illness)",
                "Flaccid paralysis (anytime during course of illness)"),
            _buildDropdownField(
                ['Yes', 'No', 'Unknown'],
                "Any Injections during 30 days before paralysis onset",
                "Any Injections during 30 days before paralysis onset"),
            BlocBuilder<ParalysisBloc, ParalysisState>(
              builder: (context, state) {
                final injectionsValue = state.fields[
                    "Any Injections during 30 days before paralysis onset"];
                return injectionsValue == 'Yes'
                    ? _buildTextField("side and site of injection ",
                        "side and site of injection ")
                    : SizedBox.shrink();
              },
            ),
            _buildDropdownField(
                ['Yes', 'No', 'Unknown'],
                "Fever at onset of paralysis (anytime during 7 days before)",
                "Fever at onset of paralysis (anytime during 7 days before)"),
            _buildDropdownField(['Yes', 'No', 'Unknown'], "Ascending paralysis",
                "Ascending paralysis"),
            _buildDropdownField(['Yes', 'No', 'Unknown'],
                "Descending paralysis", "Descending paralysis"),
          ],
        ),
      ),
    );
  }

  Widget _buildPage5() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("6. Clinical history",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildDropdownField(['Yes', 'No'], "Respiratory involvement",
                "Respiratory involvement"),
            _buildDropdownField(
                ['Yes', 'No'], "Bulbar involvement", "Bulbar involvement"),
            _buildDropdownField(
                ['Yes', 'No'], "Bladder/bowel", "Bladder/bowel"),
            _buildDropdownField(
                ['Yes', 'No'], "Joint pain/Swelling", "Joint pain/Swelling"),
            Text("7. Travel history",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(
                'Travel of child within 35 days prior to onset of paralysis (indicate dates and place of travel with arrows on dateline)'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Write dates of travel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Write here places visited corresponding to the travel dates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildTextField("District of residence", "District of residence"),
          ],
        ),
      ),
    );
  }

  Widget _buildPage6() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          _buildTextField("Final Classification", "Final Classification"),
          _buildTextField(
              "Final Classification Date", "Final Classification Date"),
        ],
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

  Widget _buildTextField(String label, String fieldName,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<ParalysisBloc, ParalysisState>(
        builder: (context, state) {
          return TextFormField(
            controller: TextEditingController(
              text: state.fields[fieldName] ?? '',
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context
                  .read<ParalysisBloc>()
                  .add(UpdateParalysisField(fieldName, value));
            },
          );
        },
      ),
    );
  }

  Widget _buildDropdownField(
      List<String> items, String label, String fieldName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<ParalysisBloc, ParalysisState>(
        builder: (context, state) {
          return DropdownButtonFormField<String>(
            value: state.fields[fieldName],
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context
                  .read<ParalysisBloc>()
                  .add(UpdateParalysisField(fieldName, value!));
            },
            items: items
                .map<DropdownMenuItem<String>>(
                    (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: _nextPage,
        child: Text('Next'),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
