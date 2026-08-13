#!/bin/bash

# Function to show usage/help
show_help() {
    echo "Usage: ./buildMaven.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a            Package the application (mvn clean package)"
    echo "  -i            Install package to local repository (mvn clean install)"
    echo "  -s <tool>     Run static analysis (checkstyle | findbugs | pmd)"
    echo "  -t <plugin>   Run unit tests and code coverage (jacoco | cobertura)"
    echo "  -d            Deploy application to Tomcat server"
    echo "  -h            Show help"
}

# Ensure at least one argument is provided
if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

# Parse flags using getopts
while getopts "ais:t:dh" opt; do
    case ${opt} in
        a)
            echo "[INFO] Packaging application..."
            mvn clean package
            ;;
        i)
            echo "[INFO] Installing application to local repository..."
            mvn clean install
            ;;
        s)
            TOOL=$OPTARG
            case ${TOOL} in
                checkstyle)
                    echo "[INFO] Running Checkstyle analysis..."
                    mvn checkstyle:checkstyle
                    ;;
                findbugs)
                    echo "[INFO] Running FindBugs analysis..."
                    mvn findbugs:findbugs
                    ;;
                pmd)
                    echo "[INFO] Running PMD analysis..."
                    mvn pmd:pmd
                    ;;
                *)
                    echo "[ERROR] Invalid static analysis tool: ${TOOL}. Use checkstyle, findbugs, or pmd."
                    exit 1
                    ;;
            esac
            ;;
        t)
            PLUGIN=$OPTARG
            case ${PLUGIN} in
                jacoco)
                    echo "[INFO] Running tests and generating JaCoCo coverage report..."
                    mvn clean test jacoco:report
                    ;;
                cobertura)
                    echo "[INFO] Running tests and generating Cobertura coverage report..."
                    mvn cobertura:cobertura
                    ;;
                *)
                    echo "[ERROR] Invalid coverage plugin: ${PLUGIN}. Use jacoco or cobertura."
                    exit 1
                    ;;
            esac
            ;;
        d)
            echo "[INFO] Deploying war file to Tomcat server..."
            mvn tomcat7:run-war-only || mvn tomcat6:run
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "[ERROR] Invalid option"
            show_help
            exit 1
            ;;
    esac
done