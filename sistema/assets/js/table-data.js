$(function (e) {
  //______Basic Data Table
  $("#basic-datatable").DataTable({
    language: {
      url: "assets/js/Portuguese-Brasil.json",
    },
  });

  //______Input fields Data Table
  $("#input-fields").DataTable({
    language: {
      url: "assets/js/Portuguese-Brasil.json",
    },
    columnDefs: [{ orderable: false, targets: [1, 2, 3, 4, 5, 6, 7] }],
  });

  //______Basic Data Table
  $("#responsive-datatable").DataTable({
    responsive: true,
    language: {
      url: "assets/js/Portuguese-Brasil.json",
    },
  });

  //______File-Export Data Table
  var table = $("#file-datatable").DataTable({
    buttons: ["copy", "excel", "pdf", "colvis"],
    responsive: true,
    language: {
      url: "assets/js/Portuguese-Brasil.json",
    },
  });
  table
    .buttons()
    .container()
    .appendTo("#file-datatable_wrapper .col-md-6:eq(0)");

  //______Delete Data Table
  var table = $("#delete-datatable").DataTable({
    language: {
      url: "assets/js/Portuguese-Brasil.json",
    },
  });
  $("#delete-datatable tbody").on("click", "tr", function () {
    if ($(this).hasClass("selected")) {
      $(this).removeClass("selected");
    } else {
      table.$("tr.selected").removeClass("selected");
      $(this).addClass("selected");
    }
  });
  $("#button").click(function () {
    table.row(".selected").remove().draw(false);
  });

  //______Select2
  $(".select2").select2({
    minimumResultsForSearch: Infinity,
    width: "auto",
  });
});
