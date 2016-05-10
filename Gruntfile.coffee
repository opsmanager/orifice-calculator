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
      spec:
        expand: true
        flatten: false
        cwd: 'spec'
        src: ['**/*.haml']
        dest: 'build'
        ext: '.html'
    copy:
      spec:
        files:
          'build/js/lib/jasmine-jquery.js': 'node_modules/jasmine-jquery/lib/jasmine-jquery.js'
          'build/js/lib/jquery.min.js': 'node_modules/jquery/dist/jquery.min.js'
          'build/js/lib/knockout-latest.js': 'node_modules/knockout/build/output/knockout-latest.js'
    jasmine:
      spec:
        src: ['build/js/**/main.js']
        options:
          specs: 'build/js/**/*-spec.js'
          vendor: [
            'build/js/lib/knockout-latest.js'
            'build/js/lib/jquery.min.js'
            'build/js/lib/jasmine-jquery.js'
            'https://cdnjs.cloudflare.com/ajax/libs/require.js/2.2.0/require.js'
          ]

    concurrent:
      dist:
        ['watch:coffee', 'watch:haml']
    watch:
      coffee:
        files: ["src/js/**/*.coffee"]
        tasks: ["compile:coffee:dist"]
      haml:
        files: ["src/**/*.haml"]
        tasks: ["compile:haml:dist"]
      spec_coffee:
        files: ["spec/js/**/*.coffee"]
        tasks: ["compile:coffee:spec"]
      spec_haml:
        files: ['spec/**/*.haml']
        tasks: ["compile:haml:spec"]

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
  grunt.loadNpmTasks 'grunt-concurrent'

  grunt.registerTask 'test', ['compile', 'connect:server', 'watch']
  grunt.registerTask 'compile', ['coffee', 'haml', 'copy']
  grunt.registerTask 'server', ['compile', 'connect:server', 'concurrent:dist']
