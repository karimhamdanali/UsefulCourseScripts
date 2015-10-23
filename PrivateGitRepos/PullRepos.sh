#! /usr/bin/env bash

# the path to this script (i.e., the repo named UsefulCourseScripts)
pathtoscript=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# the parent folder of the organization repo on disk (you can change this to wherever you want)
base=$pathtoscript/../..

find $base/students/ -type d -name .git \
| xargs -n 1 dirname \
| sort \
| while read line; do echo $line && cd $line && git pull; done
