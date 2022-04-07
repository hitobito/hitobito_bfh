# frozen_string_literal: true

#  Copyright (c) 2012-2022, Berner Fachhochschule. This file is part of
#  hitobito_digisus_lab and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_digisus_lab.


module Iwi::GroupSerializer
  extend ActiveSupport::Concern

  included do
    extension(:details) do |_|
      map_properties :ch_open_member_type, :tcbe_member_type, :tcbe_company_type, :employees, :apprentice, :membershipfee, :invoicenumber, :entrydate, :leavingdate
    end
  end

end
