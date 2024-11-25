import { useMutation, useQuery, useQueryClient } from "react-query"
import * as api from "../api/TaskAPI"
import { toast } from "react-toastify"

const useTasks = () => {
    return useQuery('tasks', api.getTasks)
}

const useTask = (id: number) => {
    return useQuery(['task', id], () => api.getTask(id))
}

const useCreateTask = () => {
    const queryClient = useQueryClient()
    return useMutation(api.createTask, {
        onSuccess: () => {
            queryClient.invalidateQueries('tasks')
            toast.success('登録に成功しました')
        },
        onError: () => {
            toast.error('登録に失敗しました')
        }
    })
}

const useUpdateTask = () => {
    const queryClient = useQueryClient()
    return useMutation(api.updateTask,
        {
            onSuccess: () => {
                queryClient.invalidateQueries('tasks')
                toast.success('更新に成功しました')
            },
            onError: () => {
                toast.error('更新に失敗しました')
            }
        })
}

const useDeleteTask = () => {
    const queryClient = useQueryClient()
    return useMutation(api.deleteTask,
        {
            onSuccess: () => {
                queryClient.invalidateQueries('tasks')
                toast.success('削除に成功しました')
            },
            onError: () => {
                toast.error('削除に失敗しました')
            }
        })
}

const useUpdateDoneTask = () => {
    const queryClient = useQueryClient()
    return useMutation(api.updateDoneTask,
        {
            onSuccess: () => {
                queryClient.invalidateQueries('tasks')
                toast.success('更新に成功しました')
            },
            onError: () => {
                toast.error('更新に失敗しました')
            }
        })
}

export {
    useTasks,
    useTask,
    useCreateTask,
    useUpdateTask,
    useDeleteTask,
    useUpdateDoneTask
}