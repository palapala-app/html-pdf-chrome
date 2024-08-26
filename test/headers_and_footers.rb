$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "palapala"

HEADER_HTML = <<~HTML
  <style type="text/css">
    .header {
      -webkit-print-color-adjust: exact;
      border-bottom: 1px solid lightgray;
      color: black;
      font-family: Arial, Helvetica, sans-serif;
      font-size: 12pt;
      margin: 0 auto;
      padding: 5px;
      text-align: center;
      vertical-align: middle;
      width: 100%;
    }
  </style>
  <div class="header" style="text-align: center">
    Page <span class="pageNumber"></span> of <span class="totalPages"></span>
  </div>
  <div class="header">
    Page <span class="pageNumber">?</span> of <span class="totalPages">?</span>
  </div>
HTML

Palapala.setup do |config|
  config.debug = true
  config.ferrum_opts = { url: "http://localhost:9222" } # run against a remote Chrome instance
end

result = Palapala::PDF.new(
  # "<style>@page { size: A4 landscape; }</style><p>Hello world #{Time.now}</>",
  "<h1>Title</h1><p>Hello world #{Time.now}</>",
  header_html: HEADER_HTML,
  footer_html: '<div style="text-align: center;">Generated with Palapala PDF</div>',
  scale: 0.75,
  prefer_css_page_size: false,
  margin: { top: 3, bottom: 2 },
).save("tmp/headers_and_footers.pdf",
       generateDocumentOutline: true,
      #  marginTop: 1,
      #  paperWidth: 3,
       displayHeaderFooter: true,
       landscape: false,
       headerTemplate: HEADER_HTML)

puts result
