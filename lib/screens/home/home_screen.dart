import 'package:absensi_ui/providers/auth/auth_provider.dart';
import 'package:absensi_ui/providers/me/me_provider.dart';
import 'package:absensi_ui/style/color/colors.dart';
import 'package:absensi_ui/utils/me_result_state.dart';
import 'package:absensi_ui/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MeProvider>(context, listen: false).getMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryLight,
        title: Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteC),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                authProvider.logout(context);
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
              decoration: BoxDecoration(
                color: primaryLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: whiteC,
                    child: Icon(Icons.person, color: primaryColor, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Consumer<MeProvider>(
                    builder: (context, provider, _) {
                      final state = provider.resultState;
                      if (state is MeLoadedState) {
                        final karyawan = state.me.karyawan;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Pagi,",
                              style: TextStyle(color: white70, fontSize: 14),
                            ),
                            Text(
                              karyawan.namaKaryawan,
                              style: TextStyle(
                                color: whiteC,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: whiteWp02,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                karyawan.jabatan.namaJabatan,
                                style: TextStyle(color: whiteC, fontSize: 12),
                              ),
                            ),
                          ],
                        );
                      } else if (state is MeLoadingState) {
                        return CircularProgressIndicator();
                      } else if (state is MeErrorState) {
                        return Text(
                          "Gagal memuat data",
                          style: TextStyle(color: whiteC),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CardWidget(),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_note, color: blueshade700, size: 22),
                          const SizedBox(width: 8),
                          const Text(
                            "Jadwal Absensi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: blueshade50,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: blueshade700,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Mei 2025",
                              style: TextStyle(
                                color: blueshade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),
                  ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final List<Map<String, dynamic>> scheduleData = [
                        {
                          'date': '25 Mei 2025',
                          'time': '07:00 - 13:00',
                          'shift': 'Shift Pagi',
                          'color': Colors.orange,
                          'icon': Icons.wb_sunny_outlined,
                        },
                        {
                          'date': '26 Mei 2025',
                          'time': '14:00 - 20:00',
                          'shift': 'Shift Siang',
                          'color': Colors.blue,
                          'icon': Icons.wb_twilight,
                        },
                        {
                          'date': '27 Mei 2025',
                          'time': '21:00 - 03:00',
                          'shift': 'Shift Malam',
                          'color': Colors.indigo,
                          'icon': Icons.nightlight_round,
                        },
                      ];

                      final schedule = scheduleData[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: whiteC,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: blackWP05,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: schedule['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              schedule['icon'],
                              color: schedule['color'],
                            ),
                          ),
                          title: Text(
                            schedule['date'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: greyShape700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                schedule['time'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: greyShape700,
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: schedule['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              schedule['shift'],
                              style: TextStyle(
                                color: schedule['color'],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_view_week,
                        size: 18,
                        color: blueshade700,
                      ),
                      label: Text(
                        "Lihat Semua Jadwal",
                        style: TextStyle(
                          color: blueshade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
