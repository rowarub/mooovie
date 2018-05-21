class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = ""

    while true
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end
  end

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

end

