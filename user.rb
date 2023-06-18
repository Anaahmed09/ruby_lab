module Contactable
	def contact_details(num)
	  if num == "*"
		File.open('user_data.txt', 'r') do |file|
		  while line = file.gets
			puts line
		  end
		end
	  else
		File.open('user_data.txt', 'r') do |file|
		  count = 0
		  while count < num.to_i
			puts line = file.gets
			count += 1
		  end
		end
	  end
	end
  end
  
  class Person
	attr_accessor :name
  
	def initialize(name)
	  @name = name
	end
  
	def valid_name(name)
	  if name.match(/\A[[:alpha:]]+\z/)
		return true
	  else
		return false
	  end
	end
  end
  
  class User < Person
	extend Contactable
	attr_accessor :email, :mobile
  
	def initialize(name, email, mobile)
	  super(name)
	  @email = email
	  @mobile = mobile
	end
  
	def create
	  if File.read('user_data.txt').include?(mobile)
		puts "Mobile phone number already exists"
	  else
		File.open('user_data.txt', 'a') do |file|
		  file.puts "#{name}: #{email} | #{mobile}"
		end
	  end
	end
  
	def self.valid_email(email)
	  if email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
		return true
	  else
		return false
	  end
	end
  
	def self.list(*args)
	  case args.count
	  when 0
		raise "Enter a valid number"
	  when 1
		if args[0] == "*"
		  contact_details("*")
		else
		  contact_details(args[0])
		end
	  else
		raise "Wrong number of arguments"
	  end
	end
  end
  
  def check_user(name, email, mobile)
	user = User.new(name, email, mobile)
	if user.valid_name(name) && User.valid_email(email)
	  puts "Welcome #{name}"
	  user.create
	  return true
	end
  
	if !user.valid_name(name)
	  puts "Sorry invalid name"
	end
	if !User.valid_email(email)
	  puts "Sorry invalid email"
	end
  end
  
  while true
	puts "=" * 50
	puts "Welcome to Contact Ruby register form"
	puts "-" * 38
	puts "Enter your name"
	puts "-" * 15
	name = gets.chomp
	puts "Enter your email"
	puts "-" * 18
	email = gets.chomp
	puts "Enter your phone number"
	puts "-" * 25
	mobile = gets.chomp
  
	if check_user(name, email, mobile)
	  puts "Enter (*) to list all registered users or the number of users you would like to list:"
	  puts "-" * 77
	  choice = gets.chomp
	  User.list(choice)
	  break
	end
  end
  