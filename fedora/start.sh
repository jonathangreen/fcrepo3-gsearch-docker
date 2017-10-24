#!/usr/bin/env bash

/usr/local/bin/confd -onetime -backend env
$CATALINA_HOME/bin/catalina.sh run
