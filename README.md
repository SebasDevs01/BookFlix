# BookFlix 📚🎬

**Tu biblioteca personal para libros y películas**

BookFlix es una aplicación móvil desarrollada en Flutter que te permite llevar un registro completo de los libros que has leído y las películas que has visto. Con un diseño moderno y funcionalidades avanzadas, BookFlix hace que organizar tu colección personal sea fácil y divertido.

## ✨ Características Principales

### 🔐 Autenticación Segura
- **Google Sign-In**: Inicia sesión fácilmente con tu cuenta de Google
- **Autenticación Biométrica**: Protege tu biblioteca con huella dactilar o Face ID
- **Persistencia de Sesión**: Mantén tu sesión iniciada de forma segura

### 📱 Interfaz Moderna
- **Material Design 3**: Diseño moderno y consistente
- **Tema Claro/Oscuro**: Cambia entre temas según tu preferencia
- **Tipografía Google Fonts**: Fuentes elegantes con Poppins
- **Animaciones Fluidas**: Transiciones suaves y atractivas

### 📚 Gestión de Biblioteca
- **Agregar Libros**: Registra libros con detalles completos
- **Agregar Películas**: Guarda información de películas vistas
- **Sistema de Favoritos**: Marca tus contenidos favoritos
- **Calificaciones**: Sistema de estrellas (1-5)
- **Géneros Personalizados**: Selecciona tus géneros favoritos
- **Búsqueda Avanzada**: Encuentra contenido rápidamente

### 🎯 Navegación Intuitiva
- **3 Pestañas Principales**:
  - 📚 **Biblioteca**: Ve toda tu colección organizada
  - 🏠 **Inicio**: Dashboard personal con estadísticas
  - ❤️ **Favoritos**: Acceso rápido a tu contenido favorito

### 🎨 Menú Flotante Animado
- **Botón Flotante Central**: Menú interactivo con animaciones
- **4 Acciones Rápidas**:
  - ➕ Agregar Libro
  - ➕ Agregar Película  
  - 📷 Usar Cámara (próximamente)
  - 📱 Escanear Código (próximamente)

### 💾 Almacenamiento Local
- **Hive Database**: Base de datos local rápida y eficiente
- **Sin Conexión**: Funciona completamente offline
- **Sincronización**: Datos seguros en tu dispositivo

## 🏗️ Arquitectura Técnica

### Tecnologías Utilizadas
- **Flutter 3.24+**: Framework multiplataforma
- **Dart 3.5+**: Lenguaje de programación
- **Firebase Auth**: Autenticación con Google
- **Hive**: Base de datos local NoSQL
- **Provider**: Gestión de estado
- **Material Design 3**: Sistema de diseño

### Dependencias Principales
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Autenticación y Biometría
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  google_sign_in: ^6.2.1
  local_auth: ^2.3.0
  
  # Gestión de Estado
  provider: ^6.1.2
  
  # Base de Datos Local
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # UI y Diseño
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1
  cached_network_image: ^3.3.1
  
  # Multimedia (Futuras características)
  ffmpeg_kit_flutter: ^6.0.3
  video_player: ^2.9.1
  
  # Notificaciones
  flutter_local_notifications: ^17.2.3
  awesome_notifications: ^0.9.3+1
```

### Estructura del Proyecto
```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── models/                   # Modelos de datos
│   ├── user_model.dart       # Modelo de usuario
│   ├── book_model.dart       # Modelo de libro
│   └── movie_model.dart      # Modelo de película
├── providers/                # Gestión de estado
│   └── app_provider.dart     # Provider principal
├── screens/                  # Pantallas de la aplicación
│   ├── auth/                 # Autenticación
│   │   └── login_screen.dart
│   ├── home/                 # Pantalla principal
│   │   └── home_screen.dart
│   ├── library/              # Biblioteca
│   │   └── library_screen.dart
│   ├── favorites/            # Favoritos
│   │   └── favorites_screen.dart
│   ├── splash_screen.dart    # Pantalla de carga
│   ├── genre_selection_screen.dart # Selección de géneros
│   └── navigation_screen.dart # Navegación principal
├── services/                 # Servicios
│   └── auth_service.dart     # Servicio de autenticación
├── utils/                    # Utilidades
│   └── theme.dart            # Configuración de temas
└── widgets/                  # Widgets personalizados
    └── floating_menu.dart    # Menú flotante animado
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK 3.24+
- Dart 3.5+
- Android Studio / VS Code
- Cuenta de Firebase (para autenticación)

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd bookflix_demo
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Firebase**
   - Crear proyecto en Firebase Console
   - Habilitar Authentication con Google
   - Descargar `google-services.json` para Android
   - Descargar `GoogleService-Info.plist` para iOS
   - Colocar archivos en las carpetas correspondientes

4. **Generar archivos de código**
```bash
flutter packages pub run build_runner build
```

5. **Ejecutar la aplicación**
```bash
flutter run
```

## 🎮 Uso de la Aplicación

### Primer Inicio
1. **Bienvenida**: Pantalla de splash con animación del logo
2. **Autenticación**: Inicia sesión con tu cuenta de Google
3. **Géneros**: Selecciona tus géneros favoritos para personalización
4. **Dashboard**: Accede al panel principal con estadísticas

### Navegación Principal
- **Biblioteca**: Ve todos tus libros y películas organizados en pestañas
- **Inicio**: Panel personal con saludo, estadísticas y actividad reciente
- **Favoritos**: Acceso rápido a tu contenido marcado como favorito

### Agregar Contenido
1. Toca el botón flotante central (+)
2. Selecciona "Agregar Libro" o "Agregar Película"
3. Rellena la información (título, autor/director, género, etc.)
4. Guarda y disfruta de tu biblioteca actualizada

### Características Avanzadas
- **Búsqueda**: Usa el ícono de búsqueda para encontrar contenido específico
- **Filtros**: Organiza por género, calificación o fecha
- **Favoritos**: Toca el corazón para marcar/desmarcar favoritos
- **Temas**: Cambia entre modo claro y oscuro desde el inicio

## 🔮 Próximas Características

### Funcionalidades Planificadas
- [ ] **Escáner de Códigos**: Agregar libros/películas escaneando códigos de barras
- [ ] **Integración con APIs**: Información automática de libros (Google Books API)
- [ ] **Recomendaciones**: Sugerencias basadas en tus géneros favoritos
- [ ] **Estadísticas Avanzadas**: Gráficos de progreso y análisis de lectura/visualización
- [ ] **Notas y Reseñas**: Sistema completo de reseñas personales
- [ ] **Compartir**: Comparte tu biblioteca con amigos
- [ ] **Sincronización en la Nube**: Backup automático de tu biblioteca
- [ ] **Modo Offline Mejorado**: Funcionalidades adicionales sin conexión
- [ ] **Widgets de Pantalla de Inicio**: Acceso rápido desde la pantalla de inicio
- [ ] **Notificaciones Inteligentes**: Recordatorios de lectura/películas

### Mejoras de UX/UI
- [ ] **Animaciones Mejoradas**: Más transiciones fluidas
- [ ] **Temas Personalizados**: Más opciones de personalización
- [ ] **Accesibilidad**: Mejoras para usuarios con discapacidades
- [ ] **Internacionalización**: Soporte para múltiples idiomas

## 🤝 Contribución

¡Las contribuciones son bienvenidas! Si quieres contribuir al proyecto:

1. **Fork** el repositorio
2. **Crear** una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. **Abrir** un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📧 Contacto

**Desarrollador**: BookFlix Team
**Email**: contact@bookflix.app
**Versión**: 1.0.0

---

**¡Disfruta organizando tu biblioteca personal con BookFlix!** 📚✨
=======
# BookFlix
Aplicacion de streming basado en gustos y preferencias del usuario (Peliculas y Libros)
>>>>>>> 0931ff27e519c3576681936fae551aba7ca9e05d
