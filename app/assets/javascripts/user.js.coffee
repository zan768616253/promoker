$ ->
    $('#user-save').click () ->
      tags = []
      for elem in $('form.edit-user span.tag.selected')
        tag = $(elem).text().trim() 
        tags.push(tag)
      $('#user_roles').val(tags)
      $('form.edit-user').submit()
    ias = {}
    previewfile = (file) ->
      if tests.filereader is true and acceptedTypes[file.type] is true
        reader = new FileReader()
        reader.onload = (event) ->
          image = new Image()
          image.src = event.target.result
          image.id = "photo"
          $(image).data('width',image.width)
          $(image).data('height',image.height)
          $('.preview img').attr('src', event.target.result)
          holder.appendChild image
          preview = (img, selection) ->
            return  if not selection.width or not selection.height
            $('#user_crop_x1').val(selection.x1);
            $('#user_crop_y1').val(selection.y1);
            $('#user_crop_w').val(Math.round(selection.width/img.width * $(img).data('width')));
            $('#user_crop_h').val(Math.round(selection.height/img.height * $(img).data('height')));    
            scaleX = 180 / selection.width
            scaleY = 180 / selection.height
            $(".preview.icon-180 img").css
              width: Math.round(scaleX * img.width)
              height: Math.round(scaleY * img.height)
              marginLeft: -Math.round(scaleX * selection.x1)
              marginTop: -Math.round(scaleY * selection.y1)

            scaleX = 50 / selection.width
            scaleY = 50 / selection.height
            $(".preview.icon-50 img").css
              width: Math.round(scaleX * img.width)
              height: Math.round(scaleY * img.height)
              marginLeft: -Math.round(scaleX * selection.x1)
              marginTop: -Math.round(scaleY * selection.y1)
            scaleX = 30 / selection.width
            scaleY = 30 / selection.height
            $(".preview.icon-30 img").css
              width: Math.round(scaleX * img.width)
              height: Math.round(scaleY * img.height)
              marginLeft: -Math.round(scaleX * selection.x1)
              marginTop: -Math.round(scaleY * selection.y1)
            return
          width = $("#photo").width()
          height = $("#photo").height()
          empty = (obj) ->
            for k of obj
              return false
            true
          if not empty(ias)
            ias.remove()
          ias = $("#photo").imgAreaSelect
            instance: true
            aspectRatio: "1:1"
            x1: (width - 180)/2
            y1: (height - 180)/2
            x2: (width - 180)/2 + 180
            y2: (height - 180)/2 + 180
            handles: true
            onSelectChange: preview
            onInit: preview
          return
        reader.readAsDataURL file
      else
        holder.innerHTML += "<p>Uploaded " + file.name + " " + ((if file.size then (file.size / 1024 | 0) + "K" else ""))
        console.log file
      return
    holder = document.getElementById("holder")
    if not holder
      return
    tests =
      filereader: typeof FileReader isnt "undefined"
      dnd: "draggable" of document.createElement("span")
      progress: "upload" of new XMLHttpRequest

    support =
      filereader: document.getElementById("filereader")
      progress: document.getElementById("progress")

    acceptedTypes =
      "image/png": true
      "image/jpeg": true
      "image/gif": true

    progress = document.getElementById("uploadprogress")
    fileupload = document.getElementById("upload")

    "filereader progress".split(" ").forEach (api) ->
      if tests[api] is false
        support[api].className = "fail"
      else
        support[api].className = "hidden"  if support[api]
      return

    if tests.dnd 
      holder.ondragover = ->
        $(this).addClass("hover")
        false

      holder.ondragend = ->
        $(this).removeClass("hover")
        false

      holder.ondrop = (e) ->
        $(this).removeClass("hover")
        e.preventDefault()
        holder.innerHTML = ""
        previewfile e.dataTransfer.files[0];
        return
    fileupload.querySelector("input").onchange = ->
      holder.innerHTML = ""
      previewfile @files[0]
      return
    # preview = (img, selection) ->
    #     scaleX = 100 / (selection.width || 1);
    #     scaleY = 100 / (selection.height || 1);
      
    #     $('#photo + div > img').css
    #         width: Math.round(scaleX * 160) + 'px',
    #         height: Math.round(scaleY * 160) + 'px',
    #         marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
    #         marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
    # $('<div><img src="" style="position: relative;" /><div>').css(
    #     float: 'left',
    #     position: 'relative',
    #     overflow: 'hidden',
    #     width: '100px',
    #     height: '100px'
    # ).insertAfter($('#photo'));
    # $('img#photo').imgAreaSelect
    #     maxWidth: 150
    #     maxHeight: 150
    #     handles: true
        # onSelectChange: preview
