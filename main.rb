require 'pry'

x_point, y_point, x, y = ARGV

if x_point == x && y_point == y
	puts 'Точка найдена!'
elsif x_point != x && y_point != y
	puts 'Близко, но нет!'
elsif x_point == x && y_point != y
	puts 'x координата верна, y нет'
elsif x_point != x && y_point == y
    puts 'y координата верна, x нет'
end

binding.pry