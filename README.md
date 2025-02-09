# kelaniDATA

A Flutter application for accessing and viewing student documents from the University of Kelaniya Management Information System (MIS).

## Features

- View multiple types of student documents:
    - NIC Document
    - A/L Certificate
    - O/L Certificate
    - Financial Information
    - Mother's Income Details
    - Additional Student Details
- Secure document access based on A/L year and NIC
- Built-in PDF viewer
- Clean and intuitive user interface
- Automatic cleanup of downloaded files

## Prerequisites

- Flutter (latest stable version)
- Android Studio / VS Code
- Android SDK
- iOS development tools (for iOS deployment)

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_pdfview: ^latest_version
  http: ^latest_version
  path_provider: ^latest_version
```

## Setup & Installation

1. Clone the repository:
```bash
git clone [your-repository-url]
```

2. Navigate to the project directory:
```bash
cd kelaniDATA
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Usage

1. Launch the app
2. Enter your A/L year in the format "20XX"
3. Enter your NIC number
4. Select the document you want to view from the available options
5. The document will be downloaded and displayed in the built-in PDF viewer

## Security Features

- Documents are automatically deleted when the app is closed
- Protected access to sensitive information
- Secure document downloading over HTTPS

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

[Add your license information here]

## Acknowledgments

- University of Kelaniya MIS team
- Flutter development team
- Contributors and maintainers

## Contact

[Add your contact information here]