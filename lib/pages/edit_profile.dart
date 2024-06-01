import 'package:flutter/material.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/navbar.dart';

class EditProfile extends StatefulWidget {
  User user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<User> currentUser = [];

  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;

  Future<void> updateUser() async {
    // Get updated data from text fields
    String newUsername = _usernameController.text;
    String newFirstName = _firstNameController.text;
    String newLastName = _lastNameController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newAddress = _addressController.text;

    try {
      // Call updateUser method from User class
      await User.updateUser(
        emailToUpdate: widget.user.email,
        newUsername: newUsername,
        newFirstName: newFirstName,
        newLastName: newLastName,
        newPhoneNumber: newPhoneNumber,
        newAddress: newAddress,
      );

      // Show a success message or navigate to another screen
      // based on your app's flow after updating user data.
      print('User data updated successfully');
    } catch (error) {
      print('Error updating user data: $error');
      // Handle error (e.g., show a message)
    }
  }

  Future<void> fetchUserData() async {
    await User.fetchUserByEmail(widget.user.email);
    setState(() {
      widget.user = User.currentUser[0] as User;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // Initialize controllers and set initial values
    _usernameController = TextEditingController(text: widget.user.username);
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    // Dispose controllers when they are no longer needed
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize when the keyboard appears
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBF00),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Change arrow color here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap your content with SingleChildScrollView
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _buildGreeting(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildEditForm(
                    "Username",
                    "Enter your username",
                    controller: _usernameController,
                  ),
                  _buildEditForm(
                    "First Name",
                    "Enter your full name",
                    controller: _firstNameController,
                  ),
                  _buildEditForm(
                    "Last Name",
                    "Enter your full name",
                    controller: _lastNameController,
                  ),
                  _buildEditForm(
                    "Phone Number",
                    "Enter your phone number",
                    controller: _phoneNumberController,
                  ),
                  _buildEditForm(
                    "Address",
                    "Enter your address",
                    controller: _addressController,
                  ),
                  _buildSaveButton(currentUser)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      constraints: BoxConstraints(maxWidth: 280),
      alignment: Alignment.center,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          "lib/assets/durian_king.png",
          width: 150,
          height: 150,
        ),
        Text(
          "Edit Profile",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text("Make sure to save your changes before leaving",
            style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
      ]),
    );
  }

  Widget _buildEditForm(String label, String hint,
      {TextEditingController? controller}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              labelText: label,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFFFBF00),
                    width: 2.0), // Color of the enabled border
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFFFBF00),
                    width: 2.0), // Color of the focused border
                borderRadius: BorderRadius.circular(30),
              ),
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              floatingLabelStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSaveButton(List<User> user) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFFBF00),
      ),
      child: GestureDetector(
        onTap: () async {
          updateUser();
          await fetchUserData().then((_) {
            setState(() {
              widget.user = User.currentUser[0] as User;
            });
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavBar(user: widget.user)));
        }, // Pending
        child: Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
