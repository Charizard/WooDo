module TasksHelper

    def move_after_destroy(list,to_destroy)
        task_count = list.tasks.count
        all_tasks = list.tasks
        to_destroy.destroy
        ((to_destroy.order_number)+1).upto(task_count) do |order_num|
            task = Task.find_by_list_id_and_order_number(list.id,order_num)
            task.order_number = order_num - 1
            task.save
        end
    end

end
