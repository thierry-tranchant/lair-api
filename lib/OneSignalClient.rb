class OneSignalClient
  URL = "https://onesignal.com/api/v1"

  def call(user, content)
    url = URI("#{URL}/notifications")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = 'application/json'
    request["Authorization"] = "Basic #{Rails.application.credentials.dig(:one_signal, :api_key)}"
    request["Content-Type"] = 'application/json'

    request.body = {
      app_id: Rails.application.credentials.dig(:one_signal, :app_id),
      include_player_ids: [user.one_signal_player_id]
      contents: {fr: content, en: "You have received a message"}
    }

    http.request(request)
  end
end
