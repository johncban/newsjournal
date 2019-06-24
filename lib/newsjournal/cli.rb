class Newsjournal::CLI
    def contents
        news_greet
        news_articles
        news_articles_menu
        news_menu
        news_close
    end

    def news_greet
        Newsjournal::NewsGreet.newsStartGreet
        puts "--------------------------------------------------------------------------------------".blue
        puts "Here are the following Financial breaking news...".bold.white
        puts "--------------------------------------------------------------------------------------".blue
    end

    def news_articles
        Newsjournal::NewsScraper.scrapeArticleHeadlines

        puts "--------------------------------------------------------------------------------------".blue
        puts "Select an Article ID to Read".bold.white
        puts "--------------------------------------------------------------------------------------".blue
    end

    def news_articles_menu
        input = nil
        while input != "X"
            #binding.pry
            
            puts "\n"
            puts "Type [ x ] to exit the app.".colorize(:color => :red).bold
            puts "Type [ b ] to go back to main menu.".colorize(:color => :light_red).bold
            puts "\n"

            input = gets.strip.downcase

            breaking = NewsScrape.todayNews
            breaking.each_with_index{ |e, i|
                #binding.pry

                case input
                when "#{i+1}"
                   puts `clear`
                   link = e[:url].map(&:to_s).shift.strip
                   ar_content = NewsScrape.scrapeArticleContent(link)
                   puts "- #{e[:headline]} -".bold.green
                   puts "\n"
                   puts "Summary".bold
                   puts "#{e[:sum]}".white
                   puts "--------------------------------------------------------------------------------------".blue
                   puts "Date and Author:  #{e[:date_auth]}".light_blue
                   puts "\n"
                   puts "--------------------------------------------------------------------------------------".green
                   Launchy.open(link)
                   puts ar_content.green
                   puts "--------------------------------------------------------------------------------------".green
                when "b"
                    puts `clear`
                    contents
                when "x"
                    news_close
                end
            }
        end
    end

    def news_menu
        news_articles_menu
    end


    def news_close
        Newsjournal::NewsGreet.newsEndGreet
    end

end