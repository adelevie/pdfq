MRuby::Gem::Specification.new('pdfq') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'pdfq'
  spec.bins    = ['pdfq']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-array-ext', :core => 'mruby-array-ext'
  spec.add_dependency 'mruby-docopt', :github => 'hone/mruby-docopt'
end
