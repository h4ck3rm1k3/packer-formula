
# http://www.packer.io/downloads.html
{% set PACVER = salt['pillar.get']('packer:PACVER', "0.5.2") %}
{% set PACARCH = grains['osarch'].lstrip('i') %}  # 386 || amd64
{% set PACKER = "%s_linux_%s.zip" % (PACVER, PACARCH) %}
{% set PACSHA = "%s_SHA256SUMS?direct" % PACVER %}
{% set PAC_URL = "https://dl.bintray.com/mitchellh/packer" %}
{% set PAC_SHA_URL = "%s/%s" % (PAC_URL, PACSHA) %}
{% set PACKER_URL = "%s/%s" % (PAC_URL, PACKER) %}
{% set PAC_SHA256 = salt['pillar.get']('packer:PAC_SHA256', 
  "813f856a3d326d2a65f561edac8050d981f93ea51da03b0fb6b3d72010a5fc96") %}

{# TODO:
  - /opt/packer/bin ? /usr/local/bin? 
  - update $PATH=/opt/packer:$PATH
  #}

packer_binary:
  archive:
    - extracted
    - name: /opt/packer
    - source: {{ PACKER_URL }}
    - source_hash: sha256={{ PAC_SHA256 }}
    #- source_hash: {{ PAC_SHA_URL }}
    - archive_format: zip


