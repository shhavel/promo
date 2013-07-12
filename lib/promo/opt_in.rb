module Promo
  class OptIn
    class << self
      attr_accessor :uri

      def list
        JSON.parse(RestClient.get(uri))
      end

      def get(id)
        JSON.parse(RestClient.get("#{uri}/#{id}"))
      end

      def create(params)
        JSON.parse(RestClient.post(uri, params.to_json, content_type: :json, accept: :json))
      end

      def update(id, params)
        RestClient.put("#{uri}/#{id}", params.to_json, content_type: :json, accept: :json) == "true"
      end

      def delete(id)
        JSON.parse(RestClient.delete("#{uri}/#{id}"))
      end
    end
  end
end
