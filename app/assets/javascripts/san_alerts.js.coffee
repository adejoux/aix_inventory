# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ready =->
  $('#alert_datatable').dataTable
    bJQueryUI: true
    sPaginationType: "bootstrap"
    sDom: 'T<"clear"><"fg-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"fg-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"ip>'


$(document).ready(ready)
$(document).on('page:load', ready)