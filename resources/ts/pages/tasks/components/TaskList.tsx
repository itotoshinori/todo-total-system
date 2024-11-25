import React from 'react'
import TaskItem from './TaskItem'
import { Task } from '../../../types/Task'
import { useTasks } from '../../../queries/TaskQuery'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../../../hooks/AuthContext'

const TaskList: React.FC = () => {
    const { data: tasks, status } = useTasks()
    const { isAuth } = useAuth()
    const navigate = useNavigate()
    if (!isAuth) {
        navigate('/login');
    }
    if (status === 'loading') {
        return <div className="loading" />
    } else if (status === 'error') {
        return <div className="align-center">読み込みに失敗しました・ログインして下さい。</div>
    } else if (!tasks || tasks.length === 0) {
        return <div className="align-center">データの取得に失敗しました</div>
    }
    return (
        <div className="inner">
            <ul className="task-list">
                {tasks.map((task: Task) => (
                    <TaskItem task={task} />
                ))}
            </ul>
        </div>
    )
}

export default TaskList