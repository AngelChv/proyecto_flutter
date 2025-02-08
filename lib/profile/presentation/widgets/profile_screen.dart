import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import 'package:proyecto_flutter/profile/domain/profile_stats.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart';

/// Pantalla que muestra la información del perfíl y estadísticas del usuario.
///
/// Desde esta pantalla se puede acceder a la configuración.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Construye las filas de las estadísticas.
  Widget _buildStatRow(String title, int count, {String? subtitle}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye una tarjeta con las estadísticas.
  Widget _buildStatsCard(Future<ProfileStats> stats) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ProfileStats>(
            future: stats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!;
                return Column(
                  children: [
                    _buildStatRow(AppLocalizations.of(context)!.savedFilms,
                        data.totalFilms),
                    _buildStatRow(AppLocalizations.of(context)!.createdLists, data.totalLists),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();
    final currentUser = userVM.currentUser;
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);

    final stats = profileVM.getStats(userVM.currentUserId);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        actions: [
          IconButton(
            padding: EdgeInsets.all(compactMargin),
            tooltip: AppLocalizations.of(context)!.settings,
            onPressed: () {
              context.pushNamed("settings");
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(compactMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  currentUser.username[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                currentUser.username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentUser.email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildStatsCard(stats),
            ],
          ),
        ),
      ),
    );
  }
}
