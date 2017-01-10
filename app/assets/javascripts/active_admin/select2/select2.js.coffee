'use strict';

select_data = []

initSelect2 = (inputs, extra = {}) ->
  inputs.each ->
    item = $(this)

    models = item.data('select2')
    for prop of models
      select_data.push
        id: models[prop]
        text: models[prop]

    # reading from data allows
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
      multiple: false
      data: select_data
    )

    # because select2 reads from input.data to check if it is select2 already
    item.data('select2', null)
    item.select2(options)

    item.on 'select2-selecting', (e) ->
      console.log(e)
      console.log(select_data)
      return

$(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
  initSelect2(fieldset.find('.select2-input'))

$(document).on 'ready page:load turbolinks:load', ->
  initSelect2($(".select2-input"), placeholder: "")
  return
