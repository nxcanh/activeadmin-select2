'use strict';

initSelect2 = (inputs, extra = {}) ->
  if !inputs[0]
    return

  inputs.each ->
    select_data = []
    origin_data = []

    item = $(this)

    isMultiple = item[0].multiple
    isLockColl = item.data("lockCollection")

    models = item.data("select2")
    for prop of models
      model_item = models[prop]
      object_type = Object.prototype.toString.call(model_item)
      
      if object_type == '[object String]'
        select_data.push
          id: model_item
          text: model_item

      if object_type == '[object Array]'
        select_data.push
          id: model_item[1]
          text: model_item[0]

      if object_type == '[object Object]'
        select_data.push
          id: model_item['id']
          text: model_item['text']
      

    if !select_data.length
      select_data.push
        id: " "
        text: " "

    if(models)
      origin_data = models

    # reading from data allows
    if isLockColl
      options = $.extend(
        allowClear: true,
        extra
        multiple: isMultiple
        data: select_data
      )
    else
      options = $.extend(
        allowClear: true,
        extra
        createSearchChoice: (term, data) ->
          if $(data).filter((->
            @text.localeCompare(term) == 0
          )).length == 0
            return {
              id: term
              text: term
            }
          return
        multiple: isMultiple
        data: select_data
      )

    # because select2 reads from input.data to check if it is select2 already
    item.data('select2', null)
    item.select2(options)


    if !isMultiple
      item.on 'change', (e) ->
        container = $(item.select2('container'))
        i = 0
        while i < container.children().length
          if container.children()[i].className.indexOf('select2-choice') != -1
            note = container.children()[i]
            break
          i++

        if(e.val && e.val.trim() && contain(origin_data, e.val.trim()))
            $(note).addClass('has-warning')
        else
          $(note).removeClass('has-warning')
        return

    return

contain = (array, elem) ->
  i = 0
  while i < array.length
    if(array[i] == elem)
      break
    i++

  if(i == array.length)
    return true

  return false

$(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
  initSelect2(fieldset.find('.select2-input'))

$(document).on 'ready page:load turbolinks:load', ->
  initSelect2($(".select2-input"), placeholder: "")
  return
