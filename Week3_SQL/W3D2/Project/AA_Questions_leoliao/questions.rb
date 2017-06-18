require 'sqlite3'
require 'singleton'

# QuestionsDB class
class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question_ids = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    return nil unless question_ids.length > 0
    Question.new(question_ids.first)
  end

  def self.find_by_author_id(author_id)
    # questions is an array of hashes
    questions = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @title = options['title']
    @body = options['body']
  end

  def author
    raise "User with ID: #{@id} not in database" unless @id
    name = User.find_by_id(@id)
    "#{name.fname} #{name.lname}"
  end

  def replies

  end

end

class User
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    # users is an array of hashes
    users = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    return nil unless users.length > 0
    User.new(users.first)
  end

  def self.find_by_name(fname, lname)
    authors = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL

    return nil unless authors.length > 0
    User.new(authors.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    raise "User with ID: #{@id} not in database" unless @id
    Question.find_by_author_id(@id)
  end

  def authored_replies
    raise "User with ID: #{@id} not in databsae" unless @id
    Reply.find_by_author_id(@id)
  end

end

class Reply
  attr_accessor :id, :body, :question_id, :parent_id, :author_id

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_author_id(author_id)
    authors = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL

    return nil unless authors.length > 0
    authors.map { |author| Question.new(author) }
  end

  def self.find_by_question_id(question_id)
    questions = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    return nil unless questions.length > 0
    User.new(questions.first)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
  end
end
