import { useMutation, useQuery } from "react-query"
import * as api from "../api/AuthAPI"
import { toast } from "react-toastify"
import { useAuth } from "../hooks/AuthContext"
import { useNavigate } from "react-router-dom"
import { useQueryClient } from "react-query"

const useUser = () => {
    return useQuery('users', api.getUser)
}

const useLogin = () => {
    const { setIsAuth } = useAuth()
    const navigate = useNavigate();
    return useMutation(api.login, {
        onSuccess: (user) => {
            if (user) {
                //console.log(user)
                setIsAuth(true)
            }
            navigate('/');
            toast.success('ログインに成功しました')
        },
        onError: () => {
            toast.error('ログインに失敗しました')
        }
    })
}

const useLogout = () => {
    const { setIsAuth } = useAuth()
    const queryClient = useQueryClient();
    const navigate = useNavigate();
    return useMutation(api.logout, {
        onSuccess: (user) => {
            if (!user) {
                //console.log(user)
                setIsAuth(false)
            }
            queryClient.removeQueries('users')
            navigate('/login');
            toast.success('ログアウトに成功しました')
            location.reload()
        },
        onError: () => {
            toast.error('ログアウトに失敗しました')
        }
    })
}

export {
    useUser,
    useLogin,
    useLogout,
}