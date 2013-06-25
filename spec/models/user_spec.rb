require 'spec_helper'

describe User do
    before { @user = User.new(name: "Yuvaraja", email: "yuv.slm@gmail.com", password: "yuvislm", password_confirmation: "yuvislm") }
    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:remember_token) }

    it { should be_valid }

    describe "with invalid" do
        describe "name" do
            before { @user.name = nil }

            it { should_not be_valid }
        end

        describe "name length" do
            before { @user.name = "Yuva"*13 }

            it { should_not be_valid }
        end

        describe "email" do
            before { @user.email = nil }

            it { should_not be_valid }
        end

        describe "email format" do
            it "should not be valid" do
                address = %w[uiabhv@kjnds jkdvj@skjkn. 938797%^%$&@gamil.com ]
                address.each do |email|
                    @user.email = email
                    should_not be_valid
                end
            end
        end

        describe "duplicate email" do
            before do
                other_user = @user.dup
                other_user.save
            end

            it { should_not be_valid }
        end

        describe "Email case sensitivity" do
            before { @user.email = "YUV.slm@GMAil.Com" }

            it { should be_valid }
        end

        describe "password is empty" do
            before { @user.password = @user.password_confirmation = "" }
            it { should_not be_valid }
        end

        describe "password and password confirmation does not match" do
            before { @user.password_confirmation = "notmatchingpassword" }
            it { should_not be_valid }
        end

        describe "password confirmation is nil" do
            before { @user.password_confirmation = nil }
            it { should_not be_valid }
        end

        describe "return value of authenticate method" do
            before { @user.save }
            let (:db_user) { User.find_by_email(@user.email) }

            describe "with matching credentials" do
                it { should == db_user.authenticate(@user.password) }
            end

            describe "with non-matching credentials" do
                it { should_not == db_user.authenticate("invalid_password") }
            end
        end

        describe "with short password" do
            before { @user.password = @user.password_confirmation = "a"*5 }
            it { should_not be_valid }
        end
    end
    describe "remember token" do
        before { @user.save }
        its(:remember_token) { should_not be_blank }
    end
    describe "list associations" do
        before { @user.save }

        let(:older_list) { FactoryGirl.create(:list, user: @user, created_at: 1.day.ago) }
        let(:newer_list) { FactoryGirl.create(:list, user: @user, created_at: 1.hour.ago) }
    end
end
