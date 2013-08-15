$ = jQuery

$.fn.extend
  gmap: (options)->
    #Default
    settings =
      debug: false
      use_cluster: false
      map_options:
        zoom: 7
        center: new google.maps.LatLng(40.366620892184365, -3.7568359375)
        mapTypeId: google.maps.MapTypeId.ROADMAP

    #Merge settings
    settings = $.extend settings, options

    log = (msg) ->
      console?.log msg if settings.debug

    return @each () ->
      log 'mostrando mapa...'
      map = {}
      map.mapId = $(this).data('map-id')
      mapElement = this
      map.mapOptions = settings.map_options
      map.gmap = new google.maps.Map( mapElement, map.mapOptions);
      map.bounds = new google.maps.LatLngBounds();
      #include the markers
      map.markers = {}
      $('*[data-map-id="'+map.mapId+'"][data-marker]').each ()->
        lat = $(this).data('lat')
        lng = $(this).data('lng')
        markerId = $(this).data('marker-id')
        position = new google.maps.LatLng(lat, lng)
        map.bounds.extend(position)
        map.markers[markerId] = new google.maps.Marker {
          position: position
          icon: $(this).data('marker-icon')
        }
        # If we are using MarkerClusterer, we add the map later
        unless settings.use_cluster
          map.markers[markerId].setMap(map.gmap)

        infowindowURL = $('[data-marker][data-marker-id="'+markerId+'"]').data('infowindow-url')
        google.maps.event.addListener  map.markers[markerId], 'click', () ->
          infowindowURL = $('[data-marker][data-marker-id="'+markerId+'"]').data('infowindow-url')
          settings.click(map, markerId, infowindowURL)

        # Set the click event of the small map icon in the event
        $(document).on 'click', 'i[data-marker-icon][data-marker-id="'+markerId+'"]', (event)->
          event.preventDefault()
          event.stopPropagation()
          settings.click(map, markerId, infowindowURL)
      map.gmap.fitBounds(map.bounds)
      #activate cluster if requested
      if settings.use_cluster
        markers = []
        for k,v of map.markers
          markers.push v
        markerClusterer = new MarkerClusterer map.gmap, markers