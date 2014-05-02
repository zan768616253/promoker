RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
     warden.authenticate! scope: :user
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
    'ActsAsTaggableOn::Tag', 
    'ActsAsTaggableOn::Tagging', 
    'Article', 
    'Movie',
    'Actor',
    'Category',
    'Comment',
    'Director',
    'Event',
    'Message',
    'Movie',
    'Profile',
    'Project',
    'Ticket',
    'User'
  ]

  config.models do
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
      field :content, :ck_editor
      field :thumb
      field :directors
      field :actors
      field :duration
      field :url
      field :location_list
      field :type_list
    end
  end

  config.model Event do
    edit do
      field :title
      field :summary
      field :content, :ck_editor
      field :thumb
      field :address
      field :start
      field :end
      field :location_list
      field :type_list
      field :tag_list
    end
  end

  config.model ActsAsTaggableOn::Tag do
    list do
      field :name
      field :set
      field :taggings_count
    end
    edit do
      field :name
      field :set
    end
  end

  config.model ActsAsTaggableOn::Taggable do
    edit do
      field :name
      field :taggable_id
      field :taggable_type
      field :context
    end
  end

end
