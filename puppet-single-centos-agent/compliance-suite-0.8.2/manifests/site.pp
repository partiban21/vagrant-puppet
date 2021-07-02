
node default {

  include profiles::compliance::cron
  # include profiles::python::python
  include profiles::java
  # include profiles::gitlab::server
  
}
