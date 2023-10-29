# frozen_string_literal: true

module Sports::Episod
  class Scrapper
    BASE_URL = "https://www.episod.com"

    class << self
      def sessions
        html = connection.get("/planning")

        Nokogiri
          .parse(html.body)
          .search("ul#container_planning")
          .first
          .search('li')
          .map(&:attribute_nodes)
          .map { |attribute_nodes| Mapper.map(nodes_to_hash(attribute_nodes), :sessions) }
      end

      def bookings(user_id)
        user = User.find(user_id)

        html = connection({cookie: user.episod_cookie}).get("/mon-compte/mes-sessions/")
        doc = Nokogiri.parse(html.body)
        doc
          .search("section.account-sessions > li.status-annuler")
          .map(&:attribute_nodes)
          .map { |attribute_nodes|  Mapper.map(nodes_to_hash(attribute_nodes), :bookings) }
          .map(&:symbolize_keys)
          .map do |hash|
            reservation(hash[:episod_id], user.episod_cookie)
              .slice("spot")
              .merge({session_id: hash[:episod_id], user_id: user_id})
              .symbolize_keys
          end
      end

      def reservation(episod_id, cookie = "")
        html = connection(cookie: cookie).get("/reservation/#{episod_id}/")

        doc = Nokogiri.parse(html.body)
        date = doc.search('h4.masterclass-txt').text
        time = doc.search('time').text
        bikes = doc.search("g.type-bike")
                   .map(&:attribute_nodes)
                   .map { |attribute_nodes| nodes_to_hash(attribute_nodes) }

        Mapper.map(
          {
            starts_at: [date, time],
            duration: time,
            available_spots: bikes,
            spots_number: bikes,
            spot: bikes,
          },
          :reservation,
        )
      end

      private

      def connection(headers = {})
        Faraday.new(BASE_URL, headers: headers)
      end

      def nodes_to_hash(nodes)
        nodes.map { |node| { node.name => node.value } }.reduce(&:merge)
      end
    end
  end
end
