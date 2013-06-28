module ListsHelper

    def rearrange_within_list list_id, from_order, to_order
        if from_order > to_order
            temp_task = Task.find_by_list_id_and_order_number(list_id, from_order)
            temp_task.order_number = -1
            temp_task.save
            (from_order-1).downto(to_order) do |i|
                task = Task.find_by_list_id_and_order_number(list_id, i)
                task.order_number = i+1
                task.save
            end
        else
            temp_task = Task.find_by_list_id_and_order_number(list_id, from_order)
            temp_task.order_number = -1
            temp_task.save
            (from_order+1).upto(to_order) do |i|
                task = Task.find_by_list_id_and_order_number(list_id, i)
                task.order_number = i-1
                task.save
            end
        end
        final_task = temp_task.dup
        final_task.order_number = to_order
        temp_task.destroy
        final_task.save
    end

end
