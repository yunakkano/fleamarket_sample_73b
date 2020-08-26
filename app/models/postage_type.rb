class PostageType < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 1, name: 'らくらくフリマ便で発送する'}, {id: 2, name: 'ゆうゆうフリマ便で発送する'}, {id: 3, name: 'その他の方法で発送する'}
  ]
  has_many :items
end
