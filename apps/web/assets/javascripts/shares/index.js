jQuery(document).ready(function () {
    notify(setClient('http://localhost:8080/faye'), '/messages/all', '#share-updates', reSearch); // FIXME! ROMAN! Faye server!

    $('table.search-table').tableSearch({
        searchText:' ',
        searchPlaceHolder:'Search by trading code',
        className: 'form-control',
        id: 'search-term'
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
 * @param callback
 */
function notify(client, channel, container, callback)
{
    client.subscribe(channel, function (content) {
        $(container).html(content);
        callback();
    });
}

/**
 *
 */
function reSearch()
{
    $('#search-term').keyup();
}