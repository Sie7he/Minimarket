
  let url = 'http://localhost:3000/clientes/listaClientes';        
  let tablaClientes =  $('#tablaArticulos').DataTable({    
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
      {"data":"rut",},
      {"data":"nombre"},
      {"data":"paterno"},
      {"data":"materno"},
      {"data":"telefono"},
      {"data":"correo"},
      {"data" :"rut",  render:function(data)
      {
        return `<td>  <a href='/clientes/editarCliente/`+data+`' class='edit' title='Actualizar' data-toggle='tooltip'><i class='material-icons'>&#xE254;</i></a></td>`+
               `<td>  <a href='#' onClick='eliminarCliente("`+data+`")'class='delete' title='Eliminar' data-toggle='tooltip'><i class='material-icons'>&#xE872;</i></a> </td>`
      }}
  ],             
});

function eliminarCliente(id) {

  Swal.fire({
    title: 'Estas seguro?',
    text: "No podrás revertir esto!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Borrar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {

      $.ajax({

        url: "/clientes/eliminarCliente/" + id,
        type: "POST",
        data: {
          id: id
        },
        success: () => {
          tablaClientes.ajax.reload();      
          Swal.fire(
            'Eliminado!',
            'El cliente ha sido eliminado.',
            'success'
          );
        }
      });
    }
  })


};

$('#SubRubro').change(function () {
  const rubro = $('#SubRubro').val();
  $('#CodigoBarra').val(rubro); 
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



  let url2 = 'http://localhost:3000/productos/listaProductos';        
  let tablaProductos =  $('#tablaProductos').DataTable({    
  "ajax":{
      "url": url2,
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
      {"data":"idProductos",},
      {"data":"nombre"},
      {"data":"categoria"},
      {"data":"codigoBarra"},
      {"data":"Descripcion"},
      {"data":"Gramage"},
      {"data":"medida"},
      {"data":"PrecioUnitario"},
      {"data":"Stock"},
      {"data" :"idProductos",  render:function(data)
      {
        return `<td>  <a href='/productos/editarProductos/`+data+`' class='edit' title='Actualizar' data-toggle='tooltip'><i class='material-icons'>&#xE254;</i></a></td>`+
               `<td>  <a href='#' onClick='eliminarProductos("`+data+`")'class='delete' title='Eliminar' data-toggle='tooltip'><i class='material-icons'>&#xE872;</i></a> </td>`
      }}
      
     
  ],             
});

function eliminarProductos(id) {

  Swal.fire({
    title: 'Estas seguro?',
    text: "No podrás revertir esto!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Borrar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {

      $.ajax({

        url: "/clientes/eliminarCliente/" + id,
        type: "POST",
        data: {
          id: id
        },
        success: () => {
          tablaClientes.ajax.reload();      
          Swal.fire(
            'Eliminado!',
            'El cliente ha sido eliminado.',
            'success'
          );
        }
      });
    }
  })


};