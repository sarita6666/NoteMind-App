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
## 📁 Estructura del proyecto (Frontend - Flutter)

```
lib/
│   firebase_options.dart        # Configuración de Firebase
│   main.dart                    # Punto de entrada de la aplicación
│
├── core/
│   ├── theme/
│   │   ├── app_colors.dart      # Colores globales de la app
│   │   └── app_text_styles.dart # Estilos de texto reutilizables
│   │
│   └── utils/
│       └── validators.dart      # Validaciones para formularios
│
├── models/
│   ├── message_model.dart       # Modelo de mensajes (chat)
│   ├── note_model.dart          # Modelo de notas
│   └── user_model.dart          # Modelo de usuario
│
├── routes/
│   └── app_routes.dart          # Definición de rutas de navegación
│
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart        # Pantalla de inicio de sesión
│   │   └── register_screen.dart     # Pantalla de registro
│   │
│   ├── chat/
│   │   └── chat_screen.dart         # Chat entre usuarios
│   │
│   ├── chat_ai/
│   │   └── chat_ai_screen.dart      # Chat con inteligencia artificial
│   │
│   ├── home/
│   │   └── home_screen.dart         # Pantalla principal
│   │
│   ├── notes/
│   │   └── notes_screen.dart        # Gestión de notas
│   │
│   └── profile/
│       └── profile_screen.dart      # Perfil del usuario
│
├── services/
│   ├── ai_service.dart          # Integración con la API de IA
│   ├── auth_service.dart        # Autenticación de usuarios
│   ├── chat_service.dart        # Lógica del chat
│   └── note_service.dart        # CRUD de notas
│
└── widgets/
    └── card_option.dart         # Componente reutilizable de tarjetas
```
