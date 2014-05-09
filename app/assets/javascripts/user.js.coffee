$ ->
    previewfile = (file) ->
      if tests.filereader is true and acceptedTypes[file.type] is true
        reader = new FileReader()
        reader.onload = (event) ->
          image = new Image()
          image.src = event.target.result
          image.id = "photo"
          fileupload.style.border = "none"
          holder.appendChild image
          document.getElementById('files').disabled = true
          $('img#photo').imgAreaSelect
            maxWidth: 150
            maxHeight: 150
            handles: true
          return
        reader.readAsDataURL file
      else
        holder.innerHTML += "<p>Uploaded " + file.name + " " + ((if file.size then (file.size / 1024 | 0) + "K" else ""))
        console.log file
      return
    holder = document.getElementById("holder")
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
    $('<div><img src="" style="position: relative;" /><div>').css(
        float: 'left',
        position: 'relative',
        overflow: 'hidden',
        width: '100px',
        height: '100px'
    ).insertAfter($('#photo'));
    # $('img#photo').imgAreaSelect
    #     maxWidth: 150
    #     maxHeight: 150
    #     handles: true
        # onSelectChange: preview
