require_relative '../cleaner'
require 'database_cleaner-sequel'

cleaner = Cleaner.new
cleaner.setup

RSpec.configure do |config|
  config.around(:each) do |example|
    conn = DatabaseCleaner[:sequel]
    conn.db = cleaner.connection
    conn.strategy = :transaction

    conn.start
    example.run
    conn.clean
  end
end

RSpec.describe Cleaner do
  let(:instance) { described_class.new }
  let(:users) { instance.connection[:users] }

  context '' do
    before do
      users.insert(id: 1)
    end

    it { puts "User count: #{instance.count}" }
  end

  context '' do
    before do
      users.insert(id: 2)
    end

    it { puts "User count: #{instance.count}" }
  end
end
