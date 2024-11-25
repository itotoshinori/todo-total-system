import React from 'react'
import TaskList from './components/TaskList'
import TaskInput from './components/TaskInput'

const index = () => {
    return (
        <div className="align-center">
            <TaskInput />
            <h1>タスク一覧</h1>
            <TaskList />
        </div>
    )
}

export default index
