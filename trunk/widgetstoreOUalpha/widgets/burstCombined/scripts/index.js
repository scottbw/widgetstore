$(document).ready(function() {

    //var WS_DOMAIN="http://universe.stellarnet.eu/burstwebservice/";
    var WS_DOMAIN="http://ariadne.cs.kuleuven.be/researchfm-dev/api/";


    //load the ajax icon on results area - called before ajax request
    function showAjaxLoadingIcon(){
        $('#hits').html("<img src='images/ajax-loader.gif'></img>");
    }

    //Fills the publication details area with metadata of pub
    //fetched by an ajax request
    function updatePublicationDetails(pid){
        htmlContent="";
        url=WS_DOMAIN+"publications/"+pid;
        url=Widget.proxify(url);
        $.ajax({
            type : "GET",
            //data: "pid="+pid,
            dataType: 'json',
            url  : url,
            beforeSend:function(){
                $('#pubDetails').html("<img src='images/ajax-loader.gif'></img>");            
            },
            success: function(m){
                //alert('req done!');
                //alert(m["rdf:RDF"]["xmlns"]);
                pid=m["rdf:RDF"]["swrc:Publication"]["rdf:ID"];
                ptitle=m["rdf:RDF"]["swrc:Publication"]["swrc:title"];
                //pabstract=m["rdf:RDF"]["swrc:Publication"]["swrc:abstract"];
                //pwebLink=m["rdf:RDF"]["swrc:Publication"]["swrc:link"];
                //pdescription=m["rdf:RDF"]["swrc:Publication"]["swrc:description"];
                //planguage=m["rdf:RDF"]["swrc:Publication"]["xml:lang"];
                //pdate=m["rdf:RDF"]["swrc:Publication"]["dc:date"];
                pbooktitle=m["rdf:RDF"]["swrc:Publication"]["swrc:booktitle"];
                pyear=m["rdf:RDF"]["swrc:Publication"]["swrc:year"];
                pkeywords=m["rdf:RDF"]["swrc:Publication"]["swrc:keywords"];
                pconference=m["rdf:RDF"]["swrc:Publication"]["swrc:conference"];
                htmlContent="";
                htmlContent+="<p>Title:"+ptitle+"</p>";
                //if (pabstract!=undefined) htmlContent="<p>Abstract:"+pabstract+"</p>";
                htmlContent+="<p>Authors:";
                authors=m["rdf:RDF"]["swrc:Publication"]["swrc:author"];
                htmlContent+="<ul class=\"authorsList\">";
                for (i=0;i<authors.length;i++) {
                    ////console.log(a+"  =  "+authors[a]);
                    familyName =authors[i]["swrc:Person"]["foaf:family_name"];
                    givenName  =authors[i]["swrc:Person"]["foaf:family_name"];
                    htmlContent+="<li><p> <em>"+familyName+ " " +givenName+"</em>";
                    if (authors[i]["swrc:Person"]["swrc:affiliation"]!=undefined) htmlContent+=" affiliated to "+authors[i]["swrc:Person"]["swrc:affiliation"]["swrc:Organization"]["v:fn"]+"";
                    htmlContent+="<span style=\"display:none\">"+authors[i]["swrc:Person"]["rdf:ID"]+"</span>";
                    htmlContent+="<i>Add this author to your search</i>";
                    htmlContent+="</p>";
                    htmlContent+="</li>";
                }
                htmlContent+="</ul>";
                //if (pdescription!=undefined) htmlContent+="<p>Description:"+pdescription+"</p>";
                //if (planguage!=undefined) htmlContent+="<p>Language:"+planguage+"</p>";
//                if (pkeywords!=undefined) {
//                    htmlContent+="<p class=\"keywordsP\">Keywords:";
//                    keywordsArray=pkeywords.split(",");
//                    for (i=0;i<keywordsArray.length;i++) htmlContent+="<span class=\"keywordsListItem\"><em>"+keywordsArray[i].trim()+"</em> <i>[Add!]</i> ,</span>";
//                    htmlContent+="</p>";
//                }
                if (pyear!=undefined) htmlContent+="<p>Year:"+pyear+"</p>";
                if (pbooktitle!=undefined) htmlContent+="<p>Booktitle:"+pbooktitle+"</p>";
                if (pconference!=undefined) htmlContent+="<p>Conference:"+pconference+"</p>";

                //htmlContent+="<a href='http://universe.stellarnet.eu/burst/hitcount.php?id="+pid+"'target='_blank'>Download</a>";
                $('#pubDetails').html(htmlContent);

                $('#pubDetails ul.authorsList li i').click(function(){
                    switchTabs(2);
                    auid=$(this).parent().parent().find('span').text();
                    //auid=auid.substr(57);
                    console.log('auid='+auid);
                    insertToSelectedAuthors2(auid,$(this).parent().parent().find('em').text());
                });

                $('#pubDetails p.keywordsP i').click(function(){
                    switchTabs(3);
                    insertToSelectedKeywords2($(this).parent().find('em').text());
                });
            },
            error: function(m,n){
            ////console.log('error'+m+n);
            },
            complete: function(){
            ////console.log('complete');
            }
        });
    }

    //Input: json object
    //fills the results arwea accordingly
    function updatePublicationHits (m){
        //console.log("updatePublicationHits triggered");
        console.log(m);
        htmlContent="";
        hits=m["total_results"];
        if (hits==0)
            headingHtmlContent="<i>Your search returned no results</i>";
        else {
            //console.log(m["documents"][0]);
            headingHtmlContent="<i>Your search found "+hits+" hits</i>";
            htmlContent+="<ul id='results'>\n";
            for (i=0;i<m["documents"].length;i++){
                console.log(m["documents"][0]["rdf.publication.year"]);
                pid=m["documents"][i]["rdf.publication.about"];
                //pid=pid.substr(57);
                ptitle=m["documents"][i]["rdf.publication.title"];
                //pabstract=m["burst:publication"][i]["swrc:abstract"];
                //pwebLink=m["documents"][i]["swrc:link"];
                //pdescription=m["documents"][i]["swrc:description"];
                htmlContent+="<li>";
                htmlContent+="    <input type='checkbox' class='checkbox' name='result[]' value='"+pid+"' checked /> ";
                //            htmlContent+="    <a href='http://universe.stellarnet.eu/burst/hitcount.php?id="+pid+"'>"+ptitle+"</a>";
                htmlContent+="    "+ptitle+" <em>view details</em>&nbsp;&nbsp;";
                htmlContent+="</li>";
            };
            htmlContent+="</ul>";
        }
        $('#search-results-listitem').html("");
        $('#search-results-listitem').prepend(headingHtmlContent);
        $('#search-results-listitem').append("<div id=\"hits\"></div>")
        $('#hits').html(htmlContent);

        $('#hits em').click(function(){
            $('#hits-container').scrollTo('#pub-details-listitem',{
                duration:500,
                axis:'x'
            });
            pid=$(this).parent().find('input').val();//publication id
            console.log(pid);
            pid=pid.substr(62);
            console.log(pid);
            updatePublicationDetails(pid);
        });
    }




    //click event handler to scroll to the first panel(results from pub-details)
    $('#go-back-button').click(function(){
        $('#hits-container').scrollTo('#search-results-listitem',{
            duration:500,
            axis:'x'
        });
    });

    //callback of author autosuggest - adds a (checked) author on selected authors
    function insertToSelectedAuthors(xmlFormattedAuthor){
        //alert(xmlFormattedAuthor.id);
         puid=xmlFormattedAuthor.id.substr(57);
        $('#selectedAuthors ul').append("<li><input type='checkbox' class='checkbox' name='result[]' value='"+puid+"' checked />"+xmlFormattedAuthor.value+"</li>");
        $('#authorAjaxSearchInput').val("");
    }
    //same as insertToSelectedAuthors
    function insertToSelectedAuthors2(id,name){
        console.log(id);
        //puid=id.substr(57);

        $('#selectedAuthors ul').append("<li><input type='checkbox' class='checkbox' name='result[]' value='"+id+"' checked />"+name+"</li>");
        $('#authorAjaxSearchInput').val("");
    }

    //callback of keyword autosuggest - adds a (checked) keyword on selected keywords   `
    function insertToSelectedKeywords(xmlFormattedKeyword){
        //alert(xmlFormattedAuthor.id);
        $('#selectedKeywords ul').append("<li><input type='checkbox' class='checkbox' name='result[]' value='"+xmlFormattedKeyword.id+"' checked /><span>"+xmlFormattedKeyword.value+"</span></li>");
        $('#keywordAjaxSearchInput').val("");
    }
    //same as insertToSelectedKeywords
    function insertToSelectedKeywords2(keyword){
        //alert(xmlFormattedAuthor.id);
        $('#selectedKeywords ul').append("<li><input type='checkbox' class='checkbox' name='result[]' value='' checked /><span>"+keyword+"</span></li>");
        $('#keywordAjaxSearchInput').val("");
    }

    //autosuggest capability to author search
    //using bsn.autosuggest plugin
    aa_url=Widget.proxify(WS_DOMAIN+"authors/search/");
    var options = {
        script: aa_url,
        //varname: "",
        json: true,
        maxresults: 10,
        callback : insertToSelectedAuthors
    };
    var author_as = new bsn.AutoSuggest('authorAjaxSearchInput', options);

    //autosuggest capability to keyword search
    kk_url=Widget.proxify(WS_DOMAIN+"keywordsSearch.php?");
    var k_options = {
        script: kk_url,
        varname: "keyword",
        json: false,
        maxresults: 10,
        callback : insertToSelectedKeywords
    };
    var keyword_as = new bsn.AutoSuggest('keywordAjaxSearchInput', k_options);


    function selectedAuthorsSearch(authorarray,mode){
        $('#hits-container').css('display','block');
        $('#hits-container').scrollTo('#search-results-listitem',{
            duration:500,
            axis:'x'
        });
        showAjaxLoadingIcon();
        
        searchString="";
        //for (i=0;i<authorarray.length;i++){
        for (i=0 ; i < 1 ; i++){
            //console.log(authorarray[i]);
            
            searchString+=authorarray[i]+",";
        }
        console.log(searchString);
        //searchString=searchString.substr(57);
        console.log(searchString);


        searchString=searchString.substr(0, searchString.length-1);//remove trailing comma


        //url=WS_DOMAIN+"publications/author/"+searchString+"/"+mode;
        url=WS_DOMAIN+"publications/author/"+searchString;
        console.log(url);
        url=Widget.proxify(url);

        $.ajax({
            type : "GET",
            dataType: 'json',
            url  : url,
            beforeSend:function(){
            ////console.log('before send');
            },
            success: function(m){
                updatePublicationHits(m);                    
            },
            error: function(m,n){
            //console.log('error'+m.responseText+n);
            },
            complete: function(){
            //console.log("complete");
            }
        });       

        //atach hover event handler -TODO
        $('#results li').hover(function(){

            });
    }

    function selectedKeywordsSearch(keywordsArray,mode){

        searchString="";
        for (i=0;i<keywordsArray.length;i++){
            searchString+=keywordsArray[i]+",";
        }
        searchString=searchString.substr(0, searchString.length-1);//remove trailing comma

        url=WS_DOMAIN+"publications/search/"+searchString+"/"+mode;
        url=Widget.proxify(url);
        $.ajax({
            type : "GET",
            dataType: 'json',
            url  : url,
            beforeSend:function(){
                $('#hits-container').css('display','block');
                $('#hits-container').scrollTo('#search-results-listitem',{
                    duration:500,
                    axis:'x'
                });
                showAjaxLoadingIcon();
            },
            success: function(m){
                //console.log(m);
                updatePublicationHits(m);
            },
            error: function(m,n){
            ////console.log('error'+m+n);
            },
            complete: function(){
            ////console.log('complete');
            }
        });
    }

    $('#searchSelectedAuthorsInput').click(function(){
        selAuthorsArray = Array();
        $('#selectedAuthors ul li').each(function(){
            if ($(this).find('.checkbox').is(':checked')) {
                toPush=$(this).find('input').val();
//                toPush=toPush.substr(57);
                selAuthorsArray.push(toPush);
            }
        });
        mode=$('#selectedAuthors input[type=radio]:checked').val();

        selectedAuthorsSearch(selAuthorsArray,mode);
        return false;
    });

    $('#searchSelectedKeywordsInput').click(function(){
        selKeywordsArray = Array();
        $('#selectedKeywords ul li').each(function(){
            if ($(this).find('.checkbox').is(':checked')) {
                selKeywordsArray.push($(this).find('span').text());
            }
        });
        mode=$('#selectedKeywords input[type=radio]:checked').val();
        selectedKeywordsSearch(selKeywordsArray,mode);
        return false;
    });

    function switchTabs(a) {
        $('.tabsRow .activeTab').removeClass('activeTab').addClass('blurTab');
        $('#opts .activeBlock').removeClass('activeBlock').addClass('blurBlock')
        $('.tabsRow div').eq(a).removeClass('blurTab').addClass('activeTab');
        $('#opts div.opt').eq(a).removeClass('blurBlock').addClass('activeBlock');
    }

    switchTabs(0);
    $('#tab1').click(function(){
        switchTabs(0);
    });
    $('#tab2').click(function(){
        switchTabs(1);
    });
    $('#tab3').click(function(){
        switchTabs(2);
    });
    $('#tab4').click(function(){
        switchTabs(3);
    });

    function setSelected(num){
        $('#featureSelectionMenu ul li').removeClass('selected');
        $('#featureSelectionMenu ul li').eq(num-1).addClass('selected');
    }
    //load the featured publication through an Ajax request
    function loadFeaturedPublication(mode){
        url=WS_DOMAIN+"featured.php?mode="+mode;
        //console.log(url);
        url=Widget.proxify(url);
        $.ajax({
            type : "GET",
            url  : url,
            beforeSend:function(){},
            success: function(m){
                //alert(m);
                $('#featuredPublication').html("");
                pid=$(m).find("publication").attr("id");
                ptitle=$(m).find("title").text();
                pabstract=$(m).find("abstract").text();
                pwebLink=$(m).find("weblink").text();
                pdescription=$(m).find("description").text();
                htmlC="<a href='http://universe.stellarnet.eu/burst/hitcount.php?id="+pid+"'>"+ptitle+"</a><br /><i>"+pabstract+"</i>";
                htmlC+="<p class=\"viewDetailsButton\">view publication details</p>";
                $('#featuredPublication').html(htmlC);

                switch (mode) {
                    case '0':
                        $('#opt1 h3').html("Most popular publication of all time");
                        setSelected(5);
                        break;
                    case '1':
                        $('#opt1 h3').html("Publication of the day");
                        setSelected(1);
                        break;
                    case '2':
                        $('#opt1 h3').html("Publication of the week");
                        setSelected(2);
                        break;
                    case '3':
                        $('#opt1 h3').html("Publication of the month");
                        setSelected(3);
                        break;
                    case '4':
                        $('#opt1 h3').html("Publication of the year");
                        setSelected(4);
                        break;
                }
                
                $('p.viewDetailsButton').click(function(){
                    $('#hits-container').css('display','block');
                    $('#hits-container').scrollTo('#pub-details-listitem',{
                        duration:500,
                        axis:'x'
                    });
                    
                    updatePublicationDetails(pid);
                });
            },
            error: function(m,n){
            ////console.log('error'+m+n);
            },
            complete: function(){
            ////console.log('complete');
            }
        });
    }

    loadFeaturedPublication('2');

    $('#featureSelectionMenu ul li').click(function(){
        mode=$(this).find('span').text();
        loadFeaturedPublication(mode);
    });

    function booleanSearch(searchTerm){
        //url=WS_DOMAIN+"publications/search/q/"+searchTerm+"/page/0/items/100";
        url=WS_DOMAIN+"publications/search/"+searchTerm;
        url=Widget.proxify(url);//http://universe.stellarnet.eu;
        $.ajax({
            type : "GET",
            dataType: 'json',
            url  : url,
            beforeSend:function(){
                $('#hits-container').css('display','block');
                $('#hits-container').scrollTo('#search-results-listitem',{
                    duration:500,
                    axis:'x'
                });
                showAjaxLoadingIcon();
            },
            success: function(m){
                updatePublicationHits(m);
            },
            error: function(m,n){
            ////console.log('error'+m+n);
            },
            complete: function(){
            ////console.log('complete');
            }
        });

        //atach hover event handler -TODO
        $('#results li').hover(function(){

            });
    }

    $('#booleanSearchSumitBtn').click(function(){
        searchTerm=$('input#keywords').val();
        booleanSearch(searchTerm);
        return false;
    });

//    $.ajax({
//        type : "GET",
//        url  : url,
//        dataType: 'json',
//        success: function(m){
//            //var jsonObj=JSON.parse(m);//if datatype='text'
//            var jsonObj=m;//if datatype='json'
//            //console.log(jsonObj["rdf:RDF"]["swrc:Person"]["rdf:ID"]);
//            for (var key in jsonObj) {
//                //console.log(key+"  =  "+jsonObj[key]);
//            }
//        },
//        error: function(m,n){
//        ////console.log('error'+m+n);
//        },
//        complete: function(){
//        ////console.log('complete');
//        }
//    });
});