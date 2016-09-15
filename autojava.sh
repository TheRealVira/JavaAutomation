#!/bin/bash
sudo apt install -y openjdk-9-jdk
printf 'public class Test {\npublic static void main (string[] args) {\nSystem.out.println(\"Hello world\");\n}\n}' >> Test.java
echo "Java installed"
