
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
  var url = 'img/IMG_'.concat(current_photo).concat('.jpg');
  photo.setAttribute('src', url);
  document.getElementById('overlay').style.height = "100%";
  document.getElementById('arr_back').setAttribute('src', 'icons/arrow_back.svg');
  document.getElementById('arr_back').style.cursor = "pointer";
  document.getElementById('arr_forward').setAttribute('src', 'icons/arrow_forward.svg');
  document.getElementById('arr_forward').style.cursor = "pointer";
}

function nextPhoto() {
  current_photo++;
  if (current_photo > number_of_photos) {
    current_photo = 1;
  }
  var photo = document.getElementById('photo');
  var url = 'img/IMG_'.concat(current_photo).concat('.jpg');
  photo.setAttribute('src', url);
}

function previousPhoto() {
  current_photo--;
  if (current_photo < 1) {
    current_photo = number_of_photos;
  }
  var photo = document.getElementById('photo');
  var url = 'img/IMG_'.concat(current_photo).concat('.jpg');
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

    var link = document.createElement('A');
    link.setAttribute('href', url);
    var text = item.concat(': ').concat(quantity);
    var textNode = document.createTextNode(text);
    link.appendChild(textNode);
    var line = document.createElement('LI');
    line.appendChild(link);
    items.appendChild(line);

    prev_type = type;

  }

}

function addServices(services, items) {

  for (var i = 0; i < services.length; i++) {

    var service = services[i][0];
    var url = services[i][1];
    var status = services[i][2];

    if (status == 'active') {
      var link = document.createElement('A');
      link.setAttribute('href', url);
      link.setAttribute('target', '_blank');
      var textNode = document.createTextNode(service);
      link.appendChild(textNode);
      var line = document.createElement('LI');
      line.appendChild(link);
      items.appendChild(line);
    }

  }

}

function addMoreEquipment(click) {

  var gear_list = document.getElementById('gear-list');

  var power_and_automation_header = document.createElement('H4');
  var header_text = document.createTextNode("Power and Automation");
  power_and_automation_header.appendChild(header_text);
  gear_list.appendChild(power_and_automation_header);
  var power_and_automation_list = document.createElement('UL');
  addEquipment(power_and_automation, power_and_automation_list);
  gear_list.appendChild(power_and_automation_list);

  var climatization_header = document.createElement('H4');
  var header_text = document.createTextNode("Climatization");
  climatization_header.appendChild(header_text);
  gear_list.appendChild(climatization_header);
  var climatization_list = document.createElement('UL');
  addEquipment(climatization, climatization_list);
  gear_list.appendChild(climatization_list);

  var more = document.getElementById('more-gear');
  more.setAttribute('style', 'display: none');

  var title = document.getElementById('title-gear');
  title.setAttribute('style', 'width: 997px')

  if(click) {
    addMoreMedia(false);
  }

}

function addMoreMedia(click) {

  var media = document.getElementById('media');

  var collection_header = document.createElement('H4');
  var header_text = document.createTextNode("Film Collection");
  collection_header.appendChild(header_text);
  media.appendChild(collection_header);

  var film_collection = document.createElement('UL');
  addMediaItems(collection, film_collection, 'collection');
  media.appendChild(film_collection);

  var more = document.getElementById('more-media');
  more.setAttribute('style', 'display: none');

  var title = document.getElementById('title-media');
  title.setAttribute('style', 'width: 457px')

  if(click) {
    addMoreEquipment(false);
  }

}

function addMoreDecor(click) {

  var decor_list = document.getElementById('decor');

  var miniatures_header = document.createElement('H4');
  var header_text = document.createTextNode("Miniatures");
  miniatures_header.appendChild(header_text);
  decor_list.appendChild(miniatures_header);
  var miniatures_list = document.createElement('UL');
  addItems(miniatures, miniatures_list);
  decor_list.appendChild(miniatures_list);

  var tapes_header = document.createElement('H4');
  var header_text = document.createTextNode("VHS Tapes");
  tapes_header.appendChild(header_text);
  decor_list.appendChild(tapes_header);
  var tapes_list = document.createElement('UL');
  addItems(tapes, tapes_list);
  decor_list.appendChild(tapes_list);

  var more = document.getElementById('more-decor');
  more.setAttribute('style', 'display: none');

  var title = document.getElementById('title-decor');
  title.setAttribute('style', 'width: 1044px')

  if(click) {
    addMoreStuff(false);
  }

}

function addMoreStuff(click) {

  var stuff_list = document.getElementById('stuff');

  var ambiance_header = document.createElement('H4');
  var header_text = document.createTextNode("Ambiance");
  ambiance_header.appendChild(header_text);
  stuff_list.appendChild(ambiance_header);
  var ambiance_list = document.createElement('UL');
  addItems(ambiance, ambiance_list);
  stuff_list.appendChild(ambiance_list);

  var more = document.getElementById('more-stuff');
  more.setAttribute('style', 'display: none');

  var title = document.getElementById('title-stuff');
  title.setAttribute('style', 'width: 497px')

  if(click) {
    addMoreDecor(false);
  }

}
