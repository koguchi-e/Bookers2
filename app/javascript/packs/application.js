import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function () {
  const nameInput = document.querySelector('input[name="user[name]"]');
  if (nameInput) {
    nameInput.focus();  // 名前入力欄にフォーカスを設定
  }
});


