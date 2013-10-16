if !File.exists?(Rails.root.join('config', 'facebooker.yml'))
  $stderr.puts "\nATTENTION ReDSSoCS DEVELOPER:\n\n" +
    "The file 'config/facebooker.yml' does not exist, and so the server is exiting.\n" +
    "Please create a symbolic link to one of the 'facebooker.yml.{config_name}' files \n" +
    "in the config directory, e.g.:\n\n" +
    "  cd config\n" +
    "  ln -s facebooker.yml.homanator facebooker.yml\n\n" +
    "You may need to create a configuration file for your copy of the project.\n\n" +
    "EXITING WITH ERROR!\n\n"
  Process.exit
end

Facebooker2.load_facebooker_yaml
