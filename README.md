# Jquery::Gmap::Rails

Includes jquery.gmap plugin in the assets pipeline.

## Installation

Add this line to your application's Gemfile:

    gem 'jquery-gmap-rails', github: 'aalbagarcia/jquery-gmap-rails', branch:'master'

And then execute:

    $ bundle

## Usage

* Open your application.js file and include

```
//= require jquery-gmap
```

* Include the Google Maps API in the layout of your application
* Create the map canvas (don't forget to style the map)

```
<div id="mymap" data-map-id="mymap"></div>
```

* Include the points in your markup

```
<ul>
<li data-marker="" data-lat="38.8796652" data-lng="-6.9732481" data-map-id="mymap" data-marker-id="1">Hotel 1</li>
<li data-marker="" data-lat="39.7161635" data-lng="-6.4481872" data-map-id="mymap" data-marker-id="2">Hotel 2</li>
...
</ul>
```
* Load the map

```
$('#mymap').gmap()
```

## Options

You can pass options to the Google Map object

```
$('#mymap').gmap({map_options:{scrollwheel:false}})
```

jquery-gmap-rails includes the markerclusterer library (https://code.google.com/p/google-maps-utility-library-v3/). You can cluster your points by:

```
$('#mymap').gmap({use_cluster: true, map_options:{scrollwheel:false}})
```

You can provide a callback to do something when the user clicks in a marker. You can include in your markup a data-infowindow-url attribute along with your data-lat and data-lng attributes which would allow you to load the infowindow via ajax:
```
# 
# <li data-marker="" data-infowindow-url="/infowindow/3.html" data-lat="39.7161635" data-lng="-6.4481872" data-map-id="mymap" data-marker-id="2">Hotel 2</li>
  markerClicked = (map, markerId, infowindowURL)->
    if infowindowURL
      marker = map.markers[markerId]
      map.gmap.setZoom(17)
      map.gmap.setCenter(marker.getPosition())
      infowindow = new google.maps.InfoWindow
        content:"<img src='/assets/frontend/images/ajax-loader.gif'>"
      $.get infowindowURL, {}, (data, textStatus, jqXHR) ->
        infowindow.setContent(data)
        infowindow.setOptions({maxWidth: 500})
        infowindow.open(map.gmap, marker)
        $('body').scrollTop(0)
  $('.map').gmap
    use_cluster: true
    click: markerClicked
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
