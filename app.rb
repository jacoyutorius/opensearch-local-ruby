require 'opensearch'
require 'hashie'

client = OpenSearch::Client.new(
  host: 'https://admin:admin@opensearch:9200',
  transport_options: { ssl: { verify: false } }
)

query = {
  'size': 5,
  'query': {
    'multi_match': {
      'fields': ['title', 'artist'],
      'query': '台風'
    }
  }
}

response = client.search(
  body: query,
  index: 'songs'
)

ret = Hashie::Mash.new(response['hits'])
pp ret.hits.map(&:_source)