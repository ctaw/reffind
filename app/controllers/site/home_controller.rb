require 'flickraw'
require 'will_paginate/array'

class FlickRaw::Response
  def url_q
    build_img_url.gsub('?', 'q')
  end

  def url_c
    build_img_url.gsub('?', 'c')
  end

  def build_img_url
    "https://farm#{self.farm}.staticflickr.com/#{self.server}/#{self.id}_#{self.secret}_?.jpg"
  end
end

# Main controller for the application
class Site::HomeController < SiteController
  # Home page with no results
  def index
    @results = []
  end

  # Search Flickr for photos
  def search
    @results = []

    # Searching nothing
    if params[:search_photo_text].to_s.strip.empty?
      # Message for no result
      flash.now[:error_msg] = "Please input correct words to search for... Thank you!"
    else
      # Cache results
      # Purpose: For Faster Pagination
      @results = Rails.cache.fetch(params[:search_photo_text], :expires_in => AppConfig.cache_expiry_minutes.minutes,
                                   :race_condition_ttl => AppConfig.cache_race_ttl_minutes.minutes) do

        logger.info "Caching Flicker API results for: #{params[:search_photo_text]}"

        # When Calling API only
        FlickRaw.api_key = Rails.application.secrets.flickr_api_key
        FlickRaw.shared_secret = Rails.application.secrets.flickr_shared_secret

        # API results add elements to an Array
        flickr.photos.search(:tags => params[:search_photo_text], :per_page => AppConfig.flickr_max_results).each do |a|
          @results << a
        end
      end

      # Pagination
      @results = @results.paginate(:page => params[:page], :per_page => AppConfig.results_per_page)
    end
  end
end
