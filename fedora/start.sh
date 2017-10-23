#!/usr/bin/env bash

/usr/local/bin/confd -onetime -backend env
/usr/share/tomcat7/bin/catalina.sh run
