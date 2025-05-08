# AnalisisRepGit
Análisis de reportorios de GitHub en Termux

Este script permite analizar código de un repositorio de GitHub sin necesidad de copiarlo manualmente. Utiliza herramientas como pylint, bandit y cloc para detectar posibles vulnerabilidades y estadísticas del código. Además, proporciona una opción para eliminar el código si se considera sospechoso.

🚀 Características
✅ Clona repositorios de GitHub automáticamente
✅ Analiza seguridad con bandit, pylint y grep
✅ Muestra estadísticas de código con cloc
✅ Opción de eliminación si el código es malicioso
✅ Confirmación antes de ejecutar el código

📌 Instalación
1️⃣ Instalar dependencias en Termux

pkg update && pkg install -y git python clang
pip install pylint bandit cloc

2️⃣ Crea archivo Bash

nano analizar_github.sh

(Si prefieres usar vim, puedes hacerlo con vim analizar_github.sh).


3️⃣ Dar permisos de ejecución

chmod +x analizar_github.sh

4️⃣ Ejecutar el script

./analizar_github.sh usuario/repositorio archivo.py


⚠️ Seguridad
- Se escanean posibles comandos peligrosos (rm -rf, curl, exec…)
- Se realiza un análisis con bandit para detectar vulnerabilidades
- Se pregunta al usuario antes de ejecutar el código
- Si el código es sospechoso, puede eliminarlo de inmediato
  
✨ Créditos
Este script fue desarrollado con apoyo de Microsoft Copilot para optimizar el análisis de código en Termux.



