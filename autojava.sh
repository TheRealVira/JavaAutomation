#!/bin/bash
sudo apt install -y openjdk-9-jdk
printf "public class Test {\n\tpublic static void main (String[] args) {\n\t\tSystem.out.println(\"Hello world\");\n\t}\n}\n" >> Test.java
echo "Java installed"
echo "Test class in ./Test.java"
