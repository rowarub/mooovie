def self.get_product(link)
  agent = Mechanize.new
  page = agent.get(link)

  title = page.at('.entry-title').inner_text if page.at('.entry-title').inner_text
  image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
  director = page.at(".entry-content .review_details .director span").inner_text if page.at(".entry-content .review_details .director span").inner_text
  open_date = page.at(".entry-content .review_details .date span").inner_text if page.at(".entry-content .review_details .date span").inner_text
  detial = page.at(".entry-content p").inner_text if page.at(".entry-content p").inner_text


  product = Product.where(title: title, image_url: image_url, director: director, detial: detial, open_date: open_date).first_or_initialize
  product.save

end
