require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = columns.first.map!(&:to_sym)
    # returns array of symbols which are col names
  end

  def self.finalize!
    self.columns.each do |column|
      define_method("#{column}=") do |value|
          # ivar = instance_variable_set("@#{column}", value)
          # every instance of a model is a column of the table
        self.attributes[column] = value
      end

      define_method("#{column}") do
        # instance_variable_get("@#{column}")
        self.attributes[column]
      end
    end

  end

  def self.table_name=(table_name) # class setter method
    @table_name = table_name
  end

  def self.table_name # class getter method
    @table_name ||= self.name.tableize
    unless @table_name
      self.name.tableize
    else
      @table_name
    end
    # alternative: @table_name || self.name.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    # p results # array of hashes
    # p self  # returns class
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # p self # returns Cat object
    # p self.class # returns Cat class
    params.each do |attr_name, val|
      if self.class.columns.include?(attr_name.to_sym)
        self.send("#{attr_name}=", val)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    # p AttrAccessorObject.my_attr_accessor(*names)
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
