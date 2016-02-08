class Developer
	MAX_TASKS = 10


	def initialize(name)
		@name = name
		@task_list = []
		@text_length = 0
	end

	def max_tasks
		self.class::MAX_TASKS
	end

	def tasks
		@task_list.map.with_index{|t,i| puts "#{i+1}. #{t}"}.join("\n")
	end

	def add_task(task)
		raise ('Слишком много работы!') if @task_list.count >= max_tasks
		
		@task_list << task #.push(task)
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
			puts "tasks: #{@task_list.count} >> true" 
		else
			puts "tasks: #{@task_list.count} >> false" 
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


dev = Developer.new('Наталья')
jdev = JuniorDeveloper.new('Наталья')
sdev = SeniorDeveloper.new('Наталья')

dev.add_task('"Полить кактус"')

puts dev.tasks
dev.can_add_task?
dev.status
dev.work!
dev.can_work?

jdev.add_task('"Полить кактус"')
jdev.work!

sdev.add_task('"Полить кактус"')




