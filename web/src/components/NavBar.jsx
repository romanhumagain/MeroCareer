
import React from 'react';
import app_logo from '../assets/app_logo.png'
import { Link } from 'react-router-dom';

const Navbar = () => {
  return (
    <nav className="px-6 py-4 text-white bg-slate-900">
      <div className="container flex items-center mx-auto">
      <Link to = '/'>
        <div className="flex items-center space-x-4">
          <img src={app_logo} alt="Logo" className="w-8 h-8" />
          <span className="text-2xl font-bold">MeroCareer</span>
        </div>
      </Link>
      </div>
    </nav>
  );
};

export default Navbar;
