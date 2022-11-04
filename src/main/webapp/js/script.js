let rValue = null;
let yCoordinate = document.querySelector("#Y");
let xOptions = document.querySelectorAll(".X");

const isNumber = (s) => {
    let n = parseFloat(s.replace(',','.'));
    return !isNaN(n) && isFinite(n);
}

const checkSelection = (radios) => {
    for(let i=0; i<radios.length; i++){
        if(radios[i].checked) return true;
    }
    alert('You didnt select the X coordinate!');
    return false;
}

const getCoordinate = (options) => {
    for(let i=0; i<options.length; i++){
        if(options[i].checked) return options[i].value;
    }
    return false;
}

const validateField = (coordinate,min,max) => {
    if(coordinate.value){
        coordinate.value = coordinate.value.replace(',','.');
        if(coordinate.value<=min || coordinate.value>=max || !isNumber(coordinate.value)){
            alert('Wrong Y format');
            return false;
        }
        else{
            return true;
        }
    }
    alert('You didnt input the Y coordinate!');
    return false;
}

const validateNull = (rValue) => {
    if (rValue==null) {
        alert("You didnt select R!");
        return false;
    }
    return true;
}

const validateAll = () => {
    return checkSelection(xOptions)&&validateField(yCoordinate,-3,5) && validateNull(rValue);
}

const rerenderDots = () => {
    if (rValue){
        table.forEach(row => {
            $('svg').append(
                $(createSvg("circle"))
                    .attr("id","circle")
                    .attr("cx",175 + 130*row.x/rValue)
                    .attr("cy",175 - 130*row.y/rValue)
                    .attr("r",5)
                    .attr("stroke-width",0)
                    .attr("fill",row.hit?'green':'red')
            );
        });
    }
};

$(".X").on('click',e=>{

});

$(".R").on("click", (e) => {
    e.preventDefault();
    $("#R"+rValue).css('background-color','white');
    rValue = e.target.value;
    $('#R'+rValue).css('background-color', '#006400');

    $('circle').remove();
    rerenderDots();

    $('#hiddenR').attr('value',rValue);
});

$(document).ready(function(){
    // resize();
    table = [];
    $("#result_table>tbody tr").each(function (i, el) {
        var self = $(this);
        var x = self.find(".x").text().trim();
        var y = self.find(".y").text().trim();
        var r = self.find(".r").text().trim();
        var hit = self.find(".hit").text().trim() == "hit"?true:false;
        var result = `${x}, ${y}, ${r}, ${hit}`;
        console.log(result);
        var raw = {x:x, y:y, r:r, hit:hit};
        table[i]=raw;
    });
    if(table.length>0) {
        $('#R'+parseInt(table[0].r)).click();
    }
    else $('#R3').click();
    $('#R'+rValue).css('background-color', '#006400');
    console.log(table);

    $('circle').remove();
    rerenderDots();
});

$("#input-form").on("submit", function(event){
    event.preventDefault();

    console.log("Got data for check!" );
    console.log('y: ', yCoordinate.value);
    console.log('x: ', getCoordinate(xOptions));
    console.log('r: ',rValue);

    if(!validateAll()){
        console.log("post canceled")
        return
    }
    console.log("data sending...")
    console.log(this);


    console.log($(this).serialize());

    $.ajax({
        url: 'control',     method: "POST",
        data: $(this).serialize() + "&timezone=" + new Date().getTimezoneOffset(),
        dataType: "html",

        success: function(data){
            console.log(data);
            $(".validate_button").attr("disabled", false);
            //window.localStorage.setItem("table",data["table"]);
            window.location.replace("result_page.jsp");
            //$("#result_table>tbody").html(data);
        },
        error: function(error){
            console.log(error);
            $(".validate_button").attr("disabled", false);
        },
    });
});
$(".reset_button").on("click",function(e){
    e.preventDefault();
    $.ajax({
        url: 'control', method: "POST",
        data: 'clear=true',

        success: (data) => {
            window.location.replace("index.jsp");
        }
    })
})

$(document).keyup(function(e) {
    if (e.key === 27) { // escape key maps to keycode `27`
        console.log(1);
        window.location.replace("index.jsp");
    }
});


$("svg").click((e) => {
    let parentOffset = $(this).parent().offset();
    let parentParentOffset = $(this).parent().parent().offset();
    //or $(this).offset(); if you really just want the current element's offset
    let relX = ((e.pageX - (110))-175)*rValue/130;
    let relY = -((e.pageY - (125))-175)*rValue/130;

        // .attr("cx",175 + 130*row.x/rValue)
        // .attr("cy",175 - 130*row.y/rValue)
    console.log('CURSOR:',e.pageX,e.pageY);
    console.log(relX," ",relY);
    console.log(rValue);

    // console.log({
    //     R: rValue,
    //     relX,
    //     relY
    // });
    // console.log($(this).serialize());
    if (!validateNull(rValue)) {
        return;
    }

    $.ajax({
        url: 'control',     method: "POST",
        data: '&X='+relX + "&Y="+ relY + "&R="+ rValue + "&timezone=" + new Date().getTimezoneOffset(),
        dataType: "html",

        success: function(data){
            console.log(data);
            $(".validate_button").attr("disabled", false);
            //window.localStorage.setItem("table",data["table"]);
            window.location.replace("result_page.jsp");
            //$("#result_table>tbody").html(data);
        },
        error: function(error){
            console.log(error);
            $(".validate_button").attr("disabled", false);
        },
    });


});



function createSvg(tagName) {
    return document.createElementNS("http://www.w3.org/2000/svg", tagName);
}