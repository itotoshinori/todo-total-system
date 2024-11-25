import { User } from "../types/User"
import axios from "axios"

const getUser = async () => {
    const { data } = await axios.get<User>('api/user')
    return data
}

const login = async ({ email, password }: { email: string, password: string }) => {
    const { data } = await axios.post<User>(
        `api/login`, { email, password }
    )
    return data
}

const logout = async () => {
    const { data } = await axios.post<User>(`api/logout`)
    return data
}

export {
    getUser,
    login,
    logout
}