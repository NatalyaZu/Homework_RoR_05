require 'pp'

class Developer
	MAX_TASKS = 10


	def initialize(name)
		@name = name
		@task_list = []
		@type
	end

	def max_tasks
		self.class::MAX_TASKS
	end

	def tasks
		@task_list.map.with_index{|t,i| puts "#{i+1}. #{t}"}.join("\n")
	end

	def add_task(task)
		raise ('Слишком много работы!') if @task_list.count >= max_tasks
		
		@task_list << task # @task.push(task)
		puts "#{@name}: добавлена задача #{task}. Всего в списке задач: #{@task_list.count} "
		
	end

	def work!
		puts "#{@name}: выполнена задача #{@task_list.shift}. Осталось задач: #{@task_list.count}"
		#begin
		  if @task_list.count == 0
		  	raise ArgumentError, "Нечего делать!"
		  end
		#rescue ArgumentError 
		#end
	end

	def status
		case 
		 when @task_list.count == 0
		 	puts 'свободен, давай еще работы'
		 when @task_list.count >= max_tasks
		 	puts 'занят, не трогай меня'
		 else
		 	puts 'задачи есть, но можно добавить еще, совсем немного' 
		 end
	end 
		
	def	can_add_task?
		if @task_list.count <= max_tasks
			puts true 
		else
			puts false 
		end
	end	

	def	can_work?
		if @task_list.count == 0
			puts false
		else
			puts true
		end
	end
end

class JuniorDeveloper < Developer
	MAX_TASKS = 5
	
	def work!
		raise "Слишком сложно!!!" if @task_list.length >= 20
		puts "#{@name}: пытаюсь делать задачу #{@task_list.shift}. Осталось задач: #{@task_list.count}"
	end
end

class SeniorDeveloper < Developer
	MAX_TASKS = 15

	def work!

	end
end


class Team
	MESSAGES = {
		report: '%s (%s): %s'
	}

	attr_reader :name, :juniors, :developers, :seniors

	def initialize(&block)
		@dev = []
		@seniors = []
		@developers = []
		@juniors = []
		@priority = []
		@dev_type = []
		@tasks = []
		instance_eval &block
	end

	def add_task(task)
		@tasks << task

		dev.add_task(task)

		block.call(dev, task)
	end

	def tasks
		@tasks.map.with_index{|t,i| puts "#{i+1}. #{t}"}.join("\n")
	end

	 def priority(*list)
	 	@priority = list
	 end

	 def make_developer(type,name)
	  	type.new(name)
	 end

	 def all
	 	@dev
	 end

	 def dev_type(*type)
	 	@dev_type = type
	 end

	 def report
	 	puts messages[:report] % [name, dev_type, tasks]
	 end


	private

	def messages
		self.class::MESSAGES
	end

	def have_seniors(*names)
		@seniors = names 
		@dev << @seniors.map!{|name| make_developer(SeniorDeveloper,name)}
	end

	def have_developers(*names)
		@developers = names
		@dev << @developers.map!{|name| make_developer(Developer,name)}
	end

	def have_juniors(*names)
		@juniors = names
		@dev << @juniors.map!{|name| make_developer(JuniorDeveloper,name)}
	end

	def on_task (type, &block)
		@dev_type[type] = block
	end

end

team = Team.new do 
	have_seniors 'Олег', 'Оксана'
	have_developers 'Олеся', 'Василий', 'Игорь-Богдан'
	have_juniors 'Владислава', 'Аркадий', 'Рамеш'
	priority :juniors, :developers, :seniors

	type :junior, :developer, :senior
	
	on_task :junior do |dev, task|
	  puts "Отдали задачу #{task} разработчику #{dev.name}, следите за ним!"
	end

	on_task :developer do |dev, task|
	 	puts "#{dev.name} делает хорошо выданную задачу #{task}!"
	end

	on_task :senior do |dev, task|
		puts "#{dev.name} сделает #{task}, но просит больше с такими глупостями не приставать!"
	end

end

p team.seniors
p team.developers #.map{|i| "#{i} @name=#{i.name}, @task_list=#{i.task_list}"}
p team.juniors
#puts team.all
team.add_task 'Погладить шнурки'

# dev = Developer.new('Наталья')
# jdev = JuniorDeveloper.new('Наталья')
# sdev = SeniorDeveloper.new('Наталья')

# dev.add_task('"Полить кактус"')

# puts dev.tasks
# dev.can_add_task?
# dev.status
# #dev.can_work?

# jdev.add_task('"Полить кактус"')
# jdev.work!

# sdev.add_task('"Полить кактус"')




