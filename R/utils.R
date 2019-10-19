# copied from https://github.com/eddelbuettel/tint/blob/master/R/utils.R
template_resources = function(name, ...) {
  system.file('rmarkdown', 'templates', name, 'resources', ..., package = 'pandoclatextemplate')
}
