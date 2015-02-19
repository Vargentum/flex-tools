gulp = require('gulp')
plugins = require('gulp-load-plugins')()
connect = require('gulp-connect') # don't work from plugins.connect
minifyCSS = require('gulp-minify-css')

path =
  dist: 'dist'
  docs: 
    base: 'docs/'
    jade: 'src/docs.jade'
    styles: 'src/docs.styl'
    coffee: 'src/docs.coffee'
    
  flexTools: 'src/flex-tools.styl'
  
  clean: ['./dist', './docs']


server = 
  port: '9999'
  root: 'docs'


gulp.task 'jade:docs', ->
  gulp.src(path.docs.jade)
    .pipe(plugins.jade())
    .pipe(plugins.rename('index.html'))
    .pipe(gulp.dest(path.docs.base))
    .pipe(connect.reload())

gulp.task 'coffee:docs', ->
  gulp.src(path.docs.coffee)
    .pipe(plugins.coffee())
    .pipe(gulp.dest(path.docs.base))
    .pipe(connect.reload())

gulp.task 'styles:docs', ->
  gulp.src(path.docs.styles)
    .pipe(plugins.stylus())
    .pipe(gulp.dest(path.docs.base))
    .pipe(connect.reload())

gulp.task 'flex-tools', ->
  gulp.src(path.flexTools)
    .pipe(plugins.stylus())
    .pipe(plugins.autoprefixer())
    .pipe(gulp.dest(path.dist))
    .pipe(plugins.rename('flex-tools.min.css'))
    .pipe(minifyCSS())
    .pipe(gulp.dest(path.dist))
    .pipe(connect.reload())

gulp.task 'server', ->
  connect.server(
    port: server.port
    root: server.root
    livereload: yes
  )

gulp.task 'clean', ->
  gulp.src(path.clean)
    .pipe(plugins.clean())


gulp.task 'watch', ->
  plugins.watch([path.docs.jade], ->
    gulp.start 'jade:docs'
  )
  plugins.watch([path.docs.styles], ->
    gulp.start 'styles:docs'
  )
  plugins.watch([path.docs.coffee], ->
    gulp.start 'coffee:docs'
  )
  plugins.watch([path.flexTools], ->
    gulp.start 'flex-tools'
  )


gulp.task 'default', [
  'clean'
  'flex-tools'
  'jade:docs'
  'styles:docs'
  'coffee:docs'
  'server'
  'watch'
]