ltfll_design =
{
    _headerHtml: "<span class=\"ltfll_title\"><span class=\"ltfll_logo\" onclick=\"ltfll_design.LogoUrlClick()\"></span><span class=\"ltfll_content\">${Title}</span></span>"
	,_helpHtml: "<div class=\"ltfll_help\" onclick=\"ltfll_design.HelpClick()\"><a href=\"javascript:void()\" onclick=\"return false;\">${Help}</a></div>"

    ,Init: function(arg) {
		if(arguments.length < 1) arg={};

		document.title = Strings.ApplicationTitle;
		
		var headerHtml = Tools.GetString(this._headerHtml, {Title: document.title});
		
		if(arg.showHelp) {
			headerHtml += Tools.GetString(this._helpHtml, {Help: Strings.HelpLink});
		}
		
		document.getElementById("ltfll_header").innerHTML = headerHtml;

		if (!arg.showLogo) $(".ltfll_logo").remove();
		if (!arg.showFooter) $("#ltfll_footer").remove();
    }

	, HelpClick: function()
	{
		window.open('help/index.html', 'ltff_help', 'width=350,height=300');
	}
	
    , LogoUrlClick: function() {
        window.open('http://www.ltfll-project.org/');
    }
}
