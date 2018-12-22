$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-token']").attr('content'));
  }
});

window.initialize = function(reg) {

  function onDeregister(e)  {
    $.ajax({
      url: '/endpoint',
      method: 'DELETE',
      dataType: 'script',
    });
  }

  // get push token and persist it
  async function onRegister(e) {
    e.preventDefault();
    e.stopPropagation();
    let status = await Notification.requestPermission();
    console.log('permissionStatus ' + status)

    if (status === 'granted') {
      let subscription = await reg.pushManager.subscribe({ userVisibleOnly: true });
      $.ajax({
        url: '/push_subscriptions',
        method: 'POST',
        dataType: 'script',
        data: {
          push_subscription: JSON.parse(JSON.stringify(subscription)),
        }
      });
    } else {
      alert('Do not have permission to register with push service');
    }
  }
  $('body').on('click', '[data-register]', onRegister)
  $('body').on('click', '[data-deregister]', onDeregister)
}
