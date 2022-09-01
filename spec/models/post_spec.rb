# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string
#  uuid_secure :uuid             not null
#  uuid_token  :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_posts_on_group_id  (group_id)
#  index_posts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
