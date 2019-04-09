#!/bin/bash

if [ "${CMD}" ];then
  ${CMD}
fi
tail -f /dev/null
