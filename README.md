AIX Inventory
===========

This application is a aix servers inventory web interface for accessing my customers servers.

Install
-------

The following instructions will help you to install this Rails application on AIX.

1) Install JRUBY in /usr/local :

    # cd /usr/local
    # tar -xvf jruby-bin-1.7.2.tar
    # mv jruby-1.7.2 jruby

2) set paths in aix user profile :
    # export JAVA_HOME=/usr/java6
    # export PATH=$JAVA_HOME/bin:/usr/local/jruby/bin:$PATH
    
3) install bundler

    # gem install bundler-1.2.3.gem

4) clone git repository
    # git clone https://github.com/adejoux/aix_inventory.git
    
5) install gems 
    
    # cd aix_inventory
    # bundle install   


6) Init sqlite database

    # rake RAILS_ENV="production" db:setup

7) run with trinidad :

    $ bundle exec rails s trinidad -e production


Import data
--------

The imports are done through thor tasks and sequentially.

1) AIX servers

    # thor import:aix_csv /home/adejoux/aix_servers.csv 1.8

The second parameter set the inventory script version to load.

2) SAN switch ports

    # thor import:san_csv /home/adejoux/switch_ports.csv

The second parameter set the inventory script version to load.

3) recommended firmware level

    # thor import:fw_csv /home/adejoux/firmware.csv
    
apache configuration
--------

A example of configuration with subdirectory and without ajp. It need mod_proxy

    #aix inventory config
    ProxyPass /aix_inventory http://127.0.0.1:3000/aix_inventory
    ProxyPassReverse /aix_inventory http://127.0.0.1/aix_inventory
    Alias /assets /mydirectory/aix_inventory/public/assets
    <Directory /mydirectory/aix_inventory/public/assets>
      Order allow,deny
      Allow from all
    </Directory>

Use web browser to access url : http://myserver/aix_inventory

Note : Assets are accessed directly through /assets url

You can change the subdirectory by editing config/config.yml

See also
--------

If you want the full stack for running aix inventory, you should also look at:

* [aix inventory shell script]

How to run the specs
--------------------

Just run rspec:

    $ rspec

Copyright
---------

The code is licensed as GNU AGPLv3. See the LICENSE file for the full license.

Copyright (c) 2013 Alain Dejoux <adejoux@krystalia.net>
