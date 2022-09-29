require_relative '../cleaner'
require 'database_cleaner-sequel'

cleaner = Cleaner.new
cleaner.setup

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end

  config.around(:each) do |example|
    conn = DatabaseCleaner[:sequel]
    conn.db = cleaner.connection
    conn.strategy = :transaction

    conn.cleaning do
      example.run
    end
  end
end

RSpec.describe Cleaner do
  describe '' do
    let(:instance) { described_class.new }
    let(:users) { instance.connection[:users] }

    before(:all) do
      described_class.new.connection[:users].insert(id: 100)
    end

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
end
