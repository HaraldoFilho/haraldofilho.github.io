
function getHeaderPhotosIndexes(max) {
  var indexes = [];
  var index = getRandomIndex(max);
  for (var i = 0; i < 3; i++) {
    while (indexes.includes(index)) {
      index = getRandomIndex(max);
    }
    indexes.push(index);
  }
  return indexes;
}

function getRandomIndex(max) {
  slideIndex = Math.floor(Math.random() * max) + 1;
  return slideIndex;
}

function openPhoto(number) {
  current_photo = number;
  var photo = document.getElementById('photo');
  var url = 'res/images/IMG_'.concat(current_photo).concat('.jpg');
  photo.setAttribute('src', url);
  document.getElementById('overlay').style.height = "100%";
  document.getElementById('arr_back').setAttribute('src', 'res/icons/arrow_back.svg');
  document.getElementById('arr_back').style.cursor = "pointer";
  document.getElementById('arr_forward').setAttribute('src', 'res/icons/arrow_forward.svg');
  document.getElementById('arr_forward').style.cursor = "pointer";
}

function nextPhoto() {
  current_photo++;
  if (current_photo > number_of_photos) {
    current_photo = 1;
  }
  var photo = document.getElementById('photo');
  var url = 'res/images/IMG_'.concat(current_photo).concat('.jpg');
  photo.setAttribute('src', url);
}

function previousPhoto() {
  current_photo--;
  if (current_photo < 1) {
    current_photo = number_of_photos;
  }
  var photo = document.getElementById('photo');
  var url = 'res/images/IMG_'.concat(current_photo).concat('.jpg');
  photo.setAttribute('src', url);
}

function closePhoto() {
  document.getElementById('overlay').style.height = "0%";
}

function addSpeakers(speakers, items) {

  for (var i = 0; i < speakers.length; i++) {

    var item = document.createElement('LI');
    var type = document.createTextNode(speakers[i][0].concat(": "));
    var text = document.createTextNode(speakers[i][1]);
    var url = speakers[i][2];

    var bold_type = document.createElement('B');
    bold_type.appendChild(type);
    item.appendChild(bold_type);

    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      link.setAttribute('target', '_blank');
      link.appendChild(text);
      item.appendChild(link);
    } else {
      item.appendChild(text);
    }
    items.appendChild(item);

  }

}

function addEquipment(equipment, items) {

  for (var i = 0; i < equipment.length; i++) {

    var item = document.createElement('LI');
    var text = document.createTextNode(equipment[i][0]);
    var note = document.createTextNode(" ".concat(equipment[i][1]));
    var url = equipment[i][2];

    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      link.setAttribute('target', '_blank');
      link.appendChild(text);
      item.appendChild(link);
    } else {
      item.appendChild(text);
    }
    item.appendChild(note);
    items.appendChild(item);

  }

}

function addItems(type, items) {

  for (var i = 0; i < type.length; i++) {

    var text = type[i][0];
    var url = type[i][1];
    var target = type[i][2];
    var line = document.createElement('LI');
    var textNode = document.createTextNode(text);

    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      if(target.length > 0) {
        link.setAttribute('target', target);
      }
      link.appendChild(textNode);
      line.appendChild(link);
    } else {
      line.appendChild(textNode);
    }

    items.appendChild(line);

  }

}

function addMediaItems(media, items, initial_type) {

  var prev_type = initial_type;

  for (var i = 0; i < media.length; i++) {

    var item = media[i][0];
    var quantity = media[i][1];
    var url = media[i][2];
    var type = media[i][3];

    if (type != prev_type) {
      var line_break = document.createElement('BR');
      items.appendChild(line_break);
    }

    var line = document.createElement('LI');
    var text = item.concat(': ').concat(quantity);
    var textNode = document.createTextNode(text);

    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      link.appendChild(textNode);
      line.appendChild(link);
    } else {
      line.appendChild(textNode);
    }
    items.appendChild(line);

    prev_type = type;

  }

}

function addCurrentServices() {

  if (document.getElementById('current-services-header') != null) {
    document.getElementById('current-services-header').remove();
    document.getElementById('current-services-list').remove();
  }

  initial_number_of_services = max_initial_number_of_services;

  var streaming = document.getElementById('streaming');

  var current_services_header = document.createElement('H4');
  current_services_header.setAttribute('id', 'current-services-header');
  var header_text = document.createTextNode("Current Services");
  current_services_header.appendChild(header_text);
  streaming.appendChild(current_services_header);

  var current_services_list = document.createElement('UL');
  current_services_list.setAttribute('id', 'current-services-list');
  streaming.appendChild(current_services_list);

  if (initial_number_of_services < current_services.length) {
    initial_number_of_services -= 1;
  }

  for (var i = 0; i < current_services.length; i++) {

    var service = current_services[i][0];
    var url = current_services[i][1];
    var status = current_services[i][2];

    if (i < initial_number_of_services) {
      var line = document.createElement('LI');
      if (url.length > 0) {
        var link = document.createElement('A');
        link.setAttribute('href', url);
        var textNode = document.createTextNode(service);
        link.appendChild(textNode);
        line.appendChild(link);
      } else {
        line.appendChild(textNode);
      }
      current_services_list.appendChild(line);
    }

  }

  if (i > initial_number_of_services) {
    var textNode = document.createTextNode('...');
    var line = document.createElement('LI');
    line.setAttribute('id', 'more-services');
    line.setAttribute('onclick', 'moreCurrentServices()');
    line.setAttribute('style', 'cursor: pointer');
    line.appendChild(textNode);
    current_services_list.appendChild(line);
  }

  var more = document.getElementById('past-services');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'addPastServices(true)');

  all_current_services_visible = false;

  if (past_services.length == 0) {
    var more = document.getElementById('past-services');
    var title = document.getElementById('title-streaming');
    more.setAttribute('style', 'display: none');
    title.setAttribute('style', 'width: 504px');
  }



}

function moreCurrentServices() {

  var service = current_services[initial_number_of_services][0];
  var url = current_services[initial_number_of_services][1];
  var status = current_services[initial_number_of_services][2];

  var link = document.createElement('A');
  link.setAttribute('href', url);
  var textNode = document.createTextNode(service);
  link.appendChild(textNode);
  var line = document.getElementById('more-services');
  line.innerText = "";
  line.setAttribute('onclick', '');
  line.appendChild(link);

  var current_services_list = document.getElementById("current-services-list");

  for (var i = initial_number_of_services+1; i < current_services.length; i++) {

    var service = current_services[i][0];
    var url = current_services[i][1];
    var status = current_services[i][2];

    var line = document.createElement('LI');
    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      var textNode = document.createTextNode(service);
      link.appendChild(textNode);
      line.appendChild(link);
    } else {
      line.appendChild(textNode);
    }
    current_services_list.appendChild(line);

  }

  all_current_services_visible = true;

  var more = document.getElementById('past-services');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'addCurrentServices()');
  more.setAttribute('style', 'display: solid');


}

function addPastServices(click) {

  if (!all_current_services_visible && initial_number_of_services < current_services.length) {
    moreCurrentServices();
  }

  var streaming = document.getElementById('streaming');

  var past_services_header = document.createElement('H4');
  past_services_header.setAttribute('id', 'past-services-header');
  var header_text = document.createTextNode("Past Services");
  past_services_header.appendChild(header_text);
  streaming.appendChild(past_services_header);

  var past_services_list = document.createElement('UL');
  past_services_list.setAttribute('id', 'past-services-list');
  streaming.appendChild(past_services_list);

  for (var i = 0; i < past_services.length; i++) {

    var service = past_services[i][0];
    var url = past_services[i][1];
    var status = past_services[i][2];

    var line = document.createElement('LI');
    var textNode = document.createTextNode(service);

    if (url.length > 0) {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      link.appendChild(textNode);
      line.appendChild(link);
    } else {
      line.appendChild(textNode);
    }

    past_services_list.appendChild(line);

  }

  var more = document.getElementById('past-services');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'removePastServices(true)');

  past_services_visible = true;

  if (click) {
    if (!more_equipment_visible && !more_media_visible) {
      moreEquipment(false);
    }
    if (more_media_visible) {
      lessMedia(false);
    }
  }

}

function removePastServices(click) {

  document.getElementById('past-services-header').remove();
  document.getElementById('past-services-list').remove();
  addCurrentServices();

  var more = document.getElementById('past-services');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'addPastServices(true)');

  past_services_visible = false;
  all_current_services_visible = false;

  if (click && !more_media_visible) {
    lessEquipment(false);
  }

}

function moreEquipment(click) {

  var gear_list = document.getElementById('gear-list');

  var wireless_audio_header = document.createElement('H4');
  wireless_audio_header.setAttribute('id', 'wireless-audio-header');
  var header_text = document.createTextNode("Wireless Audio (Zone B)");
  wireless_audio_header.appendChild(header_text);
  gear_list.appendChild(wireless_audio_header);
  var wireless_audio_list = document.createElement('UL');
  wireless_audio_list.setAttribute('id', 'wireless-audio-list')
  addEquipment(wireless_audio, wireless_audio_list);
  gear_list.appendChild(wireless_audio_list);

  var power_and_automation_header = document.createElement('H4');
  power_and_automation_header.setAttribute('id', 'power-and-automation-header');
  var header_text = document.createTextNode("Power and Automation");
  power_and_automation_header.appendChild(header_text);
  gear_list.appendChild(power_and_automation_header);
  var power_and_automation_list = document.createElement('UL');
  power_and_automation_list.setAttribute('id', 'power-and-automation-list')
  addEquipment(power_and_automation, power_and_automation_list);
  gear_list.appendChild(power_and_automation_list);

  var climatization_header = document.createElement('H4');
  climatization_header.setAttribute('id', 'climatization-header');
  var header_text = document.createTextNode("Climatization");
  climatization_header.appendChild(header_text);
  gear_list.appendChild(climatization_header);
  var climatization_list = document.createElement('UL');
  climatization_list.setAttribute('id', 'climatization-list')
  addEquipment(climatization, climatization_list);
  gear_list.appendChild(climatization_list);

  var more = document.getElementById('more-gear');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'lessEquipment(true)');

  more_equipment_visible = true;

  if (click) {
    addCurrentServices();
    if (!past_services_visible && !more_media_visible) {
      moreMedia(false);
    }
  }

}

function lessEquipment(click) {

  document.getElementById('wireless-audio-header').remove();
  document.getElementById('wireless-audio-list').remove();

  document.getElementById('power-and-automation-header').remove();
  document.getElementById('power-and-automation-list').remove();

  document.getElementById('climatization-header').remove();
  document.getElementById('climatization-list').remove();

  var more = document.getElementById('more-gear');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'moreEquipment(true)');

  more_equipment_visible = false;

  if(click) {
    addCurrentServices();
    if (more_media_visible) {
      lessMedia(false);
    }
    if (past_services_visible) {
      removePastServices(false);
    }
  }

}

function moreMedia(click) {

  var media = document.getElementById('media');

  var collection_header = document.createElement('H4');
  collection_header.setAttribute('id', 'collection-header');
  var header_text = document.createTextNode("Film Collection");
  collection_header.appendChild(header_text);
  media.appendChild(collection_header);

  var film_collection = document.createElement('UL');
  film_collection.setAttribute('id', 'film-collection');
  addMediaItems(collection, film_collection, 'collection');
  media.appendChild(film_collection);

  var more = document.getElementById('more-media');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'lessMedia(true)');

  more_media_visible = true;

  if (click) {
      addCurrentServices();
      if (past_services_visible) {
        removePastServices(false);
      }
      if (!more_equipment_visible) {
        moreEquipment(false);
      }
  }

}

function lessMedia(click) {

  document.getElementById('collection-header').remove();
  document.getElementById('film-collection').remove();

  var more = document.getElementById('more-media');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'moreMedia(true)');

  more_media_visible = false;

  if(click) {
    addCurrentServices();
    lessEquipment(false);
  }

}

function moreDecor(click) {

  var decor_list = document.getElementById('decor');

  var door_header = document.createElement('H4');
  door_header.setAttribute('id', 'door-header');
  var header_text = document.createTextNode("Door");
  door_header.appendChild(header_text);
  decor_list.appendChild(door_header);
  var door_list = document.createElement('UL');
  door_list.setAttribute('id', 'door-list');
  addItems(door, door_list);
  decor_list.appendChild(door_list);

  var miniatures_header = document.createElement('H4');
  miniatures_header.setAttribute('id', 'miniatures-header');
  var header_text = document.createTextNode("Miniatures");
  miniatures_header.appendChild(header_text);
  decor_list.appendChild(miniatures_header);
  var miniatures_list = document.createElement('UL');
  miniatures_list.setAttribute('id', 'miniatures-list');
  addItems(miniatures, miniatures_list);
  decor_list.appendChild(miniatures_list);

  var tapes_header = document.createElement('H4');
  tapes_header.setAttribute('id', 'tapes-header');
  var header_text = document.createTextNode("VHS Tapes");
  tapes_header.appendChild(header_text);
  decor_list.appendChild(tapes_header);
  var tapes_list = document.createElement('UL');
  tapes_list.setAttribute('id', 'tapes-list');
  addItems(tapes, tapes_list);
  decor_list.appendChild(tapes_list);

  var more = document.getElementById('more-decor');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'lessDecor(true)');

  if(click) {
    moreStuff(false);
  }

}

function lessDecor(click) {

  document.getElementById('door-header').remove();
  document.getElementById('door-list').remove();

  document.getElementById('miniatures-header').remove();
  document.getElementById('miniatures-list').remove();

  document.getElementById('tapes-header').remove();
  document.getElementById('tapes-list').remove();

  var more = document.getElementById('more-decor');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'moreDecor(true)');

  if(click) {
    lessStuff(false);
  }

}

function moreStuff(click) {

  var stuff_list = document.getElementById('stuff');

  var stands_header = document.createElement('H4');
  stands_header.setAttribute('id', 'stands-header');
  var header_text = document.createTextNode("Wall Stands");
  stands_header.appendChild(header_text);
  stuff_list.appendChild(stands_header);
  var stands_list = document.createElement('UL');
  stands_list.setAttribute('id', 'stands-list');
  addItems(stands, stands_list);
  stuff_list.appendChild(stands_list);

  var ambiance_header = document.createElement('H4');
  ambiance_header.setAttribute('id', 'ambiance-header');
  var header_text = document.createTextNode("Ambiance");
  ambiance_header.appendChild(header_text);
  stuff_list.appendChild(ambiance_header);
  var ambiance_list = document.createElement('UL');
  ambiance_list.setAttribute('id', 'ambiance-list');
  addItems(ambiance, ambiance_list);
  stuff_list.appendChild(ambiance_list);

  var more = document.getElementById('more-stuff');
  more.innerText = "LESS";
  more.setAttribute('onclick', 'lessStuff(true)');

  if(click) {
    moreDecor(false);
  }

}

function lessStuff(click) {

  document.getElementById('stands-header').remove();
  document.getElementById('stands-list').remove();

  document.getElementById('ambiance-header').remove();
  document.getElementById('ambiance-list').remove();

  var more = document.getElementById('more-stuff');
  more.innerText = "MORE";
  more.setAttribute('onclick', 'moreStuff(true)');

  if(click) {
    lessDecor(false);
  }

}
