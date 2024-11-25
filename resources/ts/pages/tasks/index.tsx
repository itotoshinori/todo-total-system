import React from 'react'
import TaskList from './components/TaskList'
import TaskInput from './components/TaskInput'

const index = () => {
    return (
        <div className="align-center">
            <TaskInput />
            <h1>タスク</h1>
            <TaskList />
        </div>
    )
}

export default index
