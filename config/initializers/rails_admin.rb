RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
     # warden.authenticate! scope: :user
     redirect_to main_app.root_path unless current_user.try(:admin?) 
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = [
    'Actor',
    'Article', 
    'Comment',
    'Director',
    'Event',
    'Message',
    'Movie',
    'Partner',
    'Photo',
    'Project',
    'Promotion',
    'PromotionRecord',
    'SiteConfig',
    'Tag',
    'Tagging',
    'Ticket',
    'User'
  ]



  config.models do
    list do
      field :id
    end
    edit do
      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'
      end
    end
  end

  config.model Article do
    edit do
      field :title
      field :thumb
      field :summary
      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'
      end
      field :tag_list
      field :body, :ck_editor
    end
  end

  config.model Movie do
    edit do
      field :title
      field :desc
      field :summary
      field :thumb
      field :actors
      field :duration
      field :url
      field :location_list, :enum do
        enum_method do
          :location_enum
        end
      end
      field :type_list, :enum do
        enum_method do
          :type_enum
        end
      end
    end
  end

  config.model Event do
    edit do
      field :title
      field :summary
      field :content, :ck_editor
      field :thumb
      field :address
      field :start_time
      field :end_time
      field :status
      field :location_list, :enum do
        enum_method do
          :location_enum
        end
      end
      field :type_list, :enum do
        enum_method do
          :type_enum
        end
      end
      field :tag_list
    end
  end

  config.model Tag do
    list do
      field :id
      field :name
      field :context
      field :taggings_count
    end
    edit do
      field :name
      field :context
    end
  end

  config.model Tagging do
    list do
      field :id
      field :tag
      # 显示link
      # field :tag do
      #   pretty_value do
      #     id = bindings[:object].tag_id
      #     name = Tag.find(id).name
      #     bindings[:view].link_to "#{name}", bindings[:view].rails_admin.show_path('tag', id)
      #   end
      # end
      field :taggable
      field :context
    end
    edit do
      field :tag
      field :taggable
      field :context
    end
  end

  config.model Project do
    list do
      field :id
      field :title
      field :location
      field :user
      field :cover
    end
  end

  # config.model Ticket do
  #   # list do
  #     field :user do 
  #       pretty_value do
  #         id = bindings[:object].user_id
  #         name = User.find(id).nickname
  #         bindings[:view].link_to "#{name}", bindings[:view].rails_admin.show_path('user', id)
  #       end
  #     end
  #   # end
  # end
end
