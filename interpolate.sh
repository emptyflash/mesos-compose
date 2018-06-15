#!/bin/bash

eval echo $(printf %q "$(cat apps/$1.json)" | sed 's/\\\$/\$/g') 
