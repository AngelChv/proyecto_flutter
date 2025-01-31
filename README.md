# 🎬 App de Gestión de Películas

## 📌 Descripción
Esta es una aplicación desarrollada con Flutter para gestionar películas. Permite a los usuarios almacenar, organizar y visualizar información sobre las películas que han visto, desean ver o les gustan. La interfaz es minimalista y fácil de usar, con navegación intuitiva a través de una barra inferior.

## 📱 Características
La aplicación cuenta con tres secciones principales:

### 🎞️ Películas
- **Modelo `Film`**: Representa la estructura de los datos de cada película almacenada.
- **Pantalla principal**: Muestra un grid con todas las películas guardadas en la aplicación.
- **Página de detalles**: Muestra la información detallada de una película seleccionada.
- **Formulario de edición/creación**: Permite agregar nuevas películas o editar las existentes.

### 📂 Listas
- Permite a los usuarios organizar películas en diferentes listas personalizadas.
- Funcionalidad para agregar o eliminar películas de las listas.
- Posibilidad de gestionar múltiples listas según categorías o preferencias del usuario.

### 👤 Perfil
- **Acceso a la configuración** mediante un botón de acción en la parte superior.
- **Menú de ajustes** con dos secciones:
    - **Perfil**: Permite visualizar y modificar los datos del usuario.
    - **Ajustes generales**:
        - Cambio de idioma.
        - Alternar entre tema claro y oscuro.

## 🛠️ Tecnologías Utilizadas
- **Flutter**: Framework principal para el desarrollo.
- **Dart**: Lenguaje de programación.
- **Provider / Riverpod**: (Dependiendo de la implementación) Para la gestión del estado.
- **Hive / SQLite**: Para el almacenamiento local de datos.
- **Intl**: Manejo de localización e idiomas.

## 📖 Documentación
Para más información sobre la arquitectura del proyecto, estructura de carpetas y guías de contribución, consulta la [documentación](./docs/README.md).

## 🚀 Instalación
1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu_usuario/nombre_repositorio.git
   ```
2. Accede al directorio del proyecto:
   ```bash
   cd nombre_repositorio
   ```
3. Instala las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## 📌 Contribución
Si deseas contribuir al desarrollo de la aplicación, revisa las [directrices de contribución](./CONTRIBUTING.md) y asegúrate de seguir las mejores prácticas de código.

## 📜 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para más detalles.

---

¡Esperamos que disfrutes usando la aplicación! 🎥✨

