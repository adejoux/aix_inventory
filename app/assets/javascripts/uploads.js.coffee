jQuery ->
  $('#fileupload').fileupload
    dataType: "script"
    add: (e, data) ->
      data.context = $(tmpl("template-upload", data.files[0]).trim())
        .appendTo('#fileupload')
        .on 'click', '.upload', (event) ->
          data.submit()
          return false
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e,data) ->
      $('#fileupload').unbind('click')
      return false
