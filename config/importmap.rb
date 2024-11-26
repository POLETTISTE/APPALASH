# frozen_string_literal: true

# Pin JavaScript packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/controllers/chart', under: 'controllers/chart'

pin 'alpinejs', to: 'https://cdn.skypack.dev/alpinejs'
pin 'flatpickr' # @4.6.13
pin 'flatpickr/l10n/fr', to: 'https://ga.jspm.io/npm:flatpickr@4.6.13/dist/l10n/fr.js'
pin 'chartkick', to: 'chartkick.js'
pin 'Chart.bundle', to: 'Chart.bundle.js'

pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.2.0/dist/chart.js'
pin '@kurkle/color', to: 'https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js'
