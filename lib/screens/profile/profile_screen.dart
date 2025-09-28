import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricAuthEnabled = true;
  bool _notificationsEnabled = true;
  bool _autoBackupEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Perfil y Configuración',
              style: theme.appBarTheme.titleTextStyle,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.appBarTheme.foregroundColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: theme.appBarTheme.elevation,
            centerTitle: theme.appBarTheme.centerTitle,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32.0 : 16.0,
              vertical: 16.0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 800 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    _buildProfileHeader(context, theme, isTablet),

                    const SizedBox(height: 32),

                    // Theme Toggle Section
                    _buildThemeSection(context, theme, provider, isTablet),

                    const SizedBox(height: 24),

                    // Security Section
                    _buildSecuritySection(context, theme, isTablet),

                    const SizedBox(height: 24),

                    // Preferences Section
                    _buildPreferencesSection(context, theme, isTablet),

                    const SizedBox(height: 24),

                    // Account Section
                    _buildAccountSection(context, theme, isTablet),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: isTablet ? 40 : 32,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.person,
              size: isTablet ? 40 : 32,
              color: Colors.white,
            ),
          ),

          SizedBox(width: isTablet ? 24 : 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuario BookFlix',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'usuario@bookflix.com',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Premium',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Edit Button
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    ThemeData theme,
    AppProvider provider,
    bool isTablet,
  ) {
    return _buildSection(
      theme: theme,
      title: 'Tema',
      icon: Icons.palette,
      isTablet: isTablet,
      children: [
        ListTile(
          leading: Icon(
            provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: theme.colorScheme.primary,
          ),
          title: Text(
            'Modo ${provider.isDarkMode ? "Oscuro" : "Claro"}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Cambia entre tema claro y oscuro',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          trailing: Switch(
            value: provider.isDarkMode,
            onChanged: (value) {
              HapticFeedback.lightImpact();
              provider.toggleDarkMode();
            },
            activeThumbColor: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySection(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    return _buildSection(
      theme: theme,
      title: 'Seguridad',
      icon: Icons.security,
      isTablet: isTablet,
      children: [
        ListTile(
          leading: Icon(Icons.fingerprint, color: theme.colorScheme.primary),
          title: Text(
            'Autenticación biométrica',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Usar huella dactilar o reconocimiento facial',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          trailing: Switch(
            value: _biometricAuthEnabled,
            onChanged: (value) {
              setState(() {
                _biometricAuthEnabled = value;
              });
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Autenticación biométrica activada'
                        : 'Autenticación biométrica desactivada',
                  ),
                ),
              );
            },
            activeThumbColor: theme.colorScheme.primary,
          ),
        ),
        ListTile(
          leading: Icon(Icons.lock, color: theme.colorScheme.primary),
          title: Text(
            'Cambiar contraseña',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Actualiza tu contraseña de acceso',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Función de cambio de contraseña próximamente'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    return _buildSection(
      theme: theme,
      title: 'Preferencias',
      icon: Icons.tune,
      isTablet: isTablet,
      children: [
        ListTile(
          leading: Icon(Icons.notifications, color: theme.colorScheme.primary),
          title: Text(
            'Notificaciones',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Recibir notificaciones de novedades',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Notificaciones activadas'
                        : 'Notificaciones desactivadas',
                  ),
                ),
              );
            },
            activeThumbColor: theme.colorScheme.primary,
          ),
        ),
        ListTile(
          leading: Icon(Icons.backup, color: theme.colorScheme.primary),
          title: Text(
            'Respaldo automático',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'Respaldar favoritos y progreso',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          trailing: Switch(
            value: _autoBackupEnabled,
            onChanged: (value) {
              setState(() {
                _autoBackupEnabled = value;
              });
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Respaldo automático activado'
                        : 'Respaldo automático desactivado',
                  ),
                ),
              );
            },
            activeThumbColor: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    return _buildSection(
      theme: theme,
      title: 'Cuenta',
      icon: Icons.account_circle,
      isTablet: isTablet,
      children: [
        ListTile(
          leading: Icon(Icons.help_outline, color: theme.colorScheme.primary),
          title: Text(
            'Ayuda y soporte',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Función de ayuda próximamente')),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline, color: theme.colorScheme.primary),
          title: Text(
            'Acerca de',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'BookFlix',
              applicationVersion: '1.0.0',
              applicationIcon: Icon(
                Icons.local_movies,
                size: 48,
                color: theme.colorScheme.primary,
              ),
              children: [
                Text(
                  'Tu plataforma de entretenimiento digital con libros y películas.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.logout, color: theme.colorScheme.error),
          title: Text(
            'Cerrar sesión',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.error,
            ),
          ),
          onTap: () {
            _showLogoutDialog(context, theme);
          },
        ),
      ],
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required List<Widget> children,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: isTablet ? 28 : 24,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(width: isTablet ? 16 : 12),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Cerrar sesión',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          '¿Estás seguro que deseas cerrar sesión?',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Función de cerrar sesión próximamente'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
