# Create Users
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password'
)

# Create Trips
trip1 = Trip.create!(
  name: 'Trip to Paris',
  start_date: Date.new(2024, 5, 1),
  end_date: Date.new(2024, 5, 10),
  owner: user1
)

trip2 = Trip.create!(
  name: 'Trip to New York',
  start_date: Date.new(2024, 6, 15),
  end_date: Date.new(2024, 6, 20),
  owner: user2
)

# Create Expenses
expense1 = Expense.create!(
  description: 'Flight to Paris',
  amount: 500.00,
  date: Date.new(2024, 4, 30),
  creator: user1,
  trip: trip1
)

expense2 = Expense.create!(
  description: 'Hotel in Paris',
  amount: 1000.00,
  date: Date.new(2024, 5, 1),
  creator: user1,
  trip: trip1
)

expense3 = Expense.create!(
  description: 'Flight to New York',
  amount: 400.00,
  date: Date.new(2024, 6, 14),
  creator: user2,
  trip: trip2
)

expense1.users << user1
expense1.users << user2
expense2.users << user1
expense3.users << user2

Expense.create!(
  description: 'Hotel in New York',
  amount: 800.00,
  date: Date.new(2024, 6, 15),
  creator: user2,
  trip: trip2
)

# Create Participants
Participant.create!(
  trip: trip1,
  user: user1
)

Participant.create!(
  trip: trip1,
  user: user2
)

Participant.create!(
  trip: trip2,
  user: user1
)

Participant.create!(
  trip: trip2,
  user: user2
)
