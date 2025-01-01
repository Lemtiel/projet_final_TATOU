# Étape 1 : Utiliser une image de base légère
FROM python:3.6-alpine

# Étape 2 : Définir le répertoire de travail
WORKDIR /opt

# Étape 3 : Copier les fichiers du projet dans l'image
COPY . /opt

# Étape 4 : Installer Flask
RUN pip install flask

# Étape 5 : Exposer le port utilisé par l'application
EXPOSE 8080

# Étape 6 : Définir des variables d'environnement dynamiques pour les URLs
ENV ODOO_URL= https://www.odoo.com/fr_FR
ENV PGADMIN_URL= https://www.pgadmin.org/

# Ajout du script permettant extraire les variables d’environnement de releases.txt
RUN cat releases.txt | awk '/ODOO_URL/ {print $2}' | xargs -I {} export ODOO_URL={}
RUN cat releases.txt | awk '/PGADMIN_URL/ {print $2}' | xargs -I {} export PGADMIN_URL={}

# Étape 7 : Lancer l'application Flask
ENTRYPOINT ["python", "app.py"]
