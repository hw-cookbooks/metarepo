default['metarepo']['directory'] = "/opt/metarepo"
default['metarepo']['git_url'] = "git://github.com/adamhjk/metarepo.git"
default['metarepo']['git_action'] = :sync
default['metarepo']['user'] = "nobody"
default['metarepo']['group'] = "nogroup"

default['metarepo']['database']['name'] = "metarepo"
default['metarepo']['database']['user'] = "nobody"
default['metarepo']['database']['password'] = nil
default['metarepo']['database']['host'] = "%"
default['metarepo']['database']['privileges'] = %w{select grant update}.map(&:to_sym)
