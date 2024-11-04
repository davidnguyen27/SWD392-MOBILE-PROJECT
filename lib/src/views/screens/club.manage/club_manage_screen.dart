import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/services/club_service.dart';
import 'package:t_shirt_football_project/src/models/club.dart';
import 'package:t_shirt_football_project/src/ui/club.manage/club_card.dart';

class ClubManageScreen extends StatefulWidget {
  const ClubManageScreen({super.key});

  @override
  _ClubManageScreenState createState() => _ClubManageScreenState();
}

class _ClubManageScreenState extends State<ClubManageScreen> {
  late Future<List<Club>> _futureClubs;
  String? selectedCountry;
  bool showDeletedClubs = false; // Biến để xác định hiển thị câu lạc bộ đã xóa

  @override
  void initState() {
    super.initState();
    _futureClubs = ClubService.fetchClubs(1, 50, "", true);
    _fetchClubs();
  }

  Future<void> _loadSeasons() async {
    setState(() {
      _futureClubs = ClubService.fetchClubs(1, 50, "", true);
    });
  }

  void _fetchClubs() {
    setState(() {
      _futureClubs = ClubService.fetchClubs(
        1,
        50,
        selectedCountry ?? "",
        !showDeletedClubs, // Nếu `showDeletedClubs` là true, thì `status` sẽ là false
      );
    });
  }

  void _showFilterSheet() {
    // Biến tạm thời để lưu trạng thái của nút Switch trong BottomSheet
    bool tempShowDeletedClubs = showDeletedClubs;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter Clubs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Show Deleted Clubs'),
                      Switch(
                        value: tempShowDeletedClubs,
                        onChanged: (value) {
                          setModalState(() {
                            tempShowDeletedClubs =
                                value; // Cập nhật biến tạm thời trong BottomSheet
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Đóng BottomSheet
                      setState(() {
                        // Gán lại biến tạm thời vào showDeletedClubs khi nhấn Apply Filter
                        showDeletedClubs = tempShowDeletedClubs;
                      });
                      _fetchClubs(); // Lấy danh sách mới với bộ lọc
                    },
                    child: const Text('Apply Filter'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed:
                _showFilterSheet, // Mở BottomSheet khi nhấn vào biểu tượng
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Club>>(
                future: _futureClubs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final clubs = snapshot.data!;
                    if (clubs.isEmpty) {
                      return const Center(child: Text('No clubs available'));
                    }
                    return ListView.builder(
                      itemCount: clubs.length,
                      itemBuilder: (context, index) {
                        final club = clubs[index];
                        return ClubItemCard(
                          name: club.name,
                          id: club.id,
                          country: club.country,
                          establishedYear:
                              "${club.establishedYear.year}-${club.establishedYear.month.toString().padLeft(2, '0')}-${club.establishedYear.day.toString().padLeft(2, '0')}",
                          clubLogo: club.clubLogo,
                          stadiumName: club.stadiumName,
                          description: club.description,
                          club: club,
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/club-add');
          if (result == true) {
            _loadSeasons();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
