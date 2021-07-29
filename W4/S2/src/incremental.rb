# frozen_string_literal: true

class Incremental
  def increment(array)
    i = array.length - 1
    array[i] += 1

    while array[i] >= 9 && i >= 0
      array[i] = 0
      if i.zero?
        array.unshift(1)
      else
        array[i - 1] += 1
      end
      i -= 1
    end

    array
  end
end
