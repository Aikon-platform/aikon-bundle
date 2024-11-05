# AIKON Bundle version 

This is a bundle version of AIKON project for traitement de documents historiques blabla petite présentation

[About the AIKON plateform](https://aikon-platform.github.io/)

This repo contains the code for the plateform + the worker API 
Can be run on your local machine. 

# Intall 🛠️

## Requirements 

- **Sudo** privileges
- **Bash** terminal
- **Python** >= 3.10
- **Java 11**: instructions for [Linux install](https://docs.oracle.com/en/java/javase/11/install/installation-jdk-linux-platforms.html#GUID-737A84E4-2EFF-4D38-8E60-3E29D1B884B8)
    - [Download OpenJDK](https://jdk.java.net/11/) (open source version of Java)
    - Download the latest [RPM Package](https://www.oracle.com/java/technologies/downloads/#java11)
    - `sudo alien -i jdk-11.0.17_linux-aarch64_bin.rpm`
    - `java -version` => `openjdk 11.x.x` // `java version "1.11.x"`
- **Git**:
    - `sudo apt install git`
    - Having configured [SSH access to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- **Geonames**:
    - Create an account on [Geonames](https://www.geonames.org/login) and activate it

```bash
git clone git@github.com:Aikon-platform/aikon.git
cd aikon
```
## Submodules

You need to install redis and python:

```bash
sudo apt-get install redis-server python3-venv python3-dev
```

You need to init the submodules (for `dticlustering` you need access to the [dti-sprites](https://github.com/sonatbaltaci/dti-sprites) project):

```bash
git submodule init
git submodule update

# once initiate, update the submodule code with
git submodule update --remote
```

## Scripted Install 🐆

If you are using a Linux or Mac distribution, you can install the app with the following script:

```bash
bash scripts/setup.sh
```

### DHNord-Demo : help to fill in the .env files 

```
# Lower case name of the application
APP_NAME=aikon

# Application language ("fr" or "en")
APP_LANG=en

# Debug mode
DEBUG=True

# To allow pickle as Celery serializer
C_FORCE_ROOT=True

# Absolute path to the media files directory (no / at the end) (for Docker => /data/mediafiles)
MEDIA_DIR=/home/path/to/aikon-bundle/aikon/app/mediafiles

# Email address for support and inquiries
CONTACT_MAIL=admin@mail.com

# Database name
POSTGRES_DB=aikon

# Database admin name
POSTGRES_USER=your_db_name

# Database password
POSTGRES_PASSWORD=add_a_password_or_take the_one_generated

# Database host (for Docker => db)
DB_HOST=localhost

# Database port
DB_PORT=5432

# URL used in production without 'https://' (domain name only)
PROD_URL=leave_empty_for_dev_mode

# List of allowed host separated by a comma
ALLOWED_HOSTS=localhost,127.0.0.1

# Secret key used for the application
SECRET_KEY=add_a_password_or_take the_one_generated

# SimpleAnnotationServer username
SAS_USERNAME=aikon

# SimpleAnnotationServer password
SAS_PASSWORD=add_a_password_or_take the_one_generated

# SimpleAnnotationServer port
SAS_PORT=8888

# Cantaloupe port
CANTALOUPE_PORT=8182

CANTALOUPE_PORT_HTTPS=8183

# Geonames username (create yours on https://www.geonames.org/login)
GEONAMES_USER=

# API URL to which send requests for image analysis
CV_API_URL=http://localhost:5001

# Computer vision apps to install
ADDITIONAL_MODULES=regions,similarity

# Redis host (for Docker => redis / for other config => localhost)
REDIS_HOST=localhost

# Redis port
REDIS_PORT=6379

# Redis password
REDIS_PASSWORD=leave_blank_on_local

# SMTP server domain
EMAIL_HOST=leave_blank_for_demo

# Email address to send alert emails
EMAIL_HOST_USER=leave_blank_for_demo

# App password for email address
EMAIL_HOST_PASSWORD=add_a_password_or_take the_one_generated

# Logos to be displayed in the footer
APP_LOGO=anr,ponts
``

```
# set to 'prod' to use production settings
TARGET=dev

# apps (folder names) to be imported to the API
INSTALLED_APPS=similarity,regions

# url used on production (must match the port EXPOSE in Dockerfile)
PROD_URL=http://localhost:8001

# folder path for data storage (containing subfolders with apps names) keep /data/ for Docker, data/ for dev
API_DATA_FOLDER=data/

# password to secure redis
# REDIS_PASSWORD=leave_empty_for_dev_mode

# prefix url for exposing results: each app has => /<prefix>/<app_name> (must match docker-confs/nginx.conf)
XACCEL_PREFIX=/media

#######################
#    DTICLUSTERING    #
#######################

#######################
#      SIMILARITY     #
#######################

#######################
#      WATERMARKS     #
#######################

# Relative path from API_DATA_FOLDER where watermarks models are stored
WATERMARKS_MODEL_FOLDER=watermarks/models/

#######################
#       REGIONS       #
#######################

# folder path for yolo tmp files keep /data/yolotmp for Docker, data/yolotmp for dev
YOLO_CONFIG_DIR=data/yolotmp/
```

# Launch app 🚀

Launch everything (Django, Celery, Cantaloupe and SimpleAnnotationServer) at once (stop with Ctrl+C):

```bash
bash run.sh
```

You can now visit the app at http://localhost:8000 and connect with the credentials you created
