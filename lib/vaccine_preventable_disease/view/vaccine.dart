import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_bloc.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_event.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_state.dart';


class Vaccine extends StatefulWidget {
  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

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
        UpdateVaccineField(fieldName, formattedDate),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vaccine Preventable Disease"),centerTitle: true,),
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
      bottomNavigationBar: _buildNavigationButtons(),
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
            Text("3. Immunization History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildTextField("Number of Doses Received", "numberOfDoses"),
            _buildDateField("Date of Last Dose", "dateOfLastDose"),
            _buildDropdownField(['Routine', 'SIA'], "Vaccination Type", "vaccinationType"),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("4. Adverse Events",
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
            Text("5. Follow-up",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildTextField("Follow-up Date", "followUpDate"),
            _buildTextField("Follow-up Remarks", "followUpRemarks"),
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
          Text("6. Final Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _buildTextField("Final Comments", "finalComments"),
          _buildTextField("Review Date", "reviewDate"),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String fieldName,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<VaccineBloc, VaccineState>(
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
                  .read<VaccineBloc>()
                  .add(UpdateVaccineField(fieldName, value));
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
      child: BlocBuilder<VaccineBloc, VaccineState>(
        builder: (context, state) {
          return DropdownButtonFormField<String>(
            value: state.fields[fieldName],
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context
                  .read<VaccineBloc>()
                  .add(UpdateVaccineField(fieldName, value!));
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            _nextPage();
          },
          child: Text("Next"),
        ),
      ],
    );
  }
}
