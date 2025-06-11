import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import HomePage from './components/Home/HomePage'
import AuthForm from './components/Auth/AuthForm'

const PrivateRoute = ({ children }) => {
  const isLoggedIn = localStorage.getItem('isLoggedIn')
  return isLoggedIn ? children : <Navigate to="/" />
}

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<AuthForm />} />
        <Route path="/home" element={
          <PrivateRoute>
            <HomePage />
          </PrivateRoute>
        } />
      </Routes>
    </Router>
  )
}

export default App
