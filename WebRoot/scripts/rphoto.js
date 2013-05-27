
function galleriaNextPicture(_index,_pid){
	$("#add_comment_photo_id").val(_pid);
	ayncRPhoto("CommentsControll","action=get_photo_comments&&comment_photo_id="+_pid,showComment);
	var raysmond_photos = eval('('+$("#raysmond_photos").text()+')');
	//refresh title
	$("#photo_title").text(raysmond_photos[_index].title);
	
	//refresh tags
	reloadTagList();
}

function showTagList(response){
	//alert(response);
	$("#tag_list").empty().html(response);
}
function reloadTagList(){
	var _pid = $("#add_comment_photo_id").val();
	ayncRPhoto("UserTagControll","action=get_photo_tag_list&&photo_id="+_pid,showTagList);
}
function reloadComments(){
	var _pid = $("#add_comment_photo_id").val();
	ayncRPhoto("CommentsControll","action=get_photo_comments&&comment_photo_id="+_pid,showComment);
}
function showComment(comments){
	$("#comments").empty().html(comments);
}

function addCommentAction(){
	var content = encodeURIComponent($("#add_comment_content").val());
	var photoId = $("#add_comment_photo_id").val();
	ayncRPhoto("CommentsControll","action=add_photo_comment&&comment_photo_id=" 
			+ photoId+"&&comment_content=" + content,addCommentCallback);
}


function addCommentCallback(data){
	if(data!=""){
		alert(data);
		return;
	}
	$("#add_comment_content").val("");
	reloadComments();
}

function loadAlbumInfo(albumId){
	ayncRPhoto("AysncAlbum","action=async_get_album_info&&album_id="+albumId,showAlbumInfo);
}
function showAlbumInfo(response){
	$("#album_info").empty().html(response);
}

function ayncRPhoto(url,requestData,callback){
	$.ajax({
        type:'POST',
        url:url,
        data:requestData,
        async:true,
        cache: false,
        success:function(responseData){
        	//alert(responseData);
            callback(responseData);
        }
    });
}
