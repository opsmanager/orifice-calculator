module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dist:
        expand: true
        flatten: false
        cwd: "src/js"
        src: ["**/*.coffee"]
        dest: 'build/js'
        ext: ".js"
      spec:
        expand: true
        flatten: false
        cwd: 'spec/js'
        src: ["**/*.coffee"]
        dest: 'spec/build/js'
        ext: '.js'
    haml:
      dist:
        expand: true
        flatten: false
        cwd: 'src'
        src: ['**/*.haml']
        dest: 'build'
        ext: '.html'
    copy:
      main:
        expand: true
        cwd: 'src'
        src: ['res/*', 'css/*']
        dest: 'build'
    jasmine:
      spec: {
        src: 'spec/build/*.js'
        options: {
          specs: 'spec/**/*-spec.js'
          template: require('grunt-template-jasmine-requirejs')
          templateOptions: {
            requireConfigFile: 'spec/build/js/main.js'
          }
        }
      }

    watch:
      coffee:
        files: ["src/js/**/*.coffee"]
        tasks: ["compile:coffee:dist"]
      haml:
        files: ["src/*.haml"]
        tasks: ["compile:haml"]
      static:
        files: ['src/res/*', 'src/css/*']
        tasks: ["compile:copy"]

    connect:
      server:
        options:
          port: 8000
          base: 'build'
      test:
        options:
          port: 5678
          base: 'spec'

  #Load Tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-haml2html'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  grunt.registerTask 'compile', ['coffee', 'haml', 'copy']
  grunt.registerTask 'server', ['connect:server', 'watch']
