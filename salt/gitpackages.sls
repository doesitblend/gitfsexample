setup_pip:
  pkg.installed:
    - name: python2-pip
  
install_git:
  pkg.installed:
    - name: git
  
install_python_git_stuff:
  pip.installed:
    - name: GitPython==1.0.1
    - require:
      - pkg: setup_pip
