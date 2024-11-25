import React, { useState } from 'react'
import { useCreateTask } from '../../../queries/TaskQuery'

const TaskInput: React.FC = () => {
    const [title, setTitle] = useState('')
    const createTask = useCreateTask()
    const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault()
        console.log(title)
        createTask.mutate(title)
        setTitle('')
    }
    return (
        <>
            <form className="input-form" onSubmit={handleSubmit}>
                <div className="inner">
                    <input
                        type="text"
                        className="input"
                        placeholder="TODOを入力して。"
                        value={title}
                        onChange={(e) => setTitle(e.target.value)}
                    />
                    <button
                        disabled={!title}
                        style={{
                            backgroundColor: !title ? '#e2e6e7' : '',
                            transform: !title ? 'none' : ''
                        }}
                        className="btn is-primary">
                        追加
                    </button>
                </div>
            </form>
        </>
    )
}

export default TaskInput