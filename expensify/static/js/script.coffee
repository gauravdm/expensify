$(document).ready ->
  $(".nav li").removeClass("active").find("a[href='#{window.location.pathname}']").closest("li").addClass("active")



$(".action_button").live
  click: (e)->
    e.preventDefault()
    if $(@).attr("action") == "mark_as_claimed"
      $("[name='mark_as']").val "True"
    else if $(@).attr("action") == "rejected"
      $("[name='mark_as']").val "rejected"


    selected_claims = ""
    for cb in $(".cb_claims")
      if $(cb).attr("checked")
        selected_claims += cb.id+";"
    selected_claims = selected_claims.substr(0, selected_claims.length-1)

    $("[name='selected']").val selected_claims
    $(@).closest('form').submit()

  $(".expense-list tr:not(:first-child)").live
    click: (e) ->
      if e.target.type == "checkbox"
        return
      if $(e.target).text() == "Edit"
        return

      id = e.id
      if $(".field_name").length > 0
        $(".td_name").text $(@).find(".field_name").text()
        $("#expense-detail").find(".modal-header h3").html "Expense details for "+$(@).find(".field_name").text()

      $(".td_category").text $(@).find(".field_category").text()
      $(".td_amount").text $(@).find(".field_amount").text()
      $(".td_date").text $(@).find(".field_date").text()
      $(".td_status").text $(@).find(".field_status span.badge").text()
      $(".td_description").text $(@).find(".description").val()
      if $(@).find(".invoice").val().trim().length > 0
        url_name_arr = $(@).find(".invoice").val().split(";")
        $(".td_invoice").html "<a href='#{url_name_arr[0]}' target='_blank' >#{url_name_arr[1]}</a>"
      else
        $(".td_invoice").text  "Not provided"
      $("#expense-detail").modal()


  $("body").on
    keyup: (e) ->
      if e.keyCode == 27
        $("#expense-detail").modal("hide")



$("#check_all").live
  click: ->
    if $(@).attr "checked"
      $("[type='checkbox']").attr("checked", "checked")
    else
      $("[type='checkbox']").removeAttr("checked")
