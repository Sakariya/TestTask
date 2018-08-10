###
require 'json'
@filename = 'students.json'
def addStudent()
    printf "Enter student name :"
    studName = gets.chomp
    printf "Enter student grade :"
    studGrade = gets.chomp

    if File.exist?(@filename)
        file = File.read(@filename)
        students_hash = JSON.parse(file)
    else 
        students_hash = []        
    end

    match_index = students_hash.find_index {|h| h['grade'] == studGrade }
    if match_index        
        students_hash[match_index]['students'].push(studName)
    else
        students_hash << {grade: studGrade, students: [studName]}
    end
    File.open("students.json", "w") do |f|     
        f.write(students_hash.to_json)   
    end
end
   
def getStudentsList()
    if File.exist?(@filename)
        file = File.read(@filename)
        students_hash = JSON.parse(file)
        printf "Enter student grade :"
        studGrade = gets.chomp
        match_index = students_hash.find_index {|h| h['grade'] == studGrade }
        if match_index
            puts  students_hash[match_index]['students'].join(", ")
        else
            puts "Grade #{studGrade} is not found."
        end
    else 
        puts 'Please add student first' 
    end   
end
   
def sortStudents()
    if File.exist?(@filename)
        file = File.read(@filename)
        students_hash = JSON.parse(file)
        sortGrade = students_hash.sort_by { |hsh| hsh['grade'] }
        sortGrade.each do |s|
            sortStudent = s['students'].sort_by { |hsh| hsh.downcase }
            puts "Grade #{s['grade']}: #{sortStudent.join(", ")}"
        end
    else 
        puts 'Please add student first' 
    end
end
   
loop do
   
    printf "Enter \n
             1-Add a student\'s name to the roster for a grade.\n
             2-Get a list of all students enrolled in a grade.\n
             3-Get a sorted list of all students in all grades.\n
             4-Exit\n : "
   
    a=STDIN.gets
    b=a.to_i
   
    case b
   
        when 1
            addStudent()
   
        when 2
            getStudentsList()            
   
        when 3
            sortStudents()
   
        when 4
            File.delete(@filename) if File.exist?(@filename)
            exit
   
        else
            puts "Wrong Entry"
    end
end
   
   