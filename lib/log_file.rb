require "log_file/version"
module LogFile

	class Display
		def initialize(app)
			@app=app	
		end

		def call(env={})
			if env["PATH_INFO"]=~/^\/log_file/
				@log_name=((Rails.env=="development")?("log/development.log"):("log/production.log"))

				@lines=`wc -l <"#{ @log_name }"`.to_i

				if(env["QUERY_STRING"]=~/direction/ )
					if(env["QUERY_STRING"]=="direction=Next")
						count=@lines-env['rack.session'][:line_count]
						env['rack.session'][:line_count]=@lines
						env['rack.session'][:displayed_lines] += count
						data=`tail -n "#{ count }" "#{ @log_name }"`
						[200,{"Content-Type"=>"text/html"},[view_append(data)]]					
                    elsif(env["QUERY_STRING"]=="direction=Previous")
                    	lines_added=@lines-env['rack.session'][:line_count]
                    	bottom_stack=env['rack.session'][:displayed_lines]+lines_added
                    	previous_lines=(@lines-bottom_stack)
                    	if previous_lines>=30
							env['rack.session'][:displayed_lines] += 30 
							data=`head -n "#{ previous_lines }" "#{ @log_name }" | tail -30`
							[200,{"Content-Type"=>"text/html"},[view_append(data)]]
						elsif((previous_lines<30)&&(previous_lines>0))
						    env['rack.session'][:displayed_lines] += previous_lines 
							data=`head -"#{ previous_lines }" "#{ @log_name }"`
							[200,{"Content-Type"=>"text/html"},[view_append(data)]]
						else
							[200,{"Content-Type"=>"text/html"},[""]]		
						end	
					end	
				else
	              	env['rack.session'][:line_count]=@lines
	              	if @lines>=30
						env['rack.session'][:displayed_lines]=count=30
					else
						env['rack.session'][:displayed_lines]=count=@lines
					end		
					data=`tail -"#{ count }" "#{ @log_name }"`
					[200,{"Content-Type"=>"text/html"},[view_generate(data)]]
				end	
			else
				@app.call(env)
			end
		end

		def view_generate(data)
           temp=file_open("../log_file/views/display.html.erb")
           temp=ERB.new(temp)
           return temp.result(binding)
		end	

		def view_append(data)
			temp=file_open("../log_file/views/append.html.erb")
			temp=ERB.new(temp)
			return temp.result(binding)
		end	

		def file_open(name)
            File.open(File.expand_path(name,__FILE__),"r").read()
		end	

	end
end
