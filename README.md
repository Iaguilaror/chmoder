# chmoder
Script for changing permissions on every file that does not already have them in a dir

Note:
Remember to ad the chmoder script in a cronjob, for ubuntu use:

````
nano /etc/crontab
````

Example cronjob:

````
* * * * * root bash /home/iaguilar/tmp/chmoder/bin/chmoder.sh /home/iaguilar/tmp/chmoder/test/data/
````

### Dependencies

gzip
