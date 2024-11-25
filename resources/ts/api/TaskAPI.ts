import { Task } from "../types/Task"
import axios from "axios"

const getTasks = async () => {
    const { data } = await axios.get<Task[]>('api/tasks')
    return data
}

const getTask = async (id: number): Promise<Task> => {
    const { data } = await axios.get<Task>(`api/tasks/${id}`)
    return data
}

const createTask = async (title: string) => {
    const { data } = await axios.post<Task>(
        `api/tasks`, { title: title }
    )
    return data
}

const updateTask = async ({ id, title }: Task) => {
    const { data } = await axios.patch<Task>(
        `api/tasks/${id}`,
        { title: title }
    )
    return data
}

const deleteTask = async ({ id }: Task) => {
    const { data } = await axios.delete<Task>(
        `api/tasks/${id}`
    )
    return data
}

const updateDoneTask = async ({ id, is_done }: Task) => {
    const { data } = await axios.patch<Task>(
        `api/tasks/updatedone/${id}`,
        { is_done: !is_done }
    )
    return data
}

export {
    getTasks,
    getTask,
    createTask,
    updateTask,
    deleteTask,
    updateDoneTask
}