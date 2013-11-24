DEVELOPMENT ENVIRONMENT CONFIGURATION  (one time only)
=====================================

  The ReDSSoCS app is written in Ruby on Rails.  The app uses Gem
  Bundler (http://gembundler.com) to manage Gem dependencies.

  To make certain that you are using the most recent version of
  Bundler, run the following command:

    sudo gem update bundler



  Configuring OS X for development
  --------------------------------

  You will need to download and install MySQL server.  The ReDSSoCS
  app has been tested with the MySQL 5.5.x series.  You can get the
  most recent version of the MySQL 5.5 series from:

    http://dev.mysql.com/downloads/mysql/5.5.html#downloads


  Configuring Ubuntu for development
  ----------------------------------

  You will need to install (at least) the following Ubuntu packages in
  order to run this app on Ubuntu:

    libmysqlclient-dev
    libsqlite3-dev
    nodejs-dev
    mysql-server




UPDATING THE ReDSSoCS APP
=========================

  Go to the ReDSSoCS directory:
  
    cd ReDSSoCS
    
  Install the required versions of the Gem libraries using Bundler:

    bundle install

  Create database entries for this application's surveys (WARNING - this
  will destroy the database, so do not run this command on a production
  server):

    ./regenerate_surveys



RUNNING THE ReDSSoCS APP (on a development machine)
========================

  From the ReDSSoCS directory, start the development server on your
  machine using:

    rails server

  Next, open up another terminal window, and start a Facebook tunnel
  using:

    rake facebooker:tunnel:start

  The following command kills all processes on the server listening on
    port 7007. It is useful for recovering from a hung tunnel.

    kill -9 `lsof -t -i:7007`

 Note: this was installed with ruby 2.0.0. You may need to make sure
 this is the version you are using before running bundle update.

 If running on chiron, the group of all files in this directory tree needs to be changed to 'webgroup.'

To start, go to the url BASE/recruit/invitation/814
