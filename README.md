# hoplint
Code scanning workflow with the lint tool. Application source files: The source files consist of files that make up your kettle proyect.
In addition to ensuring your app meets its functional requirements by building tests, it's important that you also ensure your code has no structural problems by running the code through lint. 
The lint tool helps find poorly structured code can impact the reliability  and make your code harder to maintain.

1. **Check db connection** :  Check the Database connection.
2. **Check step name** : CodeName in my case CammelCase.
3. **Empty flow** : is exit a unactive flow.
4. **Check path file** : CodeName in a path.
5. **Remove element in a flow**: Don't remove fields in Select Value unless you must. It's a CPU-intensive task as the engine needs to reconstruct the complete row. It is almost always faster to add fields to a row rather than delete fields from a row.
6. **File is called**: CodeName in a transformation or job file in my case Snake Case


[Pentaho Data Integration Performance Tuning](https://help.pentaho.com/Documentation/8.0/Setup/Administration/Performance_Tuning/040/010)

# Install
We need install *ruby* and the next gem:
* **colorize** : color in the terminal.
* **nokogiri** : parser the XML.
* **optparse** : parameter like cli.

```shell
gem install colorize
gem install nokogiri
gem install optparse
```
# Run
run the script for a dictory.
```shell
hoplint -d /home/sowe/bi-solution/etl/sample/
```
run the script for a file.
```shell
hoplint -f /home/sowe/bi-solution/etl/sample/sample.ktr
```
# Sample

[![asciicast](https://asciinema.org/a/14.png)](https://asciinema.org/connect/4123a870-c2ee-4cec-90e7-1a6052e6360c)
