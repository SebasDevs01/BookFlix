import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'María García');
  final _emailController = TextEditingController(
    text: 'maria.garcia@bookflix.com',
  );
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _bioController = TextEditingController(
    text:
        'Amante de los libros de fantasía y las películas de ciencia ficción. Siempre buscando nuevas historias que me transporten a otros mundos.',
  );

  String _selectedGender = 'Femenino';
  String _selectedLanguage = 'Español';
  String _selectedCountry = 'España';

  final List<String> _genders = [
    'Masculino',
    'Femenino',
    'Otro',
    'Prefiero no decir',
  ];
  final List<String> _languages = [
    'Español',
    'English',
    'Français',
    'Português',
  ];
  final List<String> _countries = [
    'España',
    'México',
    'Argentina',
    'Colombia',
    'Chile',
    'Estados Unidos',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Aquí guardarías los datos del perfil
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Editar Perfil', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        centerTitle: theme.appBarTheme.centerTitle,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Guardar',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : double.infinity,
              ),
              child: Column(
                children: [
                  // Avatar Section
                  _buildAvatarSection(theme, isTablet),
                  const SizedBox(height: 32),

                  // Personal Information
                  _buildPersonalInfoSection(theme, isTablet),
                  const SizedBox(height: 24),

                  // Contact Information
                  _buildContactInfoSection(theme, isTablet),
                  const SizedBox(height: 24),

                  // Preferences
                  _buildPreferencesSection(theme, isTablet),
                  const SizedBox(height: 32),

                  // Save Button
                  _buildSaveButton(theme, isTablet),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(ThemeData theme, bool isTablet) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: isTablet ? 60 : 50,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: isTablet ? 60 : 50,
                color: theme.colorScheme.primary,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Función de cambiar foto próximamente'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Cambiar foto de perfil',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(ThemeData theme, bool isTablet) {
    return _buildSection(
      theme: theme,
      title: 'Información Personal',
      icon: Icons.person_outline,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nombre completo',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor ingresa tu nombre';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _selectedGender,
          decoration: InputDecoration(
            labelText: 'Género',
            prefixIcon: const Icon(Icons.wc),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _genders.map((gender) {
            return DropdownMenuItem(value: gender, child: Text(gender));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedGender = value;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _bioController,
          decoration: InputDecoration(
            labelText: 'Biografía',
            prefixIcon: const Icon(Icons.description),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
          maxLength: 200,
          validator: (value) {
            if (value != null && value.length > 200) {
              return 'La biografía no puede tener más de 200 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(ThemeData theme, bool isTablet) {
    return _buildSection(
      theme: theme,
      title: 'Información de Contacto',
      icon: Icons.contact_mail,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor ingresa tu correo';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Por favor ingresa un correo válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Teléfono',
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(ThemeData theme, bool isTablet) {
    return _buildSection(
      theme: theme,
      title: 'Preferencias',
      icon: Icons.settings,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _selectedLanguage,
          decoration: InputDecoration(
            labelText: 'Idioma',
            prefixIcon: const Icon(Icons.language),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _languages.map((language) {
            return DropdownMenuItem(value: language, child: Text(language));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedLanguage = value;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _selectedCountry,
          decoration: InputDecoration(
            labelText: 'País',
            prefixIcon: const Icon(Icons.flag),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _countries.map((country) {
            return DropdownMenuItem(value: country, child: Text(country));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedCountry = value;
              });
            }
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
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSaveButton(ThemeData theme, bool isTablet) {
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 56 : 48,
      child: ElevatedButton.icon(
        onPressed: _saveProfile,
        icon: const Icon(Icons.save),
        label: const Text(
          'Guardar Cambios',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
