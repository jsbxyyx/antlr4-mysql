#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @author jsbxyyx
import os

import setuptools

base_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(base_dir, "readme.txt"), "r") as f:
    long_description = f.read()

with open(os.path.join(base_dir, "requirements.txt"), "r") as f:
    install_requires = f.read().splitlines()

setuptools.setup(
    name="antlr4-mysql",
    version="0.1",
    author="jsbxyyx",
    author_email="jsbxyyx@163.com",
    license="Apache License",
    description="antlr4-mysql",
    long_description=long_description,
    long_description_content_type="text/markdown",
    install_requires=install_requires,
    url="https://github.com/jsbxyyx/antlr4-mysql",
    packages=setuptools.find_packages(),
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: Apache License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.0',
)
