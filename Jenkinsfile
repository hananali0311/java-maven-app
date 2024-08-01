name: Build Java Application

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'temurin' # or 'adoptopenjdk'

    - name: Set up Maven
      uses: actions/setup-maven@v3
      with:
        maven-version: '3.9.0'

    - name: Build with Maven
      run: mvn -B -DskipTests clean package
