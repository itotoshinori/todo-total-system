import React, { useEffect } from 'react';

import NotFound from './pages/NotFound';
import Task from './pages/tasks/index';
import Login from './pages/login/index';
import Help from './pages/help/index';
import { Routes, Route, Link, useNavigate } from 'react-router-dom';
import { useLogout, useUser } from './queries/AuthQuery';
import { useAuth } from './hooks/AuthContext';

const Router: React.FC = () => {
    const logout = useLogout()
    const { isAuth, setIsAuth } = useAuth()
    const { isLoading, data: authUser } = useUser()
    const navigate = useNavigate();
    useEffect(() => {
        if (authUser) {
            setIsAuth(true)
        }
    }, [authUser])
    const navigation = (
        <header className="global-head">
            <ul>
                <li>
                    <Link to="/">タスク</Link>
                </li>
                <li onClick={() => logout.mutate()}>
                    <span>ログアウト</span>
                </li>
                <li>
                    <Link to="/help">ヘルプ</Link>
                </li>
            </ul>
        </header>
    );
    const loginNavigation = (
        <header className="global-head">
            <ul>
                <li>
                    <Link to="/login">ログイン</Link>
                </li>
                <li>
                    <Link to="/help">ヘルプ</Link>
                </li>
            </ul>
        </header>
    );
    if (isLoading) return <div className="loader"></div>
    return (
        <>
            {isAuth ? navigation : loginNavigation}
            <Routes>
                <Route path="/" element={<Task />} />
                <Route path="/login" element={<Login />} />
                <Route path="/help" element={<Help />} />
                <Route path="*" element={<NotFound />} />
            </Routes>
        </>
    );
}

export default Router;