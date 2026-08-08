# OneDrive Rclone GNOME

Indicador de GNOME para montar un remoto de `rclone` como si fuera un OneDrive nativo:

1. Un lanzador `.desktop`.
2. Un script `bash` que monta y arranca el indicador.
3. Un programa en Python con icono en la bandeja y menú de acciones.
4. Dos iconos PNG para estado montado y aviso.

## Qué hace

Al abrir el lanzador:

1. Se comprueba si el punto de montaje existe.
2. Si no está montado, `rclone mount` monta el remoto `Onedrive:` en el directorio configurado.
3. Se abre la carpeta con `xdg-open`.
4. Se arranca el indicador GTK/Ayatana en segundo plano.

El indicador muestra el estado del montaje, permite abrir la carpeta, consultar OneDrive online, vaciar o medir la caché de `rclone`, ver progreso de transferencias, desmontar y salir.

## Estructura

```text
onedrive-rclone-gnome/
├── assets/
│   ├── onedrive.png
│   └── onedrive1.png
├── bin/
│   └── montar_onedrive.sh
├── desktop/
│   └── montar_onedrive.desktop
├── src/
│   └── onedrive_indicator.py
├── install.sh
└── README.md
```

## Dependencias

Necesitas:

- `rclone`
- `python3`
- `python3-requests`
- `python3-gi`
- `gir1.2-ayatanaappindicator3-0.1`
- `gir1.2-gtk-3.0`
- `xdg-utils`
- `notify-send` o `libnotify`

En Debian, Ubuntu y derivadas normalmente se cubre con:

```bash
sudo apt install rclone python3-requests python3-gi gir1.2-ayatanaappindicator3-0.1 gir1.2-gtk-3.0 xdg-utils libnotify-bin
```

Si prefieres usar `pip`, instala al menos:

```bash
python3 -m pip install -r requirements.txt
```

## Instalación

Desde este directorio:

```bash
bash install.sh
```

El instalador copia todo a ubicaciones de usuario:

- `~/.local/share/onedrive-rclone`
- `~/.local/bin`
- `~/.local/share/applications`

Después puedes lanzar la entrada de menú llamada `OneDrive Rclone GNOME`.

## Desinstalación

Si instalaste la app con este repo:

```bash
bash ~/.local/share/onedrive-rclone/uninstall.sh
```

## Configuración

Variables útiles:

- `ONEDRIVE_REMOTE`: remoto de `rclone`, por defecto `Onedrive:`
- `ONEDRIVE_MOUNTPOINT`: punto de montaje, por defecto `~/OneDrive`
- `ONEDRIVE_CACHE_DIR`: caché de `rclone`, por defecto `~/.cache/rclone`
- `ONEDRIVE_RC_URL`: URL del servidor RC de `rclone`, por defecto `http://localhost:5572/core/stats`

## Funciones del indicador

- `Abrir carpeta OneDrive`: abre el punto de montaje.
- `Ver OneDrive en línea`: abre OneDrive web.
- `Papelera de reciclaje`: abre la papelera web de OneDrive.
- `Limpiar caché OneDrive`: borra el contenido de la caché de `rclone`.
- `Ver tamaño de la caché`: muestra el tamaño actual de la caché.
- `Ver progreso > Notificación`: consulta el RC de `rclone` y envía una notificación con el estado de las transferencias.
- `Ver progreso > Barra de Progreso`: abre una ventana GTK con barras de progreso.
- `Desmontar OneDrive`: desmonta el punto de montaje y cierra el indicador.
- `Salir`: cierra el indicador sin desmontar.

## Cómo funciona internamente

### `bin/montar_onedrive.sh`

- Crea el punto de montaje si no existe.
- Ejecuta `rclone mount` con caché VFS en modo completo.
- Espera a que el montaje esté disponible.
- Abre la carpeta montada.
- Lanza el indicador en segundo plano si no estaba corriendo.

### `src/onedrive_indicator.py`

- Usa Ayatana AppIndicator para el icono de bandeja.
- Cambia el icono según el estado del montaje.
- Consulta el estado de transferencias con el RC de `rclone`.
- Vigila el tamaño de la caché y avisa si supera el umbral configurado.

## Nota sobre el origen

Los ficheros originales estaban en:

- `~/.local/share/applications/montar_onedrive.desktop`
- `~/.local/bin/montar_onedrive.sh`
- `~/.local/share/onedrive/onedrive_indicator.py`
- `~/.local/share/onedrive/onedrive.png`
- `~/.local/share/onedrive/onedrive1.png`

Esta copia del repositorio no modifica la instalación local.

## Licencia

MIT. Ver [LICENSE](LICENSE).
