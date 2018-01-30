return unless document.querySelector('#app')
new Vue
  el: '#app',
  data:
    answer: null
    feedback: null
  methods:
    sendAnswer: () ->
      fetch event.target.action,
        method: 'POST'
        body: JSON.stringify value: @answer
        headers: {'Content-Type': 'application/json'}
        credentials: 'same-origin'
      .then (response) => response.json().then (data) => @feedback = data.result
      @answer = null
