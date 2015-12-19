require 'sinatra'
require 'sendgrid-ruby'

get '/' do
	erb :home
end

get '/order' do
	erb :order
end

get '/contact' do

erb :contact
end

post '/contact' do
	 #     Add more to this, its the right idea. Pull the name, email, and comments and create a new Email object, then
    #     Pass that emil object to the "mail function"
        c_first_name = params["c_first_name"]
        c_last_name = params["c_last_name"]
        c_email = params["c_email"]
        c_comments = params["c_comments"]
        #this is passing the c_first_name to the params so i can pass it to the email
        @email = Email.new(c_first_name, c_last_name, c_email, c_comments)
    #     This is where you call the mail function and pass email information    
    mail(@email)
    erb :contact
end


# The mail feature can be in its own function and accept an Email object
def mail(email)
    
    client = SendGrid::Client.new do |c|
        c.api_key = ENV['SENDGRID_API_KEY']
    end

     mail = SendGrid::Mail.new do |m|
         #          Specify to whom you are sending with the Email object
         m.to = 'shefseth@gmail.com'
         m.from = email.c_email  
         m.subject = 'Guest Comments'   
         #passing the 'first name' into the body of email
         m.text = email.c_comments 
     end
         
    res = client.send(mail) 
    puts res.code
    puts res.body 
     
end

# This email class can sit on the bottom of the page 
#    Good use of a new class object
#this is grabbing the inputs from contact page
class Email 
    attr_accessor :c_first_name, :c_last_name, :c_email, :c_comments
    def initialize (c_first_name, c_last_name, c_email, c_comments)
        @c_first_name = c_first_name
        @c_last_name = c_last_name
        @c_email = c_email
        @c_comments = c_comments
    end
end

####THIS CODE IS NOT WORKING PLEASE KEEP IT HERE SO I CAN DEBUG-SL
# class Email #this is grabbing the inputs from contact page
# 	attr_accessor :c_first_name, :c_last_name, :c_email, :c_comments
# 	def initialize (c_first_name, c_last_name, c_email, c_comments)
# 		@c_first_name = c_first_name
# 		@c_last_name = c_last_name
# 		@c_email = c_email
# 		@c_comments = c_comments
# 	end
# end

	

# def mail(email)
# 	client = SendGrid::Client.new do |c|
# 		c.api_key = ENV['SENDGRID_API_KEY']
#  	end

#  	mail = SendGrid::Mail.new do |m|
#  		m.to = 'shefseth@gmail.com'   
#  		m.from = 'shefseth@gmail.com'   
#  		m.subject = 'Hello #{email.c_first_name}'  
#  		#passing the 'first name' into the body of email
#  		m.text = 'Test'
# 	end
#  		res = client.send(mail) 
# 		puts res.code
#  		puts res.body
# end
	

	
# mail(@email)	
# erb :contact
# end
#*************************************

post '/process' do

	# puts params

# PROCESSING COOKIES

# class CookieOrder created to make new cookie order (new object)
	class CookieOrder
		attr_accessor :name, :amount
# cookie info name and amount passed through to new cookie
		def initialize(name, amount)
			@name = name
			@amount = amount
 
		end
	end


# TAKE INFO FROM PREVIOUS PAGE

# COOKIE ORDER IS BEING PUT INTO AN ARRAY
	@cookieOrders = []
# FOR "I" IT TAKES COOKIES AND AMOUNT FROM DROP DOWN 1 TO DROP DOWN 6
	for i in 1..6
		cookie = params["cookies#{i}"]
		num = params["amount#{i}"]
#IF "I" WHICH IS AN INTERGER IS NOT EAQUAL TO 0 RUN IT THROUGH THE ARRAY
		if num.to_i != 0
#C IS NOW EQUAL TO THE NEW COOKIE ORDER WITH THE COOKIE NAME AND THE AMOUNT
			c = CookieOrder.new(cookie, num) 
# "C" IS BEING PASSED TO THE TOP OF COOKIE ORDER ARRAY
			@cookieOrders << c
			
		end
	end
	puts @cookieOrders.inspect

# PROCESSING USER
	class User
		attr_accessor :first_name, :last_name, :phone, :address, :city, :zip_code, :email
		def initialize (first_name="", last_name="", phone="", address="", city="", zip_code="", email="")
			@first_name = first_name
			@last_name = last_name
			@phone = phone
			@address = address
			@city = city
			@zip_code = zip_code
			@email = email
		end
	end
		first_name = params["first_name"]
		last_name = params["last_name"]	
		phone = params["phone"]
		address = params["address"]
		city = params["city"]
		zip_code = params["zip_code"]
		email = params["email"]

	@user = User.new(first_name, last_name, phone, address, city, zip_code, email)
	#this is passing the info to @user through the params
def mail(email)

client = SendGrid::Client.new do |c|
	c.api_key = ENV['SENDGRID_API_KEY']
 	end

 	mail = SendGrid::Mail.new do |m|
 		m.to = email.email   
 		m.from = 'shefseth@gmail.com'   
 		m.subject = 'Hello'   
 		#passing the 'first name' into the body of email
 		m.text = email.c_comments
 		
	end
 		res = client.send(mail) 
		puts res.code
 		puts res.body
end
puts @user.inspect	

# *******************


	erb :display_order


	
end


get '/about' do
	erb :about
end




