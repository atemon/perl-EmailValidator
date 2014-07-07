EmailValidator
==============

Check if the given email address is valid or not using nslookup

You need the tool ```nslookup``` installed on the machine running this tool.

To install nslookup, run the command

####CentOS/RHEL
```sh
# yum install bind-utils
```
####Ubuntu/Debian
```sh
# sudo apt-get update
# sudo apt-get install dnsutils

```

###Usage


```perl
use EmailValidator;
my $v = new EmailValidator();
$v->is_valid('something@gmail.com');
```

