#!/bin/bash
cd /home/kavia/workspace/code-generation/reflectslide-91591-996a9d53/journal_slideshow_frontend_workspace/journal_slideshow_frontend
npx run lint
ESLINT_EXIT_CODE=$?
npm run build
BUILD_EXIT_CODE=$?
if [ $ESLINT_EXIT_CODE -ne 0 ] || [ $BUILD_EXIT_CODE -ne 0 ]; then
  exit 1
fi

