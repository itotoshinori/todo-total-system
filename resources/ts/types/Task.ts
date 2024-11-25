export type Task = {
    body: string,
    finishday: Date,
    id: number,
    is_done: boolean,
    link: string | null,
    link_name: string | null,
    term: Date,
    title: string,
    user_id: number,
    updated_at: Date,
    created_at: Date
}