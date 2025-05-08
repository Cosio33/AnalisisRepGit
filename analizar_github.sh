#!/data/data/com.termux/files/usr/bin/bash

# Validar parámetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <usuario/repositorio> <archivo_a_analizar>"
    exit 1
fi

REPO=$1
ARCHIVO=$2
DIRECTORIO="repo_temp"

# Instalar dependencias necesarias
pkg update && pkg install -y git python clang
pip install pylint bandit cloc

# Descargar el repositorio
echo "🔹 Clonando repositorio..."
rm -rf $DIRECTORIO
git clone https://github.com/$REPO.git $DIRECTORIO

# Analizar seguridad del código
if [ -f "$DIRECTORIO/$ARCHIVO" ]; then
    echo "🔹 Analizando código con pylint..."
    pylint "$DIRECTORIO/$ARCHIVO"

    echo "🔹 Escaneando seguridad con Bandit..."
    bandit -r "$DIRECTORIO"

    echo "🔹 Buscando comandos peligrosos en el código..."
    grep -E "(rm -rf|curl|wget|exec|eval)" "$DIRECTORIO/$ARCHIVO"

    echo "🔹 Obteniendo estadísticas con cloc..."
    cloc "$DIRECTORIO"

    echo "⚠️ ¿Consideras este código seguro? (s/n)"
    read seguro
    if [ "$seguro" == "n" ]; then
        echo "🚨 Eliminando repositorio malicioso..."
        rm -rf "$DIRECTORIO"
        echo "✅ Repositorio eliminado por seguridad."
        exit 1
    fi

    echo "🔹 ¿Ejecutar el código? (s/n)"
    read ejecutar
    if [ "$ejecutar" == "s" ]; then
        echo "🔹 Ejecutando código..."
        cd "$DIRECTORIO"
        python3 "$ARCHIVO"
    else
        echo "🚀 Código analizado, ejecución cancelada."
    fi
else
    echo "❌ El archivo $ARCHIVO no existe en el repositorio."
fi

# Limpiar archivos temporales
rm -rf $DIRECTORIO
echo "✅ Análisis completado."
