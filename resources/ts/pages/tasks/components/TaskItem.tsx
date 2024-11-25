import React, { useState } from 'react'
import { Task } from '../../../types/Task'
import { useDeleteTask, useTask, useUpdateDoneTask, useUpdateTask } from '../../../queries/TaskQuery'
import { toast } from 'react-toastify'

type Props = {
    task: Task
}

const TaskItem: React.FC<Props> = ({ task }) => {
    const updateDoneTask = useUpdateDoneTask()
    const updateTask = useUpdateTask()
    const deleteTask = useDeleteTask()
    const [title, setTitle] = useState<string>(task.title)
    const [mode, setMode] = useState<string>('text')
    const { data: freshTask, refetch } = useTask(task.id)
    const changeMode = async () => {
        await refetch();
        if (freshTask) {
            setTitle(freshTask.title)
        }
        mode === 'text' ? setMode('input') : setMode('text')
    }
    const handleUpdateTask = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault()
        const newTask = { ...task, title: title }  // 他のプロパティをそのままコピーし、titleだけ更新
        updateTask.mutate(newTask)
        setMode('text')
    }
    const hadleDoneTask = () => {
        updateDoneTask.mutate(task)
    }
    const hadleDelete = () => {
        if (window.confirm('本当に削除しますか')) {
            deleteTask.mutate(task)
            //location.reload()
        } else {
            toast.success('削除はキャンセルされました')
        }
    }
    const inputMode = () => {
        return (
            <>
                <form onSubmit={handleUpdateTask}>
                    <input
                        type="text"
                        className="input"
                        value={title}
                        onChange={(e) => setTitle(e.target.value)}
                    />
                    <button className="btn is-update">更新</button>
                </form>
            </>
        )
    }
    const textMode = () => {
        return (
            <>
                {task.title}
                <button onClick={hadleDelete} className="btn is-delete">削除</button>
            </>
        )
    }
    return (
        <li key={task.id} className={task.is_done ? "done" : ""}>
            <label className="checkbox-label">
                <input
                    onClick={hadleDoneTask}
                    type="checkbox"
                    className="checkbox-input"
                />
            </label>
            <div onDoubleClick={changeMode}>
                {mode === 'text' ?
                    <span>{textMode()}</span>
                    :
                    <span>{inputMode()}</span>
                }
            </div>
        </li>
    )
}

export default TaskItem