// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var TODO = {
  user: null,
  urls: {
    lists: {
      index: "/lists",
      show: "/lists/${id}"
    },
    tasks: {
      index: "/lists/${list.id}/tasks",
      show: "/lists/${list.id}/tasks/${id}"
    },
    users: {
      current: "/users/current"
    }
  },
  data: {
    lists: []
  }
};

$(function(){
  // get user info
  $.getJSON(TODO.urls.users.current,
            null,
            function(data, status, xhr){
              TODO.user = data;
            });
  
  $.getJSON(TODO.urls.lists.index,
            null,
            function(data, status, xhr) {
              TODO.data.lists = data;
              console.log(TODO);
            });
  
  
  
});
