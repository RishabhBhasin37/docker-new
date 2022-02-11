#!/bin/bash
sed "s/mtag/$1/g" dep.yaml > newdep.yaml
