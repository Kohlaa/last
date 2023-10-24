import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/add_room/add_room.dart';
import 'package:chat/ui/add_room/room_widget.dart';
import 'package:chat/ui/home/home_navigator.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/room.dart';

class HomeScreen2 extends StatefulWidget {
  static const String routeName = 'home2';

  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> implements HomeNavigator {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset('assets/images/main_background.png',
              fit: BoxFit.fill, width: double.infinity),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Home',
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: const Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUtils.getRooms(),
              builder: (context, asyncSnapShot) {
                if (asyncSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (asyncSnapShot.hasError) {
                  return Text(asyncSnapShot.error.toString());
                } else {
                  var roomsList = asyncSnapShot.data?.docs
                          .map((doc) => doc.data())
                          .toList() ??
                      [];
                  return GridView.builder(
                    itemBuilder: (context, index) {
                      return RoomWidgit(
                        room: roomsList[index],
                      );
                    },
                    itemCount: roomsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track the currently selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HP App'),
      ),
      body: _buildBody(
          _selectedIndex), // Create a method to build the selected screen
      // bottomNavigationBar: BottomNavigationBar(
      // items: const <BottomNavigationBarItem>[
      // BottomNavigationBarItem(
      // icon: Icon(Icons.home),
      // label: 'Home',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.contact_mail),
      //   label: 'Contact',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   label: 'Profile',
      // ),
      // ],
      // currentIndex: _selectedIndex,
      // onTap: _onItemTapped, // Callback when a tab is tapped
      // ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomeScreenContent(); // Create a HomeScreenContent widget
      case 1:
        return Container();
      // const ContactScreen(); // Create a ContactScreen widget
      case 2:
        return Container();
      // const ProfileScreen(); // Create a ProfileScreen widget
      default:
        return Container(); // You can replace this with an error screen or handle the case as needed
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeScreenContent extends StatelessWidget {
  HomeScreenContent({Key? key}) : super(key: key);

  // Sample data for doctors
  final List<Doctor> doctors = [
    Doctor(
        name: 'Dr. John Doe',
        rate: 4.5,
        address: '123 Main St, City',
        imageUrl: 'doctor1.jpg'),
    Doctor(
        name: 'Dr. Jane Smith',
        rate: 4.8,
        address: '456 Elm St, Town',
        imageUrl: 'doctor2.jpg'),
    Doctor(
        name: 'Dr. Sarah Johnson',
        rate: 4.3,
        address: '789 Oak St, Village',
        imageUrl: 'doctor3.jpg'),
    Doctor(
        name: 'Dr. Michael Brown',
        rate: 4.7,
        address: '101 Pine St, Town',
        imageUrl: 'doctor4.jpg'),
    Doctor(
        name: 'Dr. Emily Davis',
        rate: 4.6,
        address: '234 Cedar St, City',
        imageUrl: 'doctor5.jpg'),
    Doctor(
        name: 'Dr. James Wilson',
        rate: 4.9,
        address: '567 Maple St, Village',
        imageUrl: 'doctor6.jpg'),
    Doctor(
        name: 'Dr. Olivia White',
        rate: 4.4,
        address: '890 Birch St, City',
        imageUrl: 'doctor7.jpg'),
    Doctor(
        name: 'Dr. William Johnson',
        rate: 4.2,
        address: '432 Oak St, Town',
        imageUrl: 'doctor8.jpg'),
    Doctor(
        name: 'Dr. Laura Taylor',
        rate: 4.8,
        address: '123 Cedar St, Village',
        imageUrl: 'doctor9.jpg'),
    Doctor(
        name: 'Dr. Robert Miller',
        rate: 4.5,
        address: '678 Pine St, City',
        imageUrl: 'doctor10.jpg'),
    Doctor(
        name: 'Dr. Jessica Lee',
        rate: 4.7,
        address: '345 Maple St, Town',
        imageUrl: 'doctor11.jpg'),
    Doctor(
        name: 'Dr. Christopher Smith',
        rate: 4.6,
        address: '789 Elm St, Village',
        imageUrl: 'doctor12.jpg'),
    Doctor(
        name: 'Dr. Mary Johnson',
        rate: 4.9,
        address: '210 Birch St, City',
        imageUrl: 'doctor13.jpg'),
    Doctor(
        name: 'Dr. Daniel Davis',
        rate: 4.3,
        address: '543 Cedar St, Village',
        imageUrl: 'doctor14.jpg'),
    Doctor(
        name: 'Dr. Sarah Wilson',
        rate: 4.2,
        address: '876 Pine St, City',
        imageUrl: 'doctor15.jpg'),
    Doctor(
        name: 'Dr. John Brown',
        rate: 4.4,
        address: '321 Maple St, Town',
        imageUrl: 'doctor16.jpg'),
    Doctor(
        name: 'Dr. Rachel Taylor',
        rate: 4.8,
        address: '654 Elm St, Village',
        imageUrl: 'doctor17.jpg'),
    Doctor(
        name: 'Dr. Michael Lee',
        rate: 4.5,
        address: '987 Main St, City',
        imageUrl: 'doctor18.jpg'),
    Doctor(
        name: 'Dr. Emma Smith',
        rate: 4.6,
        address: '234 Cedar St, Town',
        imageUrl: 'doctor19.jpg'),
    Doctor(
        name: 'Dr. Benjamin Johnson',
        rate: 4.7,
        address: '567 Oak St, Village',
        imageUrl: 'doctor20.jpg')
    // Add more doctor data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorCard(doctor: doctor);
      },
    );
  }
}

class Doctor {
  final String name;
  final double rate;
  final String address;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.rate,
    required this.address,
    required this.imageUrl,
  });
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to HomeScreen2 when a card is tapped
          Navigator.of(context).pushNamed(HomeScreen2.routeName);
        },
        child: ListTile(
          leading: const CircleAvatar(
              // backgroundImage: AssetImage(
              //     doctor.imageUrl), // You need to add images to your assets
              ),
          title: Text(doctor.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rate: ${doctor.rate.toStringAsFixed(1)}'),
              Text('Address: ${doctor.address}'),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with the content of your Contact screen
    return const Center(
      child: Text('Contact Screen Content'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with the content of your Profile screen
    return const Center(
      child: Text('Profile Screen Content'),
    );
  }
}
