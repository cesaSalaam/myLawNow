let urlParams = new URLSearchParams(window.location.search);

if(!urlParams.has('room')){
    alert('Invalid url please check and try again');
}

let room = urlParams.get('room');



let clientId = "TZ5h4DMU6Uw7";

// This code loads the Gruveo Embed API code asynchronously.
var tag = document.createElement("script");
tag.src = "https://www.gruveo.com/embed-api/";
var firstScriptTag = document.getElementsByTagName("script")[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// This function gets called after the API code downloads. It creates
// the actual Gruveo embed and passes parameters to it.
var embed;
function onGruveoEmbedAPIReady() {
    $( ".loader" ).remove();
    embed = new Gruveo.Embed("myembed", {
        responsive: 1,
        embedParams: {
            clientid: clientId,
            code: room
        }
    });

    embed
        .on("error", onEmbedError)
        .on("requestToSignApiAuthToken", onEmbedRequestToSignApiAuthToken);
}

function onEmbedError(e) {
    console.error("Received error " + e.error + ".");
    alert('There was an error connecting to the room');
}

function onEmbedRequestToSignApiAuthToken(e) {
    // The below assumes that you have a server-side signer endpoint at /signer,
    // where you pass e.token in the body of a POST request.

    $.ajax({
        url: `http://mylawnow.herokuapp.com/signer?token=${e.token}`,
        type: 'GET',
        success: function(res) {
            let data = JSON.parse(res);
            console.log(res);
            console.log(data.result);
            embed.authorize(data.result);
        },error:function(error) {
            console.log(error);
        }});

}
