jQuery(document).ready(function () {
    var faye = new Faye.Client('http://localhost:8080/faye'); // FIXME! ROMAN!

    faye.subscribe('/messages/all', function (content) {
        $('#share-updates').html(content);
    });
});