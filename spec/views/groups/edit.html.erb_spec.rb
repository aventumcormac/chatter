# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'groups/edit', type: :view do
  before do
    @group = assign(:group, Group.create!(
                              title: 'MyString'
                            ))
  end

  it 'renders the edit group form' do
    render

    assert_select 'form[action=?][method=?]', group_path(@group), 'post' do
      assert_select 'input[name=?]', 'group[title]'
    end
  end
end
