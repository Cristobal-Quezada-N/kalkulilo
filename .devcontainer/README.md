# Flutter Devcontainer

## Visual Studio Code

`Run and Debug >` choose `kalkulilo (Flutter Linux)` or `kalkulilo (Flutter Web Server)` 

## General Usage

```bash
# in host
bash run.sh
```

- Flutter Web Server:

```bash
# in container (container must be up)
 flutter run -d web-server --web-hostname 0.0.0.0 --web-port 1234
# in host visit http://localhost:1234/
```

- Flutter Linux:

```bash
# in container
flutter run -d linux
```
