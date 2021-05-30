import 'stylesheets/site'
import 'stylesheets/navbarmain'
import 'stylesheets/navbar'
import 'stylesheets/home-page'

import '../stylesheets/site.scss'
import '../stylesheets/navbarmain.scss'
import '../stylesheets/navbar.css'
import '../stylesheets/home-page.scss'

const images = require.context('../images', true)


// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "chartkick/chart.js"

//chart import
import "chartkick/chart.js"

import '../stylesheets/site.scss'
import '../stylesheets/navbarmain.scss'
import '../stylesheets/navbar.css'
import '../stylesheets/home-page.scss'

Rails.start()
Turbolinks.start()
ActiveStorage.start()





