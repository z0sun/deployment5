#!/bin/bash
rm -rf deployment5
source test/bin/activate
git clone https://github.com/z0sun/deployment5.git
cd deployment5
pip install -r requirements.txt
pip install gunicorn
python database.py
sleep 1
python load_data.py
sleep 1 
python -m gunicorn app:app -b 0.0.0.0 -D && echo "Done"
