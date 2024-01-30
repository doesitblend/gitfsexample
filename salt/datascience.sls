{# data_science_deps:
  pip.installed:
    - names:
      - numpy
      - pandas
      - scipy

install_data_tool_kit:
  pip.installed:
    - name: scikit-learn
    #}

do_a_data_science_thing:
  cmd.run:
    - name: echo "{{ pillar[git_branch] }}"
