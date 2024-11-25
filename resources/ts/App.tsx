import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import Router from './Router'
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { QueryClient, QueryClientProvider } from 'react-query';
import { AuthProvider } from './hooks/AuthContext';

const queryClient = new QueryClient({
    defaultOptions: {
        queries: {
            retry: false
        },
        mutations: {
            retry: false
        }
    }
});

const App: React.FC = () => {
    return (
        <div>
            <AuthProvider>
                <QueryClientProvider client={queryClient}>
                    <BrowserRouter>
                        <Router />
                        <ToastContainer
                            hideProgressBar={true}
                            closeOnClick
                            theme="colored"
                        />
                    </BrowserRouter>
                </QueryClientProvider>
            </AuthProvider>
        </div>
    );
};

export default App;
