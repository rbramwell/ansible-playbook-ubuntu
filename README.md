Ansible Playbook for Ubuntu
===========================

[![Build Status](https://travis-ci.org/pantarei/ansible-playbook-ubuntu.svg?branch=master)](https://travis-ci.org/pantarei/ansible-playbook-ubuntu)
 [![GitHub tag](https://img.shields.io/github/tag/pantarei/ansible-playbook-ubuntu.svg)](https://github.com/pantarei/ansible-playbook-ubuntu)
 [![GitHub license](https://img.shields.io/github/license/pantarei/ansible-playbook-ubuntu.svg)](https://github.com/pantarei/ansible-playbook-ubuntu/blob/master/LICENSE)

Ansible Playbook for Ubuntu Installation.

Requirements
------------

This playbook require Ansible 1.9 or higher.

This playbook was designed for Ubuntu Server 14.04 LTS.

Quick Start
-----------

All-in-one (AIO) builds are a great way to perform an Ubuntu build for

-   A development environment
-   An overview of how all of the Ubuntu services fit together
-   A simple lab deployment

Although AIO builds aren’t recommended for large production deployments,
 they’re great for smaller proof-of-concept deployments.

AIO in One Step
---------------

For a one-step build, there is a [convenient
 script](https://raw.githubusercontent.com/pantarei/ansible-playbook-ubuntu/master/scripts/run-aio-build.sh)
 within the ansible-playbook-ubuntu repository that will run a AIO build
 with defaults:

    bash <(curl -sL https://raw.githubusercontent.com/pantarei/ansible-playbook-ubuntu/master/scripts/run-aio-build.sh)

It’s advised to run this build within a terminal muxer, like tmux or
 screen, so that you don’t lose your progress if you’re disconnected from
 your terminal session.

AIO with Customization
----------------------

There are four main steps for running a customized AIO build:

-   Install Ansible
-   Initial roles, vars and hosts bootstrap
-   Configuration *(this step is optional)*
-   Run playbooks

Start by cloning the ansible-playbook-ubuntu repository and changing
 into the repository root directory:

    $ git clone https://github.com/pantarei/ansible-playbook-ubuntu.git \
        /opt/ansible-playbook-ubuntu
    $ cd /opt/ansible-playbook-ubuntu

Next bootstrap Ansible by executing:

    $ scripts/bootstrap-ansible.sh

Now we can bootstrap Ansible's roles, vars and hosts by executing:

    $ scripts/bootstrap-roles.sh
    $ scripts/bootstrap-vars.sh
    $ scripts/bootstrap-hosts.sh

By default the scripts deploy only general Ubuntu setup. At this point
 you may optionally adjuct which services are deployed within your AIO
 build. Look at the `group_vars/all` and `hosts` for more details. For
 example, if you'd like to upgrade your Ubuntu set the `apt_upgrade`
 as `full` at `group_vars/all`:

    apt_upgrade: full

Finally, run the plabooks by executing:

    $ ansible-playbook -i hosts playbooks/run-aio-build.yml

Dependencies
------------

-   [hswong3i.apache2](https://github.com/pantarei/ansible-role-apache2)
-   [hswong3i.apt](https://github.com/pantarei/ansible-role-apt)
-   [hswong3i.hostname](https://github.com/pantarei/ansible-role-hostname)
-   [hswong3i.java](https://github.com/pantarei/ansible-role-java)
-   [hswong3i.locales](https://github.com/pantarei/ansible-role-locales)
-   [hswong3i.mysql](https://github.com/pantarei/ansible-role-mysql)
-   [hswong3i.ntp](https://github.com/pantarei/ansible-role-ntp)
-   [hswong3i.php](https://github.com/pantarei/ansible-role-php)
-   [hswong3i.postgresql](https://github.com/pantarei/ansible-role-postgresql)
-   [hswong3i.tzdata](https://github.com/pantarei/ansible-role-tzdata)
-   [hswong3i.ufw](https://github.com/pantarei/ansible-role-ufw)
-   [hswong3i.usermin](https://github.com/pantarei/ansible-role-usermin)
-   [hswong3i.webmin](https://github.com/pantarei/ansible-role-webmin)

License
-------

-   Code released under [MIT](https://github.com/hswong3i/ansible-playbook-ubuntu/blob/master/LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>

