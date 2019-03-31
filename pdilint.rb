require 'colorize'
require 'nokogiri'
require 'logger'

class pdilint

	CONST_FILENAME= "[a-z](_[a-z]+)*"
	CONST_STEPNAME= "[a-z]([A-Z0-9]*[a-z][a-z0-9]*[A-Z]|[a-z0-9]*[A-Z][A-Z0-9]*[a-z])[A-Za-z0-9]*"
	CONST_PATHS = "^\$\{BI_SOLUTION_PATH\}([a-zA-Z]|\.\.|\/|\_|\\)*(\.ktr|\.kjb){1}$"
	
    def initialize    
        log = Logger.new('pdilint.log')   
    end

	def list_file(directorty)
		Dir.glob("#{directorty}/*.{kjb,ktr}") do |thefile| 
			puts "Checking #{File.basename(thefile)} is at #{File.dirname(thefile)}".blue
			exit_this_etl("#{File.basename(thefile)}","#{File.dirname(thefile)}")
			puts "Check the Database Connection".yellow
			check_db_connection("#{File.dirname(thefile)}/#{File.basename(thefile)}")
			puts "Check the Step Names".yellow
			check_step_name("#{File.dirname(thefile)}/#{File.basename(thefile)}")
			if is_job("#{File.dirname(thefile)}/#{File.basename(thefile)}")
				puts "Check the Path".yellow
				check_file("#{File.dirname(thefile)}/#{File.basename(thefile)}")
			end
			puts "Check File Name".yellow
			# => check_remove("#{File.dirname(thefile)}/#{File.basename(thefile)}")
			check_file_name("#{File.dirname(thefile)}/#{File.basename(thefile)}")

		end
	end	

	def check_item_regex(patter,matching)
		patter.match(/#{matching}/) ? true : false
	end

	def check_step_name(file)
		doc = Nokogiri::XML(File.open("#{file}"))

		doc.xpath('//step/name').each do |char_element|
			if check_item_regex(char_element.text,CONST_STEPNAME)
			 puts	"["+" OK ".green+"] The step name "+ "#{char_element.text}".green+ " this file  #{File.basename(file)} is at #{File.dirname(file)}" 
			else
			 puts	"["+" BAD ".red+"]  The step name "+ "#{char_element.text}".red+ " in this file  #{File.basename(file)} is at #{File.dirname(file)}" 
			end
		end
	end

	def check_db_connection(file)
		doc = Nokogiri::XML(File.open("#{file}"))
		doc.xpath('//connection/access').each do |char_element|
			if char_element.text.eql?"JNDI"
			 puts	"["+" OK ".green+"] The connection type #{File.basename(file)} is at #{File.dirname(file)} is"+ " #{char_element.text}".green 
			else
			 puts	"["+" BAD ".red+"] The connection type #{File.basename(file)} is at #{File.dirname(file)} is"+ " #{char_element.text}".red
			end
		end			
	end

	def check_file(file)
		doc = Nokogiri::XML(File.open("#{file}"))
		doc.xpath('//entries/entry/filename').each do |char_element|
			if char_element.text.match(/CONST_PATHS/)
				puts	"["+" OK ".green+"] The connection type #{File.basename(file)} is at #{File.dirname(file)}"
			else
				puts	"["+" OK ".green+"] The connection type #{File.basename(file)} is at #{File.dirname(file)}"
			end
		end
	end	

	def check_file_name(file)
			if check_item_regex(file.split("/").last(),CONST_FILENAME)
			 puts	"["+" OK ".green+"] The step name #{file.split("/").last()} in this file  #{File.basename(file)} is at #{File.dirname(file)}" 
			else
			 puts	"["+" BAD ".red+"] The step name  #{file.split("/").last()}  in this file  #{File.basename(file)} is at #{File.dirname(file)}" 
			end
	end

	def is_job(file)
	 	File.extname("#{file}") == '.kjb' ? true : false
	end

end
