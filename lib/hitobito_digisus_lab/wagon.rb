# encoding: utf-8

#  Copyright (c) 2012-2013, Puzzle ITC GmbH. This file is part of
#  hitobito_generic and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_generic.

module HitobitoDigisusLab
  class Wagon < Rails::Engine
    include Wagons::Wagon

    # Set the required application version.
    app_requirement '>= 0'

    # Add a load path for this specific wagon
    # config.autoload_paths += %W( #{config.root}/lib )

    config.to_prepare do
      # extend application classes here
      Group.include(Group::Generic, Iwi::Group)
      Person.include(Iwi::Person)

      PeopleController.include(Iwi::PeopleController)
      GroupsController.include(Iwi::GroupsController)

      Export::Tabular::People::PeopleAddress.include(Iwi::Export::Csv::People::PeopleAddress)
      Export::Tabular::People::PersonRow.include(Iwi::Export::Csv::People::PersonRow)

      #::Person::PUBLIC_ATTRS += [:title, :salutation, :department, :position]
      #::Group::PUBLIC_ATTRS += [:ch_open_member_type, :tcbeMemberType, :tcbeCompanyType]

      PersonSerializer.include(Iwi::PersonSerializer)
      GroupSerializer.include(Iwi::GroupSerializer)
    end

    initializer 'hitobito_digisus_lab.add_settings' do |_app|
      Settings.add_source!(File.join(paths['config'].existent, 'settings.yml'))
      Settings.reload!
    end

    def seed_fixtures
      fixtures = root.join('db', 'seeds')
      ENV['NO_ENV'] ? [fixtures] : [fixtures, File.join(fixtures, Rails.env)]
    end
  end
end