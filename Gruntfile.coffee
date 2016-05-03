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
        dest: 'build/js'
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
      spec:
        files:
          'build/js/lib/jasmine-jquery.js': 'node_modules/jasmine-jquery/lib/jasmine-jquery.js'
          'build/js/lib/jquery.min.js': 'node_modules/jquery/dist/jquery.min.js'
          'build/js/lib/knockout-latest.js': 'node_modules/knockout/build/output/knockout-latest.js'
    jasmine:
      spec:
        src: ['build/js/**/orifice-calculator.js', 'build/js/**/dictionaries.js']
        options:
          specs: 'build/js/**/*-spec.js'
          helpers: 'build/js/*-helper.js'
          vendor: [
            'build/js/lib/knockout-latest.js'
            'build/js/lib/jquery.min.js'
            'build/js/lib/jasmine-jquery.js'
          ]

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

  #Load Tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-haml2html'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  grunt.registerTask 'test:setup', ['coffee', 'haml:dist', 'copy:spec']
  grunt.registerTask 'test', ['coffee:spec', 'jasmine']
  grunt.registerTask 'compile', ['coffee', 'haml', 'copy']
  grunt.registerTask 'server', ['connect:server', 'watch']
