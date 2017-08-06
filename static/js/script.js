function loadMoreNewsItems() {
   if(loadMoreNewsItems.hasMoreNews == "yes" && $(window).scrollTop() + $(window).height() == $(document).height()) {
    $.get('/news?page='+loadMoreNewsItems.page+"&size=5",{},function(response, status, jqXhr){
        loadMoreNewsItems.page = jqXhr.getResponseHeader('page');
        loadMoreNewsItems.hasMoreNews = jqXhr.getResponseHeader('hasMoreNews');
        $('#loaded-content').before(response);

        highlightCode();
    });
   }
}
loadMoreNewsItems.page = 1;
loadMoreNewsItems.hasMoreNews = "yes";


function renderDuringEdit() {
    $('#content').keyup(function()
    {
        $('#rendered').html($('#content').val());

        highlightCode();
    });
}

function highlightCode() {
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
}

