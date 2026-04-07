# NoteMind

Aplicación para gestión de notas inteligentes, con posibilidad de chat y compartir contenido entre usuarios.

#como ejecutar el proyecto
# Backend
cd backend
npm install
npm run dev
# Flutter
flutter pub get
flutter run
#Estructura de carpetas Flutter (lib/)
lib/
│   firebase_options.dart
│   main.dart
│
├───core
│   ├───theme
│   │       app_colors.dart
│   │       app_text_styles.dart
│   │
│   └───utils
│           validators.dart
│
├───models
│       message_model.dart
│       note_model.dart
│       user_model.dart
│
├───routes
│       app_routes.dart
│
├───screens
│   ├───auth
│   │       login_screen.dart
│   │       register_screen.dart
│   │
│   ├───chat
│   │       chat_screen.dart
│   │
│   ├───chat_ai
│   │       chat_ai_screen.dart
│   │
│   ├───home
│   │       home_screen.dart
│   │
│   ├───notes
│   │       notes_screen.dart
│   │
│   └───profile
│           profile_screen.dart
│
├───services
│       ai_service.dart
│       auth_service.dart
│       chat_service.dart
│       note_service.dart
│
└───widgets
        card_option.dart
        custom_bottom_nav.dart
        custom_button.dart
        custom_input.dart
        grid_options.dart
        header_home.dart
