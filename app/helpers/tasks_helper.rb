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

    def create_task_and_list task,list
        if is_invalid_names? task, list
                raise "Error"
        end
        list = list.strip
        task = task.strip
        list = current_user.lists.where(title: list).first_or_create
        rel = current_user.relationships.where(list_id: list.id).first_or_create

        task = list.tasks.create(content: task, order_number: list.tasks.count + 1 )
    end

    def is_invalid_names? task, list
        if task.nil? || list.nil?
            return true
        end
        return false
    end

end
