def correct_x?(num)
  if num.upcase.include? "X"
    puts num.upcase.index("X")
    puts num.length - 1
    return num.upcase.index("X") == num.length - 1
  end
  true
end


puts correct_x?("877 1 95 869x")  # ISBN-10
puts correct_x?("877195x869")  # bad ISBN number