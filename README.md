# test-grafana-business-media-panel

## Installation

Clone the repository:

    git clone https://github.com/mahavirpatel/test-grafana-business-media-panel.git

Run the `generate-init.sh` to download the media and generate the `init.sql`

    ./generate-init.sh

Deploy grafana and db using the docker-compose:

    docker-compose up -d

## Dashboard Disaply

open a browser to the following url: http://localhost:3000/

Log in with credentials: admin/admin

Go to the _Dashboards_ menu, then click on the _Test_ then _Test Dashboard_ dashabord to display it.