return unless document.querySelector('#map-canvas')

window.tvVue = new Vue
  el: '#tv-vue'
  data:
    map: null
    players: null
  created: ->
    @inProgress = window.vue_data.inProgress
    @players = window.vue_data.players
    @discoveredCountries = window.vue_data.discovered_countries
  methods:
    chartReady: ->
      @map = new google.visualization.GeoChart(document.getElementById('map-canvas'))
      @updateCountries @discoveredCountries
    updateCountries: (countries) ->
      table = [['Country', 'Value']]
      table.push country for country, i in countries
      @map.draw(google.visualization.arrayToDataTable(table),
        { colorAxis: {colors: ['#007bff', '#ffc107']}, legend: 'none' })
    updateState: (data) -> @updateCountries(data.discovered_countries)

google.charts.load('current', packages: ['geochart'], mapsApiKey: 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY')
google.charts.setOnLoadCallback(tvVue.chartReady)
