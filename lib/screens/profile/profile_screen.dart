import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _biometricAuthEnabled = false;
  bool _notificationsEnabled = true;
  bool _autoBackupEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final provider = context.read<AppProvider>();
    // Cargar datos del usuario
    _nameController.text = provider.currentUser?.displayName ?? 'Juan Pérez';
    _emailController.text =
        provider.currentUser?.email ?? 'juan.perez@ejemplo.com';
    _phoneController.text = '+57 300 123 4567';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Foto de perfil
                _buildProfilePicture(),
                const SizedBox(height: 30),

                // Información personal
                _buildPersonalInfoSection(),
                const SizedBox(height: 30),

                // Configuraciones
                _buildSettingsSection(provider),
                const SizedBox(height: 30),

                // Botón de cerrar sesión
                _buildLogoutButton(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Función disponible próximamente'),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B82F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _nameController.text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          _emailController.text,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información Personal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Nombre completo',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Correo electrónico',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Teléfono',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildSettingsSection(AppProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuraciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Autenticación biométrica
            _buildSettingTile(
              icon: Icons.fingerprint,
              title: 'Autenticación por huella',
              subtitle: 'Usar huella dactilar para iniciar sesión',
              trailing: Switch(
                value: _biometricAuthEnabled,
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _biometricAuthEnabled = value;
                  });
                  _showBiometricDialog(value);
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF3B82F6),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[300],
              ),
            ),

            const Divider(height: 32),

            // Modo oscuro
            _buildSettingTile(
              icon: Icons.dark_mode_outlined,
              title: 'Modo oscuro',
              subtitle: 'Cambiar tema de la aplicación',
              trailing: Switch(
                value: provider.isDarkMode,
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  provider.toggleDarkMode();
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF3B82F6),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[300],
              ),
            ),

            const Divider(height: 32),

            // Notificaciones
            _buildSettingTile(
              icon: Icons.notifications_outlined,
              title: 'Notificaciones',
              subtitle: 'Recibir alertas y recordatorios',
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF3B82F6),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[300],
              ),
            ),

            const Divider(height: 32),

            // Auto backup
            _buildSettingTile(
              icon: Icons.backup_outlined,
              title: 'Copia de seguridad automática',
              subtitle: 'Sincronizar datos automáticamente',
              trailing: Switch(
                value: _autoBackupEnabled,
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _autoBackupEnabled = value;
                  });
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF3B82F6),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[300],
              ),
            ),

            const Divider(height: 32),

            // Privacidad
            _buildSettingTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacidad',
              subtitle: 'Gestionar datos y privacidad',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Función disponible próximamente'),
                  ),
                );
              },
            ),

            const Divider(height: 32),

            // Acerca de
            _buildSettingTile(
              icon: Icons.info_outline,
              title: 'Acerca de BookFlix',
              subtitle: 'Versión 1.0.0',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showAboutDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      trailing: trailing,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(Icons.logout),
        label: const Text('Cerrar Sesión'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cambios guardados exitosamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showBiometricDialog(bool enable) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          enable ? 'Activar Huella Digital' : 'Desactivar Huella Digital',
        ),
        content: Text(
          enable
              ? 'La autenticación por huella digital será activada. Podrás usar tu huella para acceder a la aplicación.'
              : 'La autenticación por huella digital será desactivada.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _biometricAuthEnabled = !enable;
              });
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    enable
                        ? 'Autenticación biométrica activada'
                        : 'Autenticación biométrica desactivada',
                  ),
                  backgroundColor: const Color(0xFF3B82F6),
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _logout();
            },
            child: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acerca de BookFlix'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BookFlix v1.0.0'),
            SizedBox(height: 10),
            Text('Tu biblioteca personal de libros y películas.'),
            SizedBox(height: 10),
            Text('Desarrollado con Flutter 💙'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    final provider = context.read<AppProvider>();

    // Limpiar datos del usuario
    provider.logout();

    // Navegar al login
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesión cerrada exitosamente'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
