const checkAjaxAuthorizationError = () => {
  const favoriteIcon = document.getElementsByClassName('fa-heart');
  if (favoriteIcon) {
      document.body.addEventListener('ajax:error', function(event) {
      var detail = event.detail;
      var response = detail[0], status = detail[1], xhr = detail[2];
      if (xhr.status == 401) {
        window.location.replace('/users/sign_in')
      }
    })
  }
}

export { checkAjaxAuthorizationError };
