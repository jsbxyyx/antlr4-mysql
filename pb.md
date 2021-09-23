```
python setup.py sdist
pip install wheel
python setup.py bdist_wheel
pip install twine

vim ~/.pypirc
[pypi]
username=__token__
password=pypi-xx

twine upload dist/*
```