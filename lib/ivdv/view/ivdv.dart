import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ivdv/bloc/ivdv_bloc.dart';
import 'package:untitled/ivdv/bloc/ivdv_event.dart';
import 'package:untitled/ivdv/bloc/ivdv_state.dart';


class Ivdv extends StatefulWidget {
  @override
  _IvdvState createState() => _IvdvState();
}

class _IvdvState extends State<Ivdv> {
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
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
      context.read<IvdvBloc>().add(
        UpdateField(fieldName, formattedDate),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
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
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey, // Ensure that _formKey is unique for each form
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("1.Reporting / Investigation Information",
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

              // Title dropdown field
              _buildDropdownField([
                'SMO',
                'DIO',
                'DSO',
              ], "Title", "Title"),

              // Moving Reporting Health Facility dropdown below the Title dropdown
              Column(
                children: [
                  _buildDropdownField([
                    'Govt. Allopathic',
                    'Pvt Allopathic',
                    'ISM Pract',
                    'Other',
                  ], "Reporting Health Facility", "Reporting Health "),
                ],
              )
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
            Text("2.Case Identification",
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
            _buildDropdownField([
              'Male',
              'Female',
            ], "Sex", "Sex"),
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
            ], "Number of IPV doses received", "Number of IPV doses received"),
            _buildDropdownField([
              'EI card',
              'Recall',
              'both',
            ], "Source of RI data", "Source of RI data"),
          ],
        ),
      ),
    );
  }

  Widget _buildPage4() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("4.Medical History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            _buildDropdownField([
              'left arm',
              'right arm',
              'left arm',
              'right leg',
              'neck',
              'bulbar',
              'respirator muscle'
                  'trunk',
              'facial'
            ], "  Site(s) of Paralysis (encircle): ",
                "  Site(s) of Paralysis (encircle): "),
            _buildTextField(" Others (Specify): ", "Others(Specify)")
          ],
        ),
      ),
    );
  }

  Widget _buildPage5() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("5.Stool Specimen Collection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16),
            _buildDateField("Date Collected", "Date Collected"),
            _buildDateField("Date Sent", "Date Sent"),
            _buildDateField("Date of result", "Date of result"),
            _buildTextField("Condition", "Condition:"),
            _buildTextField("Fever onset date:", "Fever onset date:"),
            _buildTextField("Paralysis onset date:", "Paralysis onset date:"),
            _buildTextField("If any pre-paralysis symptoms present:",
                "If any pre-paralysis symptoms present:"),
            _buildTextField("History of receiving vaccine within last 7 days:",
                "History of receiving vaccine within last 7 days:"),
            _buildTextField(
                "History of trauma (fall/injection) within last 30 days:",
                "History of trauma (fall/injection) within last 30 days:"),
            _buildTextField(
                "History of fever (any episode) within last 30 days:",
                "History of fever (any episode) within last 30 days:"),
            _buildTextField("History of travel within last 30 days:",
                "History of travel within last 30 days:"),
            _buildTextField(
                "History of contact with another AFP case within last 30 days:",
                "History of contact with another AFP case within last 30 days:"),
            _buildTextField("History of blood transfusion (in last 4 months):",
                "History of blood transfusion (in last 4 months):"),
            _buildTextField(
                "History of any prior history of AFP (in sibling/neighbor):",
                "History of any prior history of AFP (in sibling/neighbor):"),
            _buildTextField(
                "History of head injury:", "History of head injury:"),
          ],
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
                child: Text("6.Case Classification",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16),
              _buildDropdownField([
                'SL',
                'WPV',
                'VDPV',
              ], "Type-1", "Type-1"),
              _buildDropdownField([
                'SL',
                'WPV',
                'VDPV',
              ], "Type-2", "Type-2"),
              _buildDropdownField([
                'SL',
                'WPV',
                'VDPV',
              ], "Type-3", "Type-3"),
              _buildDropdownField([
                'Yes',
                'No',
              ], "Is the person eligible for antiviral polio treatment? ",
                  "Is the person eligible for antiviral polio treatment? "),
              _buildDropdownField([
                'Yes',
                'No',
              ], " Antiviral treatment requested?  ",
                  " Antiviral treatment requested?  "),
              _buildDateField(" If yes, treatment dates: Start",
                  " If yes, treatment dates: Start"),
              _buildDateField(" End date", " End date"),
              _buildTextField(
                  "Type of antiviral(specify)", "Type of antiviral(specify)"),
              _buildDropdownField([
                'Fulldose',
                'partial',
                'not taken',
              ], "Compliance ", "Compliance"),
            ]),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return BlocBuilder<IvdvBloc, IvdvState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _nextPage,
                child: Text("Next"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<IvdvBloc>().add(SubmitForm());
                },
                child: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String labelText, String fieldName,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: fieldName == "Title" ? titleController : null,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          context.read<IvdvBloc>().add(
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
          child: BlocBuilder<IvdvBloc, IvdvState>(
            builder: (context, state) {
              final fieldValue = state.fields[fieldName] ?? '';
              return Text(
                fieldValue,
                style: TextStyle(
                  color: fieldValue.isEmpty ? Colors.grey : Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      List<String> items, String labelText, String fieldName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<IvdvBloc, IvdvState>(
        builder: (context, state) {
          final selectedValue = state.fields[fieldName];
          return DropdownButtonFormField<String>(
            value: selectedValue,
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
                context.read<IvdvBloc>().add(
                  UpdateField(fieldName, value),
                );
              }
            },
          );
        },
      ),
    );
  }
}
