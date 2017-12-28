jQuery(document).ready(function () {
    notify(setClient('http://localhost:8080/faye'), '/messages/all', '#share-updates'); // FIXME! ROMAN! Faye server!

    $('table.search-table').tableSearch({
        searchText:' ',
        searchPlaceHolder:'Search by trading code',
        className: 'form-control'
    });
});

/**
 * @param url
 * @returns {*}
 */
function setClient(url)
{
    return new Faye.Client(url);
}

/**
 * @param client
 * @param channel
 * @param container
 */
function notify(client, channel, container)
{
    client.subscribe(channel, function (content) {
        $(container).html(content);
    });
}