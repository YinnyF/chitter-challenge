feature 'Authentication' do
  scenario 'a user can sign in with email and password' do
    User.create(email: 'test@example.com', password: 'password123', name: 'Test Name', username: 'testuser1')

    visit '/sessions/new'
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'password123'
    click_button('Sign in')

    expect(page).to have_content 'Welcome, Test Name (@testuser1)'
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'test@example.com', password: 'password123', name: 'Test Name', username: 'testuser1')

    visit '/sessions/new'
    fill_in :email, with: 'incorrect_email@example.com'
    fill_in :password, with: 'password123'
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, Test Name (@testuser1)'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create(email: 'test@example.com', password: 'password123', name: 'Test Name', username: 'testuser1')

    visit '/sessions/new'
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'wrongpassword'
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, Test Name (@testuser1)'
    expect(page).to have_content 'Please check your email or password.'
  end
end
