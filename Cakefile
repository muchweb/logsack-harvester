{spawn, exec} = require 'child_process'
fs = require 'fs'

TEMPLATE_SRC = "#{__dirname}/templates"
TEMPLATE_OUTPUT = "#{__dirname}/src/templates.coffee"

# Main build task
task 'build', 'Builds faggot-io package', ->
  invoke 'templates'

# Building templates
decorateTemplateForExports = (f) ->
  templateName = f.replace '.html', ''
  templateExportName = templateName.replace '-', '.'
  templateFilePath = "#{TEMPLATE_SRC}/#{f}"
  body = fs.readFileSync templateFilePath, 'utf-8'
  content = "exports.#{templateExportName} = \"\"\"#{body}\"\"\""

task 'templates', 'Compiles templates/*.html to src/templates.coffee', ->
  console.log 'Generating src/templates.coffee from templates/*.html'
  files = fs.readdirSync TEMPLATE_SRC
  templateBlocks = (decorateTemplateForExports f for f in files)
  content = '# TEMPLATES.COFFEE IS AUTO-GENERATED. CHANGES WILL BE LOST!\n'
  content += templateBlocks.join '\n\n'
  fs.writeFileSync TEMPLATE_OUTPUT, content, 'utf-8'

# Creating config files if do not exists
task 'ensure:configuration', 'Ensures that config files exist in ~/.faggot-io/', ->
  console.log 'Creating ~/.faggot-io/ for configuration files.'
  console.log 'If this fails, run npm using a specific user: npm install -g faggot-io --user \'ubuntu\''
  homedir = process.env[if process.platform is 'win32' then 'USERPROFILE' else 'HOME']
  console.log "Detected home directory: #{homedir}"
  ldir = homedir + '/.faggot-io/'
  console.log "Creating faggot-io config directory: #{ldir}"
  fs.mkdirSync ldir if not fs.existsSync ldir
  for c in ['harvester', 'log_server', 'web_server']
    path = ldir + "#{c}.conf"
    if not fs.existsSync path
      console.log "Created new configuration file: #{path}"
      fs.createReadStream("./conf/#{c}.conf").pipe fs.createWriteStream path
    else
      console.log "Configuraton file already exists: #{path}"

task 'cleanup', 'Removes temporary files', ->
  if fs.existsSync 'src/templates.coffee'
    console.log 'Removing', 'src/templates.coffee'
    fs.unlinkSync 'src/templates.coffee'
  if fs.existsSync 'lib/'
    for k, i of fs.readdirSync 'lib/'
      console.log 'Removing', "lib/#{i}"
      fs.unlinkSync "lib/#{i}"
    console.log 'Removing', 'lib/'
    fs.rmdirSync 'lib/'
  console.log 'Project is clean.'
