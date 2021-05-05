require 'uri'
require 'net/http'
# require 'pp'

class SearchesController < ApplicationController


  def searchView
		@search ||= Search.new
  end

  def search
		# get search parameters
		search_params = params.require(:search).permit(:word, :start_url, :max_urls_count)
		#insert search to users db
		new_search = params.require(:search).permit(:word, :start_url)
		new_search["user_id"] = current_user["id"]
		@search = Search.create(new_search)
		if @search.valid?
      @search.save
    else  
			render 'searchView'
			return
    end

		# define instance vairiable for the result search index which will be populated and passed to the view.
		@total_index = Hash.new
		# initialize crawler urls array
		@crawler_urls = [search_params[:start_url]]
		# call crawler
		crawler 0, @crawler_urls, search_params[:max_urls_count].to_i
		# call mapper_reducer func
		mapper_reducer @crawler_urls, search_params[:max_urls_count].to_i
		# pass result to view
		@searched_word = search_params[:word]
		
		render 'searchView'

  end

	def mapper_reducer crawler_urls, max_urls_count
		idx = 0
		while idx < max_urls_count do

			# Mapper
			threads = []
			5.times do |i|
				if idx < max_urls_count
					threads << Thread.new(idx) { |arg_idx| Thread.current[:index] = indexer crawler_urls[arg_idx]; Thread.current[:url] = crawler_urls[arg_idx];}
					idx += 1
				else
					break
				end
			end

			# Reducer
			threads.each do |t|
				t.join
		 		reducer t[:index], t[:url]
			end

			# clear threads array
			threads.clear

		end
	end

	def reducer index, url
		index.each do |word, word_count|
			if(@total_index[word].nil?)
				@total_index[word] = [{:count => word_count, :document => url}]
			else
				@total_index[word] << {:count => word_count, :document => url}
			end
		end
	end

	def indexer url
		page = getPage url
		page.downcase!
		words = getWords page
		index = Hash.new(0)
		words.each {|word| index[word] += 1 if word.length > 0}
		return index
	end

	def getPage arg_url
		uri = URI(arg_url)
		res = Net::HTTP.get_response(uri)
		return res.body
	end

	def getWords text
		return	text.split(/\W+/)
	end

	def crawler idx, urls_arr, max_urls_count
		body = getPage urls_arr[idx]
		idx += 1
		search_urls = URI.extract(body).grep(/^https?:/)
		if(search_urls.length == 0) 
			return
		end
		diff = max_urls_count - urls_arr.length
		if(search_urls.length >= diff)
			urls_arr.concat search_urls[0, diff] if diff > 0
		else
			urls_arr.concat search_urls # append the whole array
			crawler idx, urls_arr, max_urls_count
		end
	end

end
