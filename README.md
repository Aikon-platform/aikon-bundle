# AIKON Bundle version 

This is a bundle version of the AIKON platform for traitement de documents historiques blabla petite présentation

[About the AIKON plateform](https://aikon-platform.github.io/)

This repo contains the code for the plateform + the worker API 
Can be run on your local machine. 

# Install 🛠️

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
git clone git@github.com:jnorindr/aikon-bundle.git
cd aikon-bundle
```
## Submodules

You need to install Redis and Python:

```bash
sudo apt-get install redis-server python3-venv python3-dev
```

```bash
git submodule init
git submodule update

# once initiate, update the submodule code with
git submodule update --remote
```

## Bundle scripted Install 🐆

If you are using a Linux or Mac distribution, you can install the bundle with the following script:

```bash
bash setup.sh
```

### .env templates 
#### AIKON
```
# Lower case name of the application
APP_NAME=

# Application language ("fr" or "en")
APP_LANG=

# Debug mode
DEBUG=

# To allow pickle as Celery serializer
C_FORCE_ROOT=

# Absolute path to the media files directory (no / at the end) (for Docker => /data/mediafiles)
MEDIA_DIR=/home/path/to/aikon-bundle/aikon/app/mediafiles

# Email address for support and inquiries
CONTACT_MAIL=admin@mail.com

# Database name
POSTGRES_DB=

# Database admin name
POSTGRES_USER=

# Database password
POSTGRES_PASSWORD=add_a_password_or_take the_one_generated

# Database host (for Docker => db)
DB_HOST=localhost

# Database port
DB_PORT=5432

# URL used in production without 'https://' (domain name only)
PROD_URL=

# List of allowed host separated by a comma
ALLOWED_HOSTS=localhost,127.0.0.1

# Secret key used for the application
SECRET_KEY=

# SimpleAnnotationServer username
SAS_USERNAME=

# SimpleAnnotationServer password
SAS_PASSWORD=

# SimpleAnnotationServer port
SAS_PORT=8888

# Cantaloupe port
CANTALOUPE_PORT=8182

CANTALOUPE_PORT_HTTPS=8183

# Geonames username (create yours on https://www.geonames.org/login)
GEONAMES_USER=

# API URL to which send requests for image analysis
CV_API_URL=http://example.api.com

# Computer vision apps to install
ADDITIONAL_MODULES=regions,similarity

# Redis host (for Docker => redis / for other config => localhost)
REDIS_HOST=localhost

# Redis port
REDIS_PORT=6379

# Redis password
REDIS_PASSWORD=

# SMTP server domain
EMAIL_HOST=

# Email address to send alert emails
EMAIL_HOST_USER=

# App password for email address
EMAIL_HOST_PASSWORD=

# Logos to be displayed in the footer
APP_LOGO=anr,ponts
```
#### Discover-API
```
# set to 'prod' to use production settings
TARGET=

# apps (folder names) to be imported to the API
INSTALLED_APPS=similarity,regions

# url used on production (must match the port EXPOSE in Dockerfile)
PROD_URL=

# folder path for data storage (containing subfolders with apps names) keep /data/ for Docker, data/ for dev
API_DATA_FOLDER=data/

# password to secure redis
# REDIS_PASSWORD=

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

<details>
  <summary><h3>Separated app and API scripted install 🐆</h3></summary>

```bash
    cd discover-api
    bash setup.sh
    cd ..
    cd aikon
    bash scripts/setup.sh
```

In `aikon`, launch everything (Django, Celery, Cantaloupe and SimpleAnnotationServer) at once (stop with Ctrl+C):
```bash
bash run.sh
```

In `discover-demo`, launch everything (Flask and Dramatiq) at once (stop with Ctrl+C):
```bash
bash run.sh
```
</details>

<details>
  <summary><h3>Discover-API Manual install 🐢</h3></summary>

    ```bash
cd discover-api
    ```
    
Copy the file `.env.template` to a file `.env`. Change its content to match your setup (especially regarding the paths).

Create a python virtual environment and install the required packages:

```bash
python3 -m venv venv
./venv/bin/pip install -r requirements.txt
```

You can now run the API worker:

```bash
./venv/bin/dramatiq app.main -p 1 -t 1
```

And the server:

```bash
./venv/bin/flask --app app.main run --debug
```
</details>

<details>
  <summary><h3>AIKON Manual install 🐢</h3></summary>

```bash
cd ..
cd aikon
```

#### Dependencies
>
```bash
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt-get install wget ca-certificates
sudo apt install libpq-dev nginx curl maven postgresql poppler-utils ghostscript
```
>
#### Python environment
>
```bash
python3.10 -m venv venv
source venv/bin/activate
pip install -r app/requirements-dev.txt
```
>
Enable `pre-commit` hooks (auto-test and formatting)
>
```bash
pre-commit install
```
>
#### Project settings
>
Create a [Geonames](https://www.geonames.org/login) account and activate it.
>
Copy the content of the settings template file
```bash
cp app/config/.env{.template,}
```
Change variables in the generated file `app/config/.env` to corresponds to your database and username

Create a [Geonames](https://www.geonames.org/login) account, activate it and change `<geonames-username>` in the `.env` file
>
#### Database
>
Open Postgres command prompt, create a database (`<database>`) and a user
```bash
sudo -i -u postgres psql # Mac: psql postgres
postgres=# CREATE DATABASE <database>;
postgres=# CREATE USER <username> WITH PASSWORD '<password>';
postgres=# ALTER ROLE <username> SET client_encoding TO 'utf8';
postgres=# ALTER DATABASE <database> OWNER TO <username>;
postgres=# ALTER ROLE <username> SET default_transaction_isolation TO 'read committed';
postgres=# ALTER ROLE <username> SET timezone TO 'UTC';
postgres=# GRANT ALL PRIVILEGES ON DATABASE <database> TO <username>;
postgres=# \q
```
>
Update database schema with models that are stored inside `app/webapp/migrations`
```bash
python app/manage.py migrate
```
>
Create a superuser
```bash
python app/manage.py createsuperuser
```
>
#### Cantaloupe
>
Create a `.env` file for cantaloupe
```bash
sudo chmod +x cantaloupe/init.sh && cp cantaloupe/.env{.template,} && nano cantaloupe/.env
```
>
Change variables in the generated file `cantaloupe/.env`:
- `BASE_URI`: leave it blank on local
- `FILE_SYSTEM_SOURCE` depends on the folder in which you run cantaloupe (inside cantaloupe/ folder: `../app/mediafiles/img/`)
```bash
BASE_URI=
FILE_SYSTEM_SOURCE=absolute/path/to/app/mediafiles/img/  # inside the project directory
HTTP_PORT=8182
HTTPS_PORT=8183
LOG_PATH=/dir/where/cantaloupe/logs/will/be/stored
```
>
Set up Cantaloupe by running (it will create a `cantaloupe.properties` file with your variables):
```bash
bash cantaloupe/init.sh
```
>
Run [Cantaloupe](https://cantaloupe-project.github.io/)
```bash
bash cantaloupe/start.sh
```
>
#### Simple Annotation Server
>
Run [Simple Annotation Server](https://github.com/glenrobson/SimpleAnnotationServer)
```bash
cd sas && mvn jetty:run
```
>
Navigate to [http://localhost:8888/index.html](http://localhost:8888/index.html) to start annotating:
You should now see Mirador with default example manifests.
>
#### Enabling authentication for Redis instance (optional)
>
Get the redis config file and the redis password in the environment variables
```bash
REDIS_CONF=$(redis-cli INFO | grep config_file | awk -F: '{print $2}' | tr -d '[:space:]')
source app/config/.env
```
>
Add your `REDIS_PASSWORD` (from `app/config/.env`) to Redis config file
>
```bash
sudo sed -i -e "s/^requirepass [^ ]*/requirepass $REDIS_PASSWORD/" "$REDIS_CONF"
sudo sed -i -e "s/# requirepass [^ ]*/requirepass $REDIS_PASSWORD/" "$REDIS_CONF"
```
>
Restart Redis
```bash
sudo systemctl restart redis-server # Mac: brew services restart redis
```
>
Test the password
```
redis-cli -a $REDIS_PASSWORD
```
</details>

# Launch app 🚀

Launch everything (Django, Celery, Cantaloupe, SimpleAnnotationServer, Flask and Dramatiq) at once (stop with Ctrl+C):

```bash
bash run.sh
```

You can now visit the app at http://localhost:8000 and connect with the credentials you created
