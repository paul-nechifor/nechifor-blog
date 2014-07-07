var exec = require('child_process').exec;

module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      main: ['build']
    },
    copy: {
      main: {
        files: [
          {
            expand: true,
            src: ['posts/*'],
            flatten: true,
            dest: 'build/_posts'
          },
          {
            expand: true,
            src: ['images/*'],
            flatten: true,
            dest: 'build/images'
          },
          {
            expand: true,
            src: ['_config.yml'],
            dest: 'build'
          }
        ]
      }
    },
    jade: {
      main: {
        files: {
          'build/_layouts/post.html': ['views/post.jade'],
          'build/index.html': ['views/index.jade']
        }
      }
    },
    stylus: {
      main: {
        files: {
          'build/s/c/site.css': ['styles/site.styl']
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask('jekyll', function () {
    var done = this.async();
    exec('cd build; jekyll build', function (err) {
      done(err);
    });
  });

  grunt.registerTask('logos', function () {
    var done = this.async();
    var files = ['logo.png', 'logo57.png', 'logo152.png'].map(function (f) {
      return '/home/p/pro/nechifor-logo/' + f;
    }).join(' ');
    exec('cp ' + files + ' build/s', function (err) {
      done(err);
    });
  });

  grunt.registerTask('default', ['clean', 'copy', 'jade', 'stylus', 'logos',
    'jekyll']);
};
