require 'rails_helper'

RSpec.describe 'Landing Page' do
    it 'has a header' do
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'test1234')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'pass1234')
        visit '/'
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'test1234')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'pass1234')
        visit '/'
        click_button "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 

    it 'lists out existing users' do 
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'test1234')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'pass1234')
       
        visit '/'
        expect(page).to have_content('Existing Users:')

        within('.existing-users') do 
            expect(page).to have_content(user1.email)
            expect(page).to have_content(user2.email)
        end     
    end 

    it 'has a log in link' do 
        user1 = User.create!(name: "User One", email: "user1@test.com", password: 'test1234', password_confirmation: 'test1234')

        visit '/'

        click_link "Log In"
        expect(current_path).to eq(login_path)
        fill_in :email, with:'user1@test.com'
        fill_in :password, with:'test1234'
    
        click_button "Log In"
        expect(current_path).to eq(user_path(user1))
    end  

    it 'has a log in link, when I provide incorrect credentials I get errors' do 
        user1 = User.create!(name: "User One", email: "user1@test.com", password: 'test1234', password_confirmation: 'test1234')

        visit '/'

        click_link "Log In"
        expect(current_path).to eq(login_path)
        fill_in :email, with:'user2@test.com'
        fill_in :password, with:'test1234'
    
        click_button "Log In"
        expect(current_path).to eq(login_path)
        save_and_open_page
    end  
end
