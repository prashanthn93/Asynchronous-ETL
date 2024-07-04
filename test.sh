#!/bin/bash
echo 'Starting db processes now'
echo 'starting test script'
mysql -u jira_app -ppassword -D jira_cert < test.sql
echo 'done'