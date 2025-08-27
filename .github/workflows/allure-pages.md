name: Robot + Allure (Pages)

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: write
  pages: write
  id-token: write

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run Robot (generate Allure results)
        run: |
          # -d output: direktori log Robot biasa (opsional)
          # --listener allure_robotframework: menulis ke ./allure-results
          robot -d output --listener allure_robotframework tests

      # Install Allure CLI agar bisa generate HTML
      - name: Install Java (for Allure CLI)
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - name: Install Allure CLI
        run: |
          sudo apt-get update
          sudo apt-get install -y wget unzip
          ALLURE_VERSION=2.27.0
          wget -q https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.zip -O allure.zip
          unzip -q allure.zip
          sudo mv allure-${ALLURE_VERSION} /opt/allure
          sudo ln -sf /opt/allure/bin/allure /usr/local/bin/allure
          allure --version

      - name: Generate Allure HTML report
        run: |
          # input: ./allure-results, output: ./allure-report
          allure generate --clean ./allure-results -o ./allure-report

      # (Opsional) Simpan allure-results mentah sbg artifact untuk debugging
      - name: Upload raw allure-results
        uses: actions/upload-artifact@v4
        with:
          name: allure-results
          path: allure-results

      # Publish ke GitHub Pages
      - name: Upload report to Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./allure-report

  deploy:
    needs: test
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
