require 'spec_helper'

describe CarrierWave::Crop::ModelAdditions do

  describe ".crop_uploaded" do
    before do
      class Parent
        def avatar_changed?; false; end
      end
      @mock_class = Class.new(Parent) do
        def self.after_update(method); nil; end
      end

      @mock_class.extend CarrierWave::Crop::ModelAdditions::ClassMethods
    end

    it 'mixes in the two DSL methods' do
      expect(@mock_class).to respond_to(:crop_uploaded)
    end

    it "for column avatar, accessors avatar_crop_x, avatar_crop_y, avatar_crop_w and avatar_crop_h are added" do
    end

    context 'with background mode' do
    end

    context 'without background mode' do
      before do
        @mock_class.crop_uploaded :avatar
        @instance = @mock_class.new
      end

      [:crop_x, :crop_y, :crop_w, :crop_h].each do |attr|
        context 'creates a crop accessor attribute' do
          it { expect(@instance).to respond_to(:"avatar_#{attr}") }
          it { expect(@instance).to respond_to(:"avatar_#{attr}=") }
        end
      end
    end
  end
end
