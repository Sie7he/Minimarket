$("#region").change(function () {
    const id = $("#region").val();
    $.ajax({
      url: "/clientes/regiones/" + id,
      type: "GET",
      success: function (data) {
  
        var len = data.length;
        if (len <= 0) {
          $("#comunas").empty();
          $("#comunas").append("<option value='0'>Seleccione Su Comuna...</option>");
        } else {
          $("#comunas").empty();
          for (var i = 0; i < len; i++) {
            var value1 = data[i]['Nombre'];
            var value2 = data[i]['ID_Comuna'];
            $("#comunas").append("<option value='" + value2 + "' >" + value1 + "</option>");
  
          }
        }
  
      }
    });
  });