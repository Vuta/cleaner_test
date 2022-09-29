require 'sequel'

class Cleaner
  DATABASE_URL = "postgresql://postgres:postgres@localhost:5432/cleaner_test"

  attr_reader :connection

  def self.conn
    @conn ||= Sequel.connect(DATABASE_URL)
  end

  def initialize
    @connection = self.class.conn
  end

  def setup
    @connection.create_table?(:users) do
      primary_key :id
    end
  end

  def count
    @connection[:users].count
  end
end
