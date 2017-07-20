var earthquakeFill = new ol.style.Fill({
        color: 'rgba(255, 153, 0, 0.8)'
      });
      var earthquakeStroke = new ol.style.Stroke({
        color: 'rgba(255, 204, 0, 0.2)',
        width: 1
      });
      var textFill = new ol.style.Fill({
        color: '#fff'
      });
      var textStroke = new ol.style.Stroke({
        color: 'rgba(0, 0, 0, 0.6)',
        width: 3
      });
      var invisibleFill = new ol.style.Fill({
        color: 'rgba(255, 255, 255, 0.01)'
      });

      function createEarthquakeStyle(feature) {
        // 2012_Earthquakes_Mag5.kml stores the magnitude of each earthquake in a
        // standards-violating <magnitude> tag in each Placemark.  We extract it
        // from the Placemark's name instead.
       // var name = feature.get('name');
       // var magnitude = parseFloat(name.substr(2));
        var radius = 5 + 20 * (6 - 5);

        return new ol.style.Style({
          geometry: feature.getGeometry(),
          image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: "blue"
              })
            })
          /*image: new ol.style.RegularShape({
            radius1: radius,
            radius2: 3,
            points: 5,
            angle: Math.PI,
            fill: earthquakeFill,
            stroke: earthquakeStroke
          })*/
        });
      }

      var maxFeatureCount, vector;
      function calculateClusterInfo(resolution) {
        maxFeatureCount = 0;
        var features = cluster_vector.getSource().getFeatures();
        var feature, radius;
        for (var i = features.length - 1; i >= 0; --i) {
          feature = features[i];
          var originalFeatures = feature.get('features');
          var extent = ol.extent.createEmpty();
          var j, jj;
          for (j = 0, jj = originalFeatures.length; j < jj; ++j) {
            ol.extent.extend(extent, originalFeatures[j].getGeometry().getExtent());
          }
          maxFeatureCount = Math.max(maxFeatureCount, jj);
          radius = 0.25 * (ol.extent.getWidth(extent) + ol.extent.getHeight(extent)) /
              resolution;
          feature.set('radius', 10);
        }
      }

      var currentResolution;
      function styleFunction_cluster(feature, resolution) {
        if (resolution != currentResolution) {
          calculateClusterInfo(resolution);
          currentResolution = resolution;
        }
        var style;
        var size = feature.get('features').length;
       // document.getElementById("zb").value=size;
        if (size > 1) {
          style = new ol.style.Style({
            image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: [255, 153, 0, Math.min(0.8, 0.4 + (size / maxFeatureCount))]
              })
            }),
            text: new ol.style.Text({
              text: size.toString(),
              fill: textFill,
              stroke: textStroke
            })
          });
        } else {
          var originalFeature = feature.get('features')[0];
          style = createEarthquakeStyle(originalFeature);
        }
        return style;
      }

      function selectStyleFunction(feature) {
        var styles = [new ol.style.Style({
          image: new ol.style.Circle({
            radius: feature.get('radius'),
            fill: invisibleFill
          })
        })];
        var originalFeatures = feature.get('features');
        var originalFeature;
        if(originalFeatures){
	        for (var i = originalFeatures.length - 1; i >= 0; --i) {
	          originalFeature = originalFeatures[i];
	          styles.push(createEarthquakeStyle(originalFeature));
	        }
      };
      //alert(feature.getStyleFunction());
        return styles;
      }