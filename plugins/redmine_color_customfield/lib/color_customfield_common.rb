#
#
#
class ColorCustomfieldCommon < ActiveRecord::Base

  #
  # Color select pulldown entries
  #
  def self.color_choices
#    [ [t('color_blue'),1], 
#      [t('color_green'),2], 
#      [t('color_yellow'),3] ]
    [ [I18n.t('color_blue'),1], 
      [I18n.t('color_green'),2], 
      [I18n.t('color_yellow'),3], 
      [I18n.t('color_pink'),4],
    [I18n.t('color_orange'),5],
    ] 
  end
end
