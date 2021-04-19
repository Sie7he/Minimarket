2

$('#cargar').click(function() {

  $('#cargar').fadeOut();
  let url = 'http://localhost:3000/clientes/listaClientes';

   $('#tablaArticulos').DataTable({            
      "ajax":{
          "url": url,
          "dataSrc":""
      },
      "language": {

        "lengthMenu": "Mostrar _MENU_ registros",

        "zeroRecords": "No se encontraron resultados",

        "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",

        "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",

        "infoFiltered": "(filtrado de un total de _MAX_ registros)",

        "sSearch": "Buscar:",

        "oPaginate": {

            "sFirst": "Primero",

            "sLast":"Último",

            "sNext":">>",

            "sPrevious": "<<"

         },

         "sProcessing":"Procesando...",

    },
      "columns":[
          {"data":"rut"},
          {"data":"nombre"},
          {"data":"paterno"},
          {"data":"materno"},
          {"data":"telefono"},
          {"data":"correo"},
          {"defaultContent":  `<td>  <a href='clientes/editarCliente/' class='edit' title='Actualizar' data-toggle='tooltip'><i class='material-icons'>&#xE254;</i></a></td>`+
          "<td>  <a href='clientes/eliminarCliente/{{Rut}}'  class='delete' title='Eliminar' data-toggle='tooltip'><i class='material-icons'>&#xE872;</i></a> </td>"}
      ],             
  });

});

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
            var value2 = data[i]['Id_Comuna'];
            $("#comunas").append("<option value='" + value2 + "' >" + value1 + "</option>");
  
          }
        }
  
      }
    });
  });

  function detalle(rut) {
    $.ajax({
      url: "/clientes/detalle/" + rut,
      type: "GET",
      success: function (data) {    
        $('.tbDetalle').empty();
        $.each(data, function (i, item) {
          $('#detalleCliente').append(
            $('<tr>'),
            $('<td>').text(item.Sexo),
            $('<td>').text(item.Calle +" "+ item.Numero),
            $('<td>').text(item.Comuna),
            $('<td>').text(item.Region),
            $('<td>').text(item.Tipo)
          ); 
        }
        );
      }
    })
  };

