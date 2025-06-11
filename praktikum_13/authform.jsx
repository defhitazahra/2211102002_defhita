import React, { useState } from 'react';
import './AuthForm.css';

const AuthForm = () => {
  const [isLoginActive, setIsLoginActive] = useState(false);

  const toggleForm = () => {
    setIsLoginActive(!isLoginActive);
  };

  return (
    <div className={`auth-container ${isLoginActive ? 'login-active' : ''}`}>
      <div className="form-container">
        {/* Registration Form */}
        <div className="register-form">
          <h2>Registrasi</h2>
          <form>
            <div className="form-group">
              <input type="text" placeholder="Nama" required />
            </div>
            <div className="form-group">
              <input type="email" placeholder="Email" required />
            </div>
            <div className="form-group">
              <input type="password" placeholder="Kata Sandi" required />
            </div>
            <div className="form-group">
              <input type="password" placeholder="Konfirmasi Kata Sandi" required />
            </div>
            <button type="submit" className="submit-btn">Daftar</button>
          </form>
        </div>

        {/* Login Form */}
        <div className="login-form">
          <h2>Login</h2>
          <form>
            <div className="form-group">
              <input type="email" placeholder="Email" required />
            </div>
            <div className="form-group">
              <input type="password" placeholder="Kata Sandi" required />
            </div>
            <button type="submit" className="submit-btn">Masuk</button>
          </form>
        </div>

        {/* Overlay */}
        <div className="overlay-container">
          <div className="overlay">
            <div className="overlay-panel overlay-left">
              <h2>Sudah punya akun?</h2>
              <p>Masuk dengan akun Anda untuk melanjutkan</p>
              <button className="ghost-btn" onClick={toggleForm}>Login</button>
            </div>
            <div className="overlay-panel overlay-right">
              <h2>Belum punya akun?</h2>
              <p>Daftar sekarang untuk mulai menggunakan layanan kami</p>
              <button className="ghost-btn" onClick={toggleForm}>Daftar</button>
            </div>
          </div>
        </div>
      </div>

      {/* Mobile Toggle */}
      <div className="mobile-toggle">
        <button onClick={toggleForm}>
          {isLoginActive ? 'Belum punya akun? Daftar' : 'Sudah punya akun? Login'}
        </button>
      </div>
    </div>
  );
};

export default AuthForm;
